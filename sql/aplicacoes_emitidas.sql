SELECT COUNT(*)
FROM adm_siga.movimento_processo
LEFT JOIN adm_siga.processo ON movimento_processo.processo_id = processo.processo_id
WHERE movimento_processo.status_processo_id = '0056'
   AND movimento_processo.excluido IS FALSE
   AND movimento_processo.data_hora BETWEEN {{data_cadastro_inicial}} AND {{data_cadastro_final}}
