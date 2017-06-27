WITH emitida_duration AS (
    SELECT
        processo.spu_id,
        mp2.processo_id,
        MIN(data_hora) AS min_date,
        fim.max_date
     FROM adm_siga.movimento_processo mp2
     INNER JOIN (
        SELECT processo_id, MAX(data_hora) AS max_date FROM adm_siga.movimento_processo mp
        WHERE mp.status_processo_id = '0056'  -- Licença emitida
        GROUP BY processo_id
     ) AS fim ON fim.processo_id = mp2.processo_id
     INNER JOIN adm_siga.processo ON processo.processo_id = mp2.processo_id
     WHERE mp2.status_processo_id = '0001'
        AND processo.excluido IS FALSE
        AND processo.grupo_tipo_processo_id = '0001'
     GROUP BY mp2.processo_id, fim.max_date, processo.spu_id
)
-- This extraction doesn't round the dates, so 7 days and 23 hours would become 7 days, not 8 days (the R dashboard rounds).
SELECT EXTRACT(DAY FROM AVG(max_date - min_date)) FROM emitida_duration
WHERE 1=1
    [[AND max_date >= {{data_inicial}}]]
    [[AND max_date <= {{data_final}}]]
