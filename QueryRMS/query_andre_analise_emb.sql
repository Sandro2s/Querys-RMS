select aa.git_cod_item||'-'||aa.git_digito as "Código", 
       aa.git_descricao as "Descrição",
       aa.git_codigo_ean13 as "EAN 13",
       aa.git_secao as "Seção",
       aa.git_grupo as "Grupo",
       aa.git_subgrupo as "Sub-Grupo",
       aa.git_sis_abast as "Sistemática",
       aa.git_cod_for||'-'||dac(aa.git_cod_for) as "Cod.Fornecedor",
       sum(vda.qtd_vda) as "Venda Abril",
       aa.git_emb_for||' '||aa.git_tpo_emb_for as "Emb.Compra",
       aa.git_emb_transf||' '||aa.git_tpo_emb_transf as "Emb.Transf",
       aa.git_emb_venda||' '||aa.git_tpo_emb_venda as "Emb.Venda"
       
  from aa3citem aa,agg_vda_prod_mes vda
 where aa.git_cod_item =  vda.cd_prod
  and vda.id_mes = 201004
  and aa.git_dat_sai_lin = 0 
  and aa.git_secao not in (300,600,601,602,603,604,605,606,607,608)
  and aa.git_depto not in (5,7,100,200)
  Group by aa.git_cod_item,aa.git_digito,aa.git_descricao,aa.git_codigo_ean13,aa.git_secao,aa.git_grupo,aa.git_subgrupo,
           aa.git_cod_for,aa.git_emb_for,aa.git_tpo_emb_for,aa.git_emb_transf,aa.git_tpo_emb_transf,aa.git_emb_venda,
           aa.git_tpo_emb_venda,aa.git_sis_abast
  Order by aa.git_secao,aa.git_grupo,aa.git_subgrupo,aa.git_descricao
--select sum(vda.qtd_vda) from agg_vda_prod_mes vda where vda.id_mes = 201004  and  vda.cd_prod = 139444
--select * from dim_per where id_mes = 201004

