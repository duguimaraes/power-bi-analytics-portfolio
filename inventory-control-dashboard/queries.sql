-- =========================================
-- Project: Inventory Movement & Obsolescence Dashboard
-- Description: Consolidates inventory movement data across multiple business units,
-- calculates monthly stock activity, and identifies inactive / obsolete items.
-- =========================================

WITH unified_inventory_data AS (

    -- Business Unit A
    SELECT 
        inv.location_code,
        inv.item_code,
        inv.document_date,
        inv.in_quantity,
        inv.out_quantity,
        inv.stock_value,
        itm.item_name,
        itm.item_group_code,
        wh.min_stock_level,
        wh.max_stock_level,
        grp.item_group_name
    FROM business_unit_a.inventory_log inv
    LEFT JOIN business_unit_a.items itm
        ON itm.item_code = inv.item_code
    LEFT JOIN business_unit_a.item_warehouse wh
        ON wh.item_code = inv.item_code
       AND wh.warehouse_code = inv.location_code
    LEFT JOIN business_unit_a.item_groups grp
        ON grp.item_group_code = itm.item_group_code

    UNION ALL

    -- Business Unit B
    SELECT 
        inv.location_code,
        inv.item_code,
        inv.document_date,
        inv.in_quantity,
        inv.out_quantity,
        inv.stock_value,
        itm.item_name,
        itm.item_group_code,
        wh.min_stock_level,
        wh.max_stock_level,
        grp.item_group_name
    FROM business_unit_b.inventory_log inv
    LEFT JOIN business_unit_b.items itm
        ON itm.item_code = inv.item_code
    LEFT JOIN business_unit_b.item_warehouse wh
        ON wh.item_code = inv.item_code
       AND wh.warehouse_code = inv.location_code
    LEFT JOIN business_unit_b.item_groups grp
        ON grp.item_group_code = itm.item_group_code

    UNION ALL

    -- Business Unit C
    SELECT 
        inv.location_code,
        inv.item_code,
        inv.document_date,
        inv.in_quantity,
        inv.out_quantity,
        inv.stock_value,
        itm.item_name,
        itm.item_group_code,
        wh.min_stock_level,
        wh.max_stock_level,
        grp.item_group_name
    FROM business_unit_c.inventory_log inv
    LEFT JOIN business_unit_c.items itm
        ON itm.item_code = inv.item_code
    LEFT JOIN business_unit_c.item_warehouse wh
        ON wh.item_code = inv.item_code
       AND wh.warehouse_code = inv.location_code
    LEFT JOIN business_unit_c.item_groups grp
        ON grp.item_group_code = itm.item_group_code

    UNION ALL

    -- Business Unit D
    SELECT 
        inv.location_code,
        inv.item_code,
        inv.document_date,
        inv.in_quantity,
        inv.out_quantity,
        inv.stock_value,
        itm.item_name,
        itm.item_group_code,
        wh.min_stock_level,
        wh.max_stock_level,
        grp.item_group_name
    FROM business_unit_d.inventory_log inv
    LEFT JOIN business_unit_d.items itm
        ON itm.item_code = inv.item_code
    LEFT JOIN business_unit_d.item_warehouse wh
        ON wh.item_code = inv.item_code
       AND wh.warehouse_code = inv.location_code
    LEFT JOIN business_unit_d.item_groups grp
        ON grp.item_group_code = itm.item_group_code
),

monthly_inventory_movement AS (
    SELECT 
        u.location_code,
        u.item_code,
        u.item_name,
        u.item_group_code,
        u.item_group_name,
        u.min_stock_level,
        u.max_stock_level,
        LAST_DAY_OF_MONTH(CAST(u.document_date AS TIMESTAMP)) AS reference_month,
        SUM(CAST(u.in_quantity AS DECIMAL(18,2))) AS total_inbound,
        SUM(CAST(u.out_quantity AS DECIMAL(18,2))) AS total_outbound,
        SUM(CAST(u.stock_value AS DECIMAL(18,2))) AS total_stock_value
    FROM unified_inventory_data u
    GROUP BY 
        u.location_code,
        u.item_code,
        u.item_name,
        u.item_group_code,
        u.item_group_name,
        u.min_stock_level,
        u.max_stock_level,
        LAST_DAY_OF_MONTH(CAST(u.document_date AS TIMESTAMP))
),

latest_inventory_movement AS (
    SELECT 
        item_code,
        location_code,
        MAX(
            CASE 
                WHEN CAST(in_quantity AS DECIMAL(18,2)) > 0 
                THEN CAST(document_date AS TIMESTAMP)
            END
        ) AS last_inbound_date,
        MAX(
            CASE 
                WHEN CAST(out_quantity AS DECIMAL(18,2)) > 0 
                THEN CAST(document_date AS TIMESTAMP)
            END
        ) AS last_outbound_date
    FROM unified_inventory_data
    GROUP BY item_code, location_code
)

SELECT
    CASE 
        WHEN m.location_code LIKE '12%' THEN 'Farm A'
        WHEN m.location_code LIKE '13%' THEN 'Farm B'
        WHEN m.location_code LIKE '14%' THEN 'Farm C'
        WHEN m.location_code LIKE '15%' THEN 'Farm D'
        WHEN m.location_code LIKE '16%' THEN 'Farm E'
        WHEN m.location_code LIKE '17%' THEN 'Farm F'
        WHEN m.location_code LIKE '18%' THEN 'Farm G'
        WHEN m.location_code LIKE '51%' THEN 'Livestock Unit A'
        WHEN m.location_code LIKE '52%' THEN 'Livestock Unit B'
        WHEN m.location_code LIKE '53%' THEN 'Livestock Unit C'
        ELSE 'Other Unit'
    END AS business_unit,
    m.item_code,
    m.item_name,
    m.location_code AS warehouse_code,
    m.total_inbound AS inbound_quantity,
    m.total_outbound AS outbound_quantity,
    m.total_inbound - m.total_outbound AS inventory_balance,
    m.total_stock_value,
    m.item_group_name,
    m.item_group_code,
    CAST(REPLACE(m.min_stock_level, '.', '') AS DECIMAL(18,2)) AS min_stock_level,
    CAST(REPLACE(m.max_stock_level, '.', '') AS DECIMAL(18,2)) AS max_stock_level,
    m.reference_month,
    lm.last_inbound_date,
    lm.last_outbound_date,
    CASE 
        WHEN lm.last_outbound_date IS NOT NULL
         AND lm.last_inbound_date IS NOT NULL
        THEN date_diff('day', lm.last_inbound_date, lm.last_outbound_date)
        ELSE NULL
    END AS days_until_outbound,
    CASE 
        WHEN lm.last_outbound_date IS NULL
          OR lm.last_inbound_date > lm.last_outbound_date
        THEN date_diff('day', lm.last_inbound_date, CURRENT_DATE)
        ELSE NULL
    END AS days_without_movement
FROM monthly_inventory_movement m
LEFT JOIN latest_inventory_movement lm
    ON lm.item_code = m.item_code
   AND lm.location_code = m.location_code;