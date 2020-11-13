-- Supermercado São Roque Ltda.
-- Data : 09/02/2018
-- Solicitante : Zezinho \ Solange
-- Desenvolvedor : Sandro Soares
-- Descrição : Compras efetuado no Galli no mès.

Select 
        mes,
       prod,
      descr,
      ref_Galli,
    qt_comp,
      decode(qt_comp,0,0,to_char((vl_comp) /to_char(qt_comp),'9999.999')) as custo_un,
     -- to_char(decode(qt_comp,0,0, (vl_comp / qt_comp)),'9999.99') as custo_un,
      vl_comp
      
from 

(
select id_mes as mes,
       cd_prod||dac(cd_prod)as prod,
       git_referencia as ref_galli,
       git_descricao as descr,
       sum(qtd_cmp - qtd_dvol_cmp)as qt_comp,
       sum(vl_cmp - vl_dvol_cmp)as vl_comp


from
(SELECT  /*+ driving_site (cmp) */
             id_mes, cd_prod, git_referencia, 
             git_descricao,
             qtd_cmp, 
             vl_cmp,
             0 AS vl_dvol_cmp,
             0 AS qtd_dvol_cmp,
             vl_icms_cmp,
             vl_ipi,
             vl_funrural,
             vl_pis_cmp, 
             vl_cofins_cmp,
             0 AS vl_pis_dvol_cmp, 
             0 AS vl_cofins_dvol_cmp,
             0 AS vl_icms_dvol_cmp
      FROM agg_cmp_prod_forn_mes cmp, 
    aa3citem, aa3cnvcc
      WHERE id_mes ='&Mes_yyyymm' --201712
      AND   git_cod_item (+) = cd_prod
      AND cd_forn         = 1538
      AND ncc_departamento = 3
      AND cd_set           = ncc_secao
      AND cd_grp           = ncc_grupo
      AND cd_sgrp          = ncc_subgrupo
      AND nvl(cd_cat,0)    = ncc_categoria
   UNION ALL
      
      SELECT  /*+ driving_site (mvto) */
             id_mes, cd_prod,git_referencia,  
             git_descricao,
             0,
             0, 
             vl_dvol_cmp, 
             qtd_dvol_cmp,
             0 AS vl_icms_cmp,
             0 AS vl_ipi,
             0 AS vl_funrural,
             0 as vl_pis_cmp,
             0 as vl_cofins_cmp,
             vl_pis_dvol_cmp, 
             vl_cofins_dvol_cmp,
             vl_icms_dvol_cmp
      FROM agg_mvto_prod_forn_mes mvto, 
    aa3citem, aa3cnvcc
      WHERE id_mes = '&Mes_yyyymm'--201712
      AND   git_cod_item (+) = cd_prod
      AND cd_forn         = 1538
      AND ncc_departamento = 3
      AND cd_set           = ncc_secao
      AND cd_grp           = ncc_grupo
      AND cd_sgrp          = ncc_subgrupo
      AND nvl(cd_cat,0)    = ncc_categoria
      ) group by cd_prod,id_mes,git_referencia, git_descricao
       )
       order by 3
