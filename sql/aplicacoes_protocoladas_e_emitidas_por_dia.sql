WITH dates AS (
    SELECT GENERATE_SERIES({{data_cadastro_inicial}}::date, {{data_cadastro_final}}::date, '1 day') AS current_date
), processos AS (
    SELECT mv.status_processo_id, DATE_TRUNC('day', processo.data_cadas) AS data_cadastro FROM adm_siga.processo
    INNER JOIN adm_siga.movimento_processo AS mv ON mv.processo_id = processo.processo_id
    WHERE processo.data_cadas BETWEEN {{data_cadastro_inicial}}::date AND {{data_cadastro_final}}::date
    AND mv.status_processo_id in (
        '0001',  -- Processo formado
        '0056'   -- Licença emitida
        )
    AND processo.grupo_tipo_processo_id = '0001' -- Licenças
)
SELECT dates.current_date, 'Protocolada' AS status, COUNT(processos.status_processo_id) FROM dates
LEFT OUTER JOIN processos ON dates.current_date = processos.data_cadastro AND processos.status_processo_id = '0001'
GROUP BY dates.current_date, status
UNION
SELECT dates.current_date, 'Emitida' AS status, COUNT(processos.status_processo_id) FROM dates
LEFT OUTER JOIN processos ON dates.current_date = processos.data_cadastro AND processos.status_processo_id = '0056'
GROUP BY dates.current_date, status
