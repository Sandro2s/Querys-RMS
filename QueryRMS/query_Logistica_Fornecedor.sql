-- Empresa : Supermercado São Roque Ltda. TI
-- Data :14/01/2016
-- Descrição : Tras os valores para calculo da logistica por fornecedor
-- Solicitante : Solange Pinheiro
-- Desenvolvedor : Joaquim Pedro
-- Atualizado em : 07/11/2016

select (decode(substr('&Dta_Inicial',4,2),01,'JAN/',02,'FEV/',03,'MAR/',04,'ABR/',05,'MAI/',06,'JUN/',
                                         07,'JUL/',08,'AGO/',09,'SET/',10,'OUT/',11,'NOV/',12,'DEZ/')|| substr('&Dta_Inicial',7,4)) REF,
              A.* from (
SELECT    
    MAX(tip.tip_razao_social)         AS nm_niv,
    (dim.for_codigo * 10)+ dim.for_dig_for   AS for_codigo,     
    SUM(agg.vl_cmp) AS VL_CMP,
--    SUM(NVL(agg.vl_bnf,0) - NVL(agg.vl_icms_bnf,0) - NVL(agg.vl_pis_bnf,0) - NVL(agg.vl_cofins_bnf,0))  AS VL_BNF,
--    SUM(NVL(agg.vl_dvol_cmp,0) - NVL(agg.vl_icms_dvol_cmp,0) - NVL(agg.vl_pis_dvol_cmp,0) - NVL(agg.vl_cofins_dvol_cmp,0))  AS VL_DVOL_CMP,
    SUM(NVL(agg.vl_bnf,0))  AS VL_BNF,
    SUM(NVL(agg.vl_dvol_cmp,0))  AS VL_DVOL_CMP,
    SUM(NVL(agg.vl_qbra_inv,0)) AS Vl_Qbra_Inv,
    SUM(NVL(agg.vl_sobra,0)) AS Vl_Sobra 
FROM
    AA2CLOJA      loj,
    AA2CTIPO      tip1,
    AA2CFORN      dim,
    AA2CTIPO      tip,
    agg_coml_forn agg
WHERE
    agg.id_dt in (select id_dt from dim_per dim 
                   where dt_compl between to_date('&Dta_Inicial','dd/mm/yyyy') and to_date('&Dta_Final','dd/mm/yyyy'))
AND tip1.tip_codigo  (+)= agg.cd_fil
AND tip1.tip_codigo   = loj.loj_codigo
AND tip1.tip_digito   = loj.loj_digito
--AND (loj.loj_codigo IN (18, 19, 24, 23, 27, 28, 17, 54, 11, 12, 50, 51, 52, 53, 1, 2, 3, 4, 5, 7, 8, 120, 100, 103, 13, 9, 10, 130, 14, 55, 56, 57, 58, 59, 60, 15, 38, 20, 16, 21, 22, 25, 64, 26, 29, 300) OR loj.loj_codigo IS NULL)
AND loj.loj_codigo    = 100 
AND agg.cd_forn       = dim.for_codigo
AND tip.tip_codigo    = dim.for_codigo
GROUP BY  (dim.for_codigo * 10)+ dim.for_dig_for

UNION
SELECT
    'HOLDING'                  AS nm_niv,
    0                          AS cd_forn,
    SUM(agg.vl_cmp) AS VL_CMP,
--    SUM(NVL(agg.vl_bnf,0) - NVL(agg.vl_icms_bnf,0) - NVL(agg.vl_pis_bnf,0) - NVL(agg.vl_cofins_bnf,0))  AS VL_BNF,
--    SUM(NVL(agg.vl_dvol_cmp,0) - NVL(agg.vl_icms_dvol_cmp,0) - NVL(agg.vl_pis_dvol_cmp,0) - NVL(agg.vl_cofins_dvol_cmp,0))  AS VL_DVOL_CMP,
    SUM(NVL(agg.vl_bnf,0))  AS VL_BNF,
    SUM(NVL(agg.vl_dvol_cmp,0)) AS VL_DVOL_CMP,
    SUM(NVL(agg.vl_qbra_inv,0)) AS Vl_Qbra_Inv,
    SUM(NVL(agg.vl_sobra,0)) AS Vl_Sobra 
FROM
    AA2CLOJA      loj,
    AA2CTIPO      tip,
    agg_coml_fil  agg
WHERE
    agg.id_dt in (select id_dt from dim_per dim 
                   where dt_compl between to_date('&Dta_Inicial','dd/mm/yyyy') and to_date('&Dta_Final','dd/mm/yyyy'))
AND agg.cd_fil (+) = tip.tip_codigo
AND tip.tip_codigo   = loj.loj_codigo
AND tip.tip_digito   = loj.loj_digito
AND loj.loj_codigo = 100 
ORDER BY 3 DESC, 2 ASC ) A;
