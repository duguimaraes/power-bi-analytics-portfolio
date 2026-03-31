-- =========================================
-- Project: Busa Operational Downtime Dashboard
-- Description: Extracts downtime events with duration, component,
-- cause and operational context for industrial equipment.
-- =========================================

SELECT 
  s.session_number,
  s.status,
  s.shift,
  d.downtime_number,
  
  date_format(from_iso8601_timestamp(d.start_datetime), '%d/%m/%Y %H:%i:%s') AS start_datetime,
  date_format(from_iso8601_timestamp(d.end_datetime),   '%d/%m/%Y %H:%i:%s') AS end_datetime,
  
  mt.motive_name      AS motive,
  ct.component_name   AS component,
  cs.cause_name       AS cause,
  bu.business_unit    AS facility,
  se.season_code      AS season,
  
  COALESCE(d.downtime_percentage, 0) AS downtime_percentage,

  -- total downtime (minutes)
  CAST(
    date_diff(
      'second',
      from_iso8601_timestamp(d.start_datetime) AT TIME ZONE 'America/Cuiaba',
      from_iso8601_timestamp(d.end_datetime)   AT TIME ZONE 'America/Cuiaba'
    ) AS double
  ) / 60.0 AS total_minutes,

  -- effective downtime (applies %)
  CAST(
    (
      CAST(
        date_diff(
          'second',
          from_iso8601_timestamp(d.start_datetime) AT TIME ZONE 'America/Cuiaba',
          from_iso8601_timestamp(d.end_datetime)   AT TIME ZONE 'America/Cuiaba'
        ) AS double
      ) / 60.0
    ) * (COALESCE(d.downtime_percentage, 0) / 100.0)
    AS DECIMAL(18,2)
  ) AS effective_downtime_minutes,

  '1439' AS session_duration_minutes
  
FROM industrial_process.downtime d

INNER JOIN industrial_process.downtime_motive       dm ON d.downtime_motive_id     = dm.downtime_motive_id
INNER JOIN industrial_process.motive_type           mt ON dm.motive_type_id        = mt.motive_type_id

INNER JOIN industrial_process.downtime_component    dc ON d.downtime_component_id  = dc.downtime_component_id
INNER JOIN industrial_process.component_type        ct ON dc.component_type_id     = ct.component_type_id

INNER JOIN industrial_process.downtime_cause        dcs ON d.downtime_cause_id     = dcs.downtime_cause_id
INNER JOIN industrial_process.cause_type            cs ON dcs.cause_type_id        = cs.cause_type_id

INNER JOIN industrial_process.session               s ON d.session_id              = s.session_id
INNER JOIN industrial_process.business_unit         bu ON s.business_unit_id       = bu.business_unit_id
INNER JOIN industrial_process.season                se ON se.season_id             = s.season_id

ORDER BY s.session_number DESC;