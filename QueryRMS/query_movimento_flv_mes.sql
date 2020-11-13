-- Empresa : Supermercado São Roque Ltda.
-- Data :11/09/2015
-- Atualizado em : 11/09/2015
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Tersi
-- Descrição : Consultar no gerencial as compras feitas com um fornecedor
--             em um periodo 

SELECT 
    NVL(agg.cd_forn, 0)                          AS codigo,
    MAX(nvl(agg.tip_nome_fantasia, 'NÃO CADASTRADO'))  AS Fornecedor,
    SUM(NVL(agg.qtd_cmp,0)) - SUM(NVL(qtd_dvol_cmp,0)) AS Cmp_qtde,
    SUM((agg.vl_cmp - NVL(agg.vl_dvol_cmp, 0))) AS Cmp_vl
FROM
(     (SELECT  /*+ driving_site (cmp) */
             id_mes, cd_fil, cd_prod, cd_set, git_categoria, 
             git_cod_for, tipf.tip_nome_fantasia, 
             cd_forn,
             qtd_cmp, vl_cmp,
             0 AS vl_dvol_cmp,
             0 AS qtd_dvol_cmp,
             vl_icms_cmp,
             vl_ipi,
             vl_funrural,
             vl_pis_cmp, vl_cofins_cmp,
             0 AS vl_pis_dvol_cmp, 0 AS vl_cofins_dvol_cmp,
             0 AS vl_icms_dvol_cmp, git_dat_sai_lin
      FROM agg_cmp_prod_forn_mes cmp, 
    aa3citem
,   AA2CTIPO      tipf
      WHERE id_mes = 201508
      AND cd_fil             = 100
      AND git_cod_item (+) = cd_prod
      AND cd_forn         = tipf.tip_codigo (+)
      --and tip_natureza = 'FP'
      UNION ALL
      SELECT  /*+ driving_site (mvto) */
             id_mes, cd_fil, cd_prod, cd_set, git_categoria, 
             git_cod_for, tipf.tip_nome_fantasia, 
             cd_forn,
             0,0, vl_dvol_cmp, qtd_dvol_cmp,
             0 AS vl_icms_cmp,
             0 AS vl_ipi,
             0 AS vl_funrural,
             0 as vl_pis_cmp, 0 as vl_cofins_cmp,
             vl_pis_dvol_cmp, vl_cofins_dvol_cmp,
             vl_icms_dvol_cmp, git_dat_sai_lin
      FROM agg_mvto_prod_forn_mes mvto, 
    aa3citem
,   AA2CTIPO      tipf
      WHERE id_mes = 201508
      AND cd_fil             = 100
      AND   git_cod_item (+) = cd_prod
      AND cd_forn         = tipf.tip_codigo (+)
     -- and tip_natureza = 'FP'
)
) agg
GROUP BY ROLLUP(agg.cd_forn)
HAVING (SUM(agg.vl_cmp) > 0 OR SUM(agg.vl_dvol_cmp) > 0) 
ORDER BY DECODE(GROUPING(agg.cd_forn), 1, 1, 5 ) ASC 

