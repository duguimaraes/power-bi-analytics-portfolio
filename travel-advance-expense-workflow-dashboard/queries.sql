-- =========================================
-- Project: Travel Advance & Expense Workflow Dashboard
-- Description: Unified query combining travel request data with
-- workflow status, current activity, and responsible user.
-- =========================================

WITH latest_requests AS (
    SELECT
        r.request_id,
        r.document_id,
        r.version_number,
        r.request_date,
        r.request_number,
        r.requester_name,
        r.requester_document,
        r.business_unit,
        r.department,
        r.travel_start_date,
        r.travel_end_date,
        r.total_travel_days,
        r.request_type,
        r.advance_amount,
        r.bank_name,
        r.bank_branch,
        r.bank_account,
        r.advance_justification,
        r.advance_period_start,
        r.advance_period_end,
        r.amount_difference,
        r.travel_occurrences,
        r.decision_status,
        r.decision_flag,
        r.debtor_role,
        r.origin_city,
        r.destination_city,
        r.advance_reason,
        r.travel_reason,
        wf.process_number,
        wf.workflow_status,
        wf.requester_employee_id
    FROM travel_requests r
    INNER JOIN (
        SELECT
            document_id,
            MAX(version_number) AS latest_version
        FROM travel_requests
        GROUP BY document_id
    ) latest
        ON r.document_id = latest.document_id
       AND r.version_number = latest.latest_version
    INNER JOIN workflow_processes wf
        ON wf.request_document_id = r.document_id
    WHERE r.request_type IN ('Advance', 'Expense Report')
      AND r.request_number NOT IN ('REQUEST_EXCLUDED')
      AND wf.workflow_status IN ('Open', 'Completed')
),

current_workflow AS (
    SELECT
        wf.process_number,
        req.requester_full_name,
        ISNULL(resp.user_full_name, 'Task Stopped in Group Queue') AS current_responsible,
        CASE previous_steps.selected_step_code
            WHEN '115' THEN 'Advance Approval'
            WHEN '121' THEN 'Advance Rejected'
            WHEN '119' THEN 'Purchase Request'
            WHEN '133' THEN 'Invoices and Accounts Payable'
            WHEN '130' THEN 'Missing Information'
            WHEN '137' THEN 'Missing Information'
            WHEN '141' THEN 'Expense Report'
            WHEN '143' THEN 'Expense Report Approval'
            WHEN '148' THEN 'Request Adjustment'
            WHEN '154' THEN 'Invoices and Accounts Payable'
            WHEN '151' THEN 'Missing Information'
            WHEN '158' THEN 'Missing Information'
            WHEN '180' THEN 'Payroll Deduction'
            WHEN '163' THEN 'Value Return'
            WHEN '165' THEN 'Return Validation'
            WHEN '92'  THEN 'Missing Information'
            WHEN '90'  THEN 'Missing Information'
            WHEN '44'  THEN 'Expense Report'
            WHEN '7'   THEN 'Expense Report'
            WHEN '19'  THEN 'Expense Report'
            WHEN '46'  THEN 'Expense Report Approval'
            WHEN '48'  THEN 'Purchase Request'
            WHEN '68'  THEN 'Invoices and Accounts Payable'
            WHEN '11'  THEN 'Missing Receipts'
            WHEN '102' THEN 'Invoices and Accounts Payable'
            WHEN '93'  THEN 'Invoices and Accounts Payable'
            WHEN '25'  THEN 'Invoices and Accounts Payable'
            WHEN '106' THEN 'Reimbursement Validation'
            WHEN '17'  THEN 'Expense Report'
            WHEN '135' THEN 'Expense Report'
            WHEN '111' THEN 'Reimbursement Validation'
            WHEN '117' THEN 'Purchase Request'
            WHEN '27'  THEN 'Value Return'
            WHEN '21'  THEN 'Request Adjustment'
            WHEN '156' THEN 'Value Return'
            WHEN '167' THEN 'Value Return'
            WHEN '150' THEN 'Request Adjustment'
            WHEN '152' THEN 'Missing Information'
            WHEN '145' THEN 'Request Adjustment'
            WHEN '95'  THEN 'Purchase Request'
            WHEN '98'  THEN 'Invoices and Accounts Payable'
            ELSE CONVERT(VARCHAR, previous_steps.selected_step_code)
        END AS current_activity,
        FORMAT(CAST(task.assignment_start_date AS DATETIME2), 'dd/MM/yyyy HH:mm') AS responsible_since,
        task.assignment_start_date
    FROM (
        SELECT *
        FROM workflow_tasks
        WHERE assigned_user_id <> 'system_auto'
    ) task
    OUTER APPLY (
        SELECT selected_step_code
        FROM (
            SELECT
                selected_step_code,
                ROW_NUMBER() OVER (
                    PARTITION BY process_number
                    ORDER BY task_sequence DESC
                ) AS row_num
            FROM workflow_tasks
            WHERE process_number = task.process_number
              AND selected_step_code IS NOT NULL
        ) step_history
        WHERE step_history.row_num = 2
    ) previous_steps
    INNER JOIN workflow_processes wf
        ON wf.process_number = task.process_number
    LEFT JOIN (
        SELECT
            ut.user_code AS employee_id,
            u.full_name AS user_full_name
        FROM user_tenant ut
        INNER JOIN system_users u
            ON ut.user_id = u.user_id
    ) resp
        ON resp.employee_id = task.assigned_user_id
    LEFT JOIN (
        SELECT
            ut.user_code AS employee_id,
            u.full_name AS requester_full_name
        FROM user_tenant ut
        INNER JOIN system_users u
            ON ut.user_id = u.user_id
    ) req
        ON req.employee_id = wf.requester_employee_id
    WHERE task.is_active_log = 1
      AND wf.workflow_status IN ('Open', 'Completed')
)

SELECT
    lr.request_id,
    lr.document_id,
    lr.version_number,
    lr.process_number,
    lr.request_date,
    lr.request_number,
    COALESCE(cw.requester_full_name, lr.requester_name) AS requester_name,
    lr.requester_document,
    lr.business_unit,
    lr.department,
    lr.travel_start_date,
    lr.travel_end_date,
    lr.total_travel_days,
    lr.request_type,
    lr.advance_amount,
    lr.bank_name,
    lr.bank_branch,
    lr.bank_account,
    lr.advance_justification,
    lr.advance_period_start,
    lr.advance_period_end,
    lr.amount_difference,
    lr.travel_occurrences,
    lr.decision_status,
    lr.decision_flag,
    lr.debtor_role,
    lr.origin_city,
    lr.destination_city,
    lr.advance_reason,
    lr.travel_reason,
    lr.workflow_status,
    cw.current_responsible,
    cw.current_activity,
    cw.responsible_since,
    cw.assignment_start_date
FROM latest_requests lr
LEFT JOIN current_workflow cw
    ON cw.process_number = lr.process_number
ORDER BY lr.request_date DESC, lr.request_number DESC;