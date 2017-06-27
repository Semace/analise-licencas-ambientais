SELECT COUNT(*)
FROM adm_siga.movimento_processo
INNER JOIN adm_siga.processo ON movimento_processo.processo_id = processo.processo_id
WHERE movimento_processo.status_processo_id = '0056'
   AND movimento_processo.excluido IS FALSE
   [[AND movimento_processo.data_hora::date >= {{data_inicial}}]]
   [[AND movimento_processo.data_hora::date <= {{data_final}}]]
