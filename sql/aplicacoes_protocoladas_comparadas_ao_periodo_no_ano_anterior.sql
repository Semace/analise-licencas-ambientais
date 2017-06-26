WITH processos AS (
    SELECT processo.data_cadas AS data
    FROM adm_siga.movimento_processo
    LEFT JOIN adm_siga.processo ON movimento_processo.processo_id = processo.processo_id
    WHERE movimento_processo.status_processo_id = '0001'
       AND processo.grupo_tipo_processo_id = '0001' -- Licenças
), current_period AS (
    SELECT COUNT(data) AS current_count
    FROM processos
    WHERE data BETWEEN {{data_cadastro_inicial}}::date AND {{data_cadastro_final}}::date
), previous_period AS (
    SELECT COUNT(data) AS previous_count
    FROM processos
    WHERE data BETWEEN ({{data_cadastro_inicial}}::date - INTERVAL '1 YEAR') AND ({{data_cadastro_final}}::date - INTERVAL '1 YEAR')
)
SELECT (current_count - previous_count) / previous_count::float AS change_compared_to_previous_year
FROM current_period, previous_period
