-- =========================================
-- Project: Manual Weighing Control Dashboard
-- Description: SQL queries used to monitor manual truck weighing operations,
-- including approval flow, operational delays, and recurring manual weighing scenarios.
-- =========================================



-- =========================================
-- 1. Manual Weighing Records (With Integration Filters)
-- =========================================

SELECT
    w.load_number,
    CASE w.direction_type
        WHEN 'OUT' THEN 'Outbound'
        WHEN 'IN' THEN 'Inbound'
        ELSE 'Not Informed'
    END AS direction,
    w.is_first_weighing_manual,
    w.is_second_weighing_manual,
    p.product_name,
    approval.approver_name,
    approval.manual_reason,
    b.business_unit_name,
    CONVERT(DATE, DATEADD(HOUR, -1,
        CASE
            WHEN w.is_second_weighing_manual = '1' THEN w.second_weighing_datetime
            ELSE w.first_weighing_datetime
        END AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
    )) AS weighing_date,
    CONVERT(TIME, DATEADD(HOUR, -1,
        CASE
            WHEN w.is_second_weighing_manual = '1' THEN w.second_weighing_datetime
            ELSE w.first_weighing_datetime
        END AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
    )) AS weighing_time,
    CONVERT(DATE, DATEADD(HOUR, -1,
        CASE
            WHEN w.is_second_weighing_manual = '1' THEN w.second_approval_datetime
            ELSE w.first_approval_datetime
        END AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
    )) AS approval_date,
    CONVERT(TIME, DATEADD(HOUR, -1,
        CASE
            WHEN w.is_second_weighing_manual = '1' THEN w.second_approval_datetime
            ELSE w.first_approval_datetime
        END AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
    )) AS approval_time,
    DATEDIFF(MINUTE,
        DATEADD(HOUR, -1,
            CASE
                WHEN w.is_second_weighing_manual = '1' THEN w.second_weighing_datetime
                ELSE w.first_weighing_datetime
            END AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
        ),
        DATEADD(HOUR, -1,
            CASE
                WHEN w.is_second_weighing_manual = '1' THEN w.second_approval_datetime
                ELSE w.first_approval_datetime
            END AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
        )
    ) AS approval_time_minutes
FROM truck_weighing w
LEFT JOIN business_units b ON b.business_unit_id = w.business_unit_id
LEFT JOIN users u1 ON u1.user_id = w.first_approval_user_id
LEFT JOIN users u2 ON u2.user_id = w.second_approval_user_id
LEFT JOIN products p ON p.product_id = w.product_id
OUTER APPLY (
    SELECT u1.user_name AS approver_name, w.first_manual_reason AS manual_reason
    WHERE w.first_approval_user_id IS NOT NULL

    UNION ALL

    SELECT u2.user_name AS approver_name, w.second_manual_reason AS manual_reason
    WHERE w.second_approval_user_id IS NOT NULL
) approval
WHERE '1' IN (w.is_first_weighing_manual, w.is_second_weighing_manual)
  AND w.deleted_at IS NULL
  AND w.status_code = 'COMPLETED'
  AND w.erp_document IS NOT NULL
  AND (
        w.first_approval_user_id IS NOT NULL
        OR w.second_approval_user_id IS NOT NULL
      )



-- =========================================
-- 2. Manual Weighing Records (Without Integration Filters)
-- =========================================

SELECT
    w.load_number,
    CASE w.direction_type
        WHEN 'OUT' THEN 'Outbound'
        WHEN 'IN' THEN 'Inbound'
        ELSE 'Not Informed'
    END AS direction,
    w.is_first_weighing_manual,
    w.is_second_weighing_manual,
    p.product_name,
    approval.approver_name,
    approval.manual_reason,
    b.business_unit_name,
    CONVERT(DATE, DATEADD(HOUR, -1,
        CASE
            WHEN w.is_second_weighing_manual = '1' THEN w.second_weighing_datetime
            ELSE w.first_weighing_datetime
        END AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
    )) AS weighing_date,
    CONVERT(TIME, DATEADD(HOUR, -1,
        CASE
            WHEN w.is_second_weighing_manual = '1' THEN w.second_weighing_datetime
            ELSE w.first_weighing_datetime
        END AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
    )) AS weighing_time,
    CONVERT(DATE, DATEADD(HOUR, -1,
        CASE
            WHEN w.is_second_weighing_manual = '1' THEN w.second_approval_datetime
            ELSE w.first_approval_datetime
        END AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
    )) AS approval_date,
    CONVERT(TIME, DATEADD(HOUR, -1,
        CASE
            WHEN w.is_second_weighing_manual = '1' THEN w.second_approval_datetime
            ELSE w.first_approval_datetime
        END AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
    )) AS approval_time,
    DATEDIFF(MINUTE,
        DATEADD(HOUR, -1,
            CASE
                WHEN w.is_second_weighing_manual = '1' THEN w.second_weighing_datetime
                ELSE w.first_weighing_datetime
            END AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
        ),
        DATEADD(HOUR, -1,
            CASE
                WHEN w.is_second_weighing_manual = '1' THEN w.second_approval_datetime
                ELSE w.first_approval_datetime
            END AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
        )
    ) AS approval_time_minutes
FROM truck_weighing w
LEFT JOIN business_units b ON b.business_unit_id = w.business_unit_id
LEFT JOIN users u1 ON u1.user_id = w.first_approval_user_id
LEFT JOIN users u2 ON u2.user_id = w.second_approval_user_id
LEFT JOIN products p ON p.product_id = w.product_id
OUTER APPLY (
    SELECT u1.user_name AS approver_name, w.first_manual_reason AS manual_reason
    WHERE w.first_approval_user_id IS NOT NULL

    UNION ALL

    SELECT u2.user_name AS approver_name, w.second_manual_reason AS manual_reason
    WHERE w.second_approval_user_id IS NOT NULL
) approval
WHERE '1' IN (w.is_first_weighing_manual, w.is_second_weighing_manual)
  AND w.deleted_at IS NULL
  AND w.status_code = 'COMPLETED'
  AND (
        w.first_approval_user_id IS NOT NULL
        OR w.second_approval_user_id IS NOT NULL
      )



-- =========================================
-- 3. Manual Weighing Operational Details
-- =========================================

SELECT
    w.load_number,
    CASE w.direction_type
        WHEN 'OUT' THEN 'Outbound'
        WHEN 'IN' THEN 'Inbound'
        ELSE 'Not Informed'
    END AS direction,
    unified.operator_name,
    unified.product_name,
    w.is_first_weighing_manual AS first_weighing_manual,
    w.is_second_weighing_manual AS second_weighing_manual,
    unified.business_unit_name,
    CONVERT(DATE, DATEADD(HOUR, -1,
        w.first_weighing_datetime AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
    )) AS first_weighing_date,
    CONVERT(TIME, DATEADD(HOUR, -1,
        w.first_weighing_datetime AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
    )) AS first_weighing_time,
    CONVERT(DATE, DATEADD(HOUR, -1,
        w.second_weighing_datetime AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
    )) AS second_weighing_date,
    CONVERT(TIME, DATEADD(HOUR, -1,
        w.second_weighing_datetime AT TIME ZONE 'UTC' AT TIME ZONE 'E. South America Standard Time'
    )) AS second_weighing_time
FROM truck_weighing w
LEFT JOIN business_units b ON b.business_unit_id = w.business_unit_id
LEFT JOIN users u1 ON u1.user_id = w.first_weighing_user_id
LEFT JOIN users u2 ON u2.user_id = w.second_weighing_user_id
LEFT JOIN products p ON p.product_id = w.product_id
OUTER APPLY (
    SELECT u1.user_name AS operator_name, b.business_unit_name, p.product_name
    WHERE w.first_weighing_user_id IS NOT NULL
      AND w.first_weighing_user_id <> w.second_weighing_user_id

    UNION ALL

    SELECT u2.user_name AS operator_name, NULL, NULL
    WHERE w.second_weighing_user_id IS NOT NULL
      AND w.first_weighing_user_id <> w.second_weighing_user_id

    UNION ALL

    SELECT u2.user_name AS operator_name, b.business_unit_name, p.product_name
    WHERE w.second_weighing_user_id IS NOT NULL
      AND (
            w.first_weighing_user_id = w.second_weighing_user_id
            OR w.first_weighing_user_id IS NULL
          )
) unified
WHERE w.deleted_at IS NULL
  AND w.status_code = 'COMPLETED'
ORDER BY w.first_weighing_datetime DESC;