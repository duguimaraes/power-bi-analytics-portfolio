-- =========================================
-- Project: Operational Bulletin Control Dashboard
-- Description: Consolidates operational bulletin records across multiple
-- business units, standardizing bulletin types and document information.
-- =========================================

SELECT
    'Business Unit A' AS source_unit,
    d.document_number,
    d.document_date,
    d.bulletin_number,
    d.branch_name,
    CASE d.bulletin_origin
        WHEN 'F' THEN 'Fuel'
        WHEN 'L' THEN 'Lubrication'
        WHEN 'S' THEN 'Supply'
        WHEN 'P' THEN 'Planting'
        WHEN 'T' THEN 'Seed Treatment'
        ELSE 'Not Defined'
    END AS bulletin_type
FROM business_unit_a.goods_receipts d
WHERE d.bulletin_origin IN ('F', 'L', 'S', 'P', 'T')

UNION ALL

SELECT
    'Business Unit B' AS source_unit,
    d.document_number,
    d.document_date,
    d.bulletin_number,
    'Unit B' AS branch_name,
    CASE d.bulletin_origin
        WHEN 'F' THEN 'Fuel'
        WHEN 'L' THEN 'Lubrication'
        WHEN 'S' THEN 'Supply'
        WHEN 'P' THEN 'Planting'
        WHEN 'T' THEN 'Seed Treatment'
        ELSE 'Not Defined'
    END AS bulletin_type
FROM business_unit_b.goods_receipts d
WHERE d.bulletin_origin IN ('F', 'L', 'S', 'P', 'T')

UNION ALL

SELECT
    'Business Unit C' AS source_unit,
    d.document_number,
    d.document_date,
    d.bulletin_number,
    d.branch_name,
    CASE d.bulletin_origin
        WHEN 'F' THEN 'Fuel'
        WHEN 'L' THEN 'Lubrication'
        WHEN 'S' THEN 'Supply'
        WHEN 'P' THEN 'Planting'
        WHEN 'T' THEN 'Seed Treatment'
        ELSE 'Not Defined'
    END AS bulletin_type
FROM business_unit_c.goods_receipts d
WHERE d.bulletin_origin IN ('F', 'L', 'S', 'P', 'T')

UNION ALL

SELECT
    'Business Unit D' AS source_unit,
    d.document_number,
    d.document_date,
    d.bulletin_number,
    'Unit D' AS branch_name,
    CASE d.bulletin_origin
        WHEN 'F' THEN 'Fuel'
        WHEN 'L' THEN 'Lubrication'
        WHEN 'S' THEN 'Supply'
        WHEN 'P' THEN 'Planting'
        WHEN 'T' THEN 'Seed Treatment'
        ELSE 'Not Defined'
    END AS bulletin_type
FROM business_unit_d.goods_receipts d
WHERE d.bulletin_origin IN ('F', 'L', 'S', 'P', 'T');