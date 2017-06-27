SELECT COUNT(*) FROM adm_siga.oficio
WHERE texto ILIKE '%indeferida%'
    [[AND data_oficio::date >= {{data_oficio_inicial}}]]
    [[AND data_oficio::date <= {{data_oficio_final}}]]
