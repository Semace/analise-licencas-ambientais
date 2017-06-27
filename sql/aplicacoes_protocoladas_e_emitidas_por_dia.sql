WITH dates AS (
    SELECT GENERATE_SERIES({{data_inicial}}::date, {{data_final}}::date, '1 day') AS current_date
), protocoladas AS (
    SELECT processo.spu_id, processo.data_cadas AS data
    FROM adm_siga.processo
	INNER JOIN adm_siga.movimento_processo ON movimento_processo.processo_id = processo.processo_id
	WHERE movimento_processo.status_processo_id = '0001' -- filter to create
    	AND processo.grupo_tipo_processo_id = '0001' -- filter by license
), emitidas AS (
    SELECT processo.spu_id, movimento_processo.data_hora AS data
    FROM adm_siga.movimento_processo
    INNER JOIN adm_siga.processo ON movimento_processo.processo_id = processo.processo_id
    WHERE movimento_processo.status_processo_id = '0056'
        AND movimento_processo.excluido IS FALSE
)
SELECT dates.current_date, 'Protocolada' AS status, COUNT(*) FROM dates
LEFT OUTER JOIN protocoladas ON dates.current_date = DATE_TRUNC('day', protocoladas.data)
GROUP BY dates.current_date, status
UNION
SELECT dates.current_date, 'Emitida' AS status, COUNT(*) FROM dates
LEFT OUTER JOIN emitidas ON dates.current_date = DATE_TRUNC('day', emitidas.data)
GROUP BY dates.current_date, status
