-- 3475. DNA Pattern Recognition 
SELECT
    sample_id,
    dna_sequence,
    species,
    SUM(CASE WHEN dna_sequence LIKE 'ATG%' THEN 1 ELSE 0 END) AS has_start,
    SUM(CASE WHEN 
                dna_sequence LIKE '%TAA' OR
                dna_sequence LIKE '%TAG' OR
                dna_sequence LIKE '%TGA'  
        THEN 1 ELSE 0 END)
        AS has_stop,
    SUM(CASE WHEN dna_sequence LIKE '%ATAT%' THEN 1 ELSE 0 END) AS has_atat,
    SUM(CASE WHEN dna_sequence LIKE '%GGG%' OR dna_sequence LIKE '%GGGG%' THEN 1 ELSE 0 END) AS has_ggg
FROM Samples
GROUP BY sample_id
ORDER BY sample_id ASC