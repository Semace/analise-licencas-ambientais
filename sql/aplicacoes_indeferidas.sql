SELECT COUNT(*) FROM adm_siga.oficio
WHERE texto ILIKE '%indeferida%'
    AND data_oficio BETWEEN {{data_oficio_inicial}}::date AND {{data_oficio_final}}::date
