-- =========================================
-- Project: Traffic Inspection Dashboard
-- Description: SQL query used for traffic inspection analysis, compliance monitoring, and operational safety indicators
-- =========================================


-- =========================================
-- 1. Inspection Records Extraction & Latest Version Consolidation
-- Description: Retrieves the latest inspection records, consolidates workflow information, standardizes textual fields, and prepares operational safety data for dashboard analysis
-- =========================================

WITH registros_atuais AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY registro_id
            ORDER BY TRY_CAST(versao AS integer) DESC,
                     TRY_CAST(id AS integer) DESC
        ) AS ordem
    FROM schema_origem.tb_inspecoes
    WHERE tipo_registro = 'principal'
),

processos AS (
    SELECT
        id_referencia,
        MAX(numero_processo) AS numero_processo
    FROM schema_origem.tb_workflow
    WHERE categoria_processo = 'Processo Operacional'
    GROUP BY id_referencia
)

SELECT
    r.registro_id,
    r.versao,
    COALESCE(
        NULLIF(r.codigo_registro, '0'),
        CAST(p.numero_processo AS varchar)
    ) AS codigo_registro,
    TRY_CAST(
        NULLIF(r.data_evento, '')
        AS date
    ) AS data_evento,
    r.unidade_operacional,
    r.responsavel,
    r.categoria_item,
    r.identificador_item,
    r.origem_registro,
    r.indicador_01,
    r.indicador_02,
    r.indicador_03,
    r.indicador_04,
    r.indicador_05,
    r.indicador_06,
    r.indicador_07,
    r.indicador_08,
    r.indicador_09,
    r.indicador_10,
    r.indicador_11,
    array_join(
        transform(
            split(
                regexp_replace(
                    trim(lower(r.analista_responsavel)),
                    '\\s+',
                    ' '
                ),
                ' '
            ),
            palavra -> concat(
                upper(substr(palavra, 1, 1)),
                substr(palavra, 2)
            )
        ),
        ' '
    ) AS analista_responsavel,
    r.categoria_responsavel,
    r.status_registro,
    r.observacao_item,
    r.observacao_geral

FROM registros_atuais r

LEFT JOIN processos p
       ON p.id_referencia =
          TRY_CAST(r.registro_id AS integer)

WHERE r.ordem = 1
