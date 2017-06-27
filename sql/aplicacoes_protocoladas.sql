SELECT COUNT(*)
FROM adm_siga.movimento_processo
LEFT JOIN adm_siga.processo ON movimento_processo.processo_id = processo.processo_id
WHERE movimento_processo.status_processo_id = '0001'
    AND processo.grupo_tipo_processo_id = '0001' -- Licenças
    [[AND processo.data_cadas::date >= {{data_cadastro_inicial}}]]
    [[AND processo.data_cadas::date <= {{data_cadastro_final}}]]
