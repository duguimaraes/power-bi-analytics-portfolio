-- =========================================
-- Project: IT SLA Dashboard
-- Description: SQL queries used for SLA analysis, runtime evaluation, and satisfaction metrics
-- =========================================


-- =========================================
-- 1. Main Ticket Workflow Extraction
-- Description: Retrieves latest version of service requests and links workflow + assignment data
-- =========================================

SELECT 
    wf.process_id,
    req.requester_name,
    req.ticket_type,
    req.ticket_title,
    wf.workflow_status,
    req.business_unit,
    ISNULL(assignee.analyst_id, 'Waiting for Assignment') AS analyst_id,
    COALESCE(assignee.assignment_start_date, wf.process_start_date) AS start_date,
    assignee.assignment_end_date,
    assignee.total_runtime,
    req.priority,
    req.system_name,
    req.service_category,
    req.incident_category,
    req.incident_justification,
    req.is_project_related,
    req.waiting_for_third_party,
    req.corrective_reason,
    req.access_type,
    req.purchase_type,
    req.purchase_item,
    req.access_issue_type,
    req.unavailable_resource,
    req.installation_reason,
    req.maintenance_type,
    req.billing_impact,
    req.project_name
FROM service_requests req
INNER JOIN (
    SELECT 
        document_id, 
        MAX(version_number) AS latest_version
    FROM service_requests
    GROUP BY document_id
) latest_req 
    ON req.document_id = latest_req.document_id
   AND req.version_number = latest_req.latest_version
INNER JOIN workflow_processes wf
    ON wf.request_document_id = req.document_id
LEFT JOIN (
    SELECT 
        t.process_id,
        t.analyst_id,
        t.assignment_start_date,
        t.assignment_end_date,
        t.total_runtime
    FROM workflow_tasks t
    INNER JOIN (
        SELECT 
            process_id,
            MAX(task_sequence) AS latest_task_sequence
        FROM workflow_tasks
        WHERE analyst_id IN (
            'analyst_01',
            'analyst_02',
            'analyst_03',
            'analyst_04',
            'analyst_05'
        )
        AND analyst_id NOT IN ('system_auto')
        AND analyst_id NOT LIKE 'queue%'
        AND (
            task_notes IS NULL
            OR task_notes = ''
            OR task_notes NOT LIKE '%Task automatically assigned%'
        )
        GROUP BY process_id
    ) latest_task
        ON t.process_id = latest_task.process_id
       AND t.task_sequence = latest_task.latest_task_sequence
    WHERE t.analyst_id IN (
        'analyst_01',
        'analyst_02',
        'analyst_03',
        'analyst_04',
        'analyst_05'
    )
    AND t.analyst_id NOT IN ('system_auto')
    AND t.analyst_id NOT LIKE 'queue%'
    AND (
        t.task_notes IS NULL
        OR t.task_notes = ''
        OR t.task_notes NOT LIKE '%Task automatically assigned%'
    )
) assignee
    ON assignee.process_id = wf.process_id
WHERE wf.workflow_status IN ('Open', 'Completed');



-- =========================================
-- 2. Runtime Analysis for IT Tickets
-- Description: Identifies tickets with high resolution time
-- =========================================

SELECT
    t.process_id,
    t.analyst_id,
    t.total_runtime,
    wf.process_start_date
FROM workflow_tasks t
INNER JOIN workflow_processes wf
    ON wf.process_id = t.process_id
INNER JOIN service_requests req
    ON req.process_id = t.process_id
WHERE 
    t.analyst_id NOT IN ('system_auto')
    AND wf.process_type = 'IT_Request'
    AND t.analyst_id IN (
        'analyst_01',
        'analyst_02',
        'analyst_03',
        'analyst_04',
        'analyst_05'
    )
    AND t.analyst_id NOT LIKE 'queue%'
    AND wf.process_start_date >= '2025-01-01'
    AND wf.workflow_status = 'Completed'
    AND t.total_runtime >= 200
    AND req.waiting_for_third_party <> 'yes'
    AND req.is_project_related <> 'yes'
ORDER BY
    t.process_id,
    t.task_sequence;



-- =========================================
-- 3. Closed Ticket Satisfaction Analysis
-- Description: Extracts satisfaction survey responses for completed IT tickets
-- =========================================

SELECT
    req.process_id,
    req.requester_name,
    req.ticket_status,
    req.business_unit,
    req.ticket_type,
    req.analyst_service_rating,
    req.service_satisfaction,
    req.communication_clarity_rating,
    req.solution_effectiveness_rating,
    wf.workflow_status
FROM service_requests req
INNER JOIN (
    SELECT 
        document_id,
        MAX(version_number) AS latest_version
    FROM service_requests
    GROUP BY document_id
) latest_req
    ON req.document_id = latest_req.document_id
   AND req.version_number = latest_req.latest_version
INNER JOIN workflow_processes wf
    ON wf.request_document_id = req.document_id
WHERE wf.workflow_status = 'Completed'
  AND req.ticket_type IN ('Access', 'System', 'Infrastructure', 'Data')
  AND (
        req.analyst_service_rating <> 'Not Answered'
        OR req.service_satisfaction <> 'Not Answered'
      );