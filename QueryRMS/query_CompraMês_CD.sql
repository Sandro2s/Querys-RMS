-- Empresa : Supermercado São Roque Ltda. TI
-- Data :27/09/2017
-- Descrição : Tras informações para analise do fornecedor no queste de compra
-- Desenvolvido : Sandro Soares
-- Solicitante : Andersom Grisolle
-- Atualizado em :
------------------------------------------------------------------------------------------------------------------------------
Select cd_forn||tip_digito as Cod_Fornecedor,
       tip_nome_fantasia as Desc_Fantasia,
       cd.git_cod_item||git_digito as Codigo,
       git_descricao as Descricao,
       git_sis_abast as Sit_Abast,
       cmp.cd_set as secao,
       git_base_pallet as Camada,
       git_altura_pallet as Altura,
       git_frq_visit as Frq_Visita,
       git_prz_entrg as Prz_Entrega,
       git_emb_for as Emb_For,
       qtd_vda,
       qtd_cmp,
       est_cd,
       est_lj
       

from 
(select cd_forn,tip_codigo,tip_digito,tip_nome_fantasia  , cd_prod, sum(qtd_cmp) as qtd_cmp,cd_set  
  from agg_cmp_prod_forn_mes, aa2ctipo
 where id_mes = '&Mês'--201708
 and cd_forn = tip_codigo
 and cd_fil = 100
 group by cd_forn, cd_prod, tip_nome_fantasia,tip_codigo,tip_digito,cd_set)cmp,
       
     (select cd_prod, sum(qtd_vda) as qtd_vda
        from agg_vda_prod_mes vda
       where id_mes = '&Mês' --201708
       group by cd_prod) vda,
                                                                   
              (select git_cod_item ,git_descricao,git_digito,git_base_pallet,git_altura_pallet,
                      git_frq_visit,git_prz_entrg,git_emb_for,(est.get_estoque)as Est_CD,
                      git_sis_abast
                from aa2cestq est, aa3citem it
               where get_cod_produto > 0 
                and est.get_cod_local = 1007
                and git_dat_sai_lin = 0
                and it.git_cod_item||it.git_digito = est.get_cod_produto
                and git_secao in (100,101,102,103,104,105,106,107,108,109,110,111,112,200,201,300,301,302,306,400,401)
                  )cd, 
     
                      (select git_cod_item, sum(est.get_estoque) as Est_lj
                        from aa2cestq est, aa3citem it
                       where get_cod_produto > 0
                         and est.get_cod_local != 1007
                         and git_dat_sai_lin = 0
                         and it.git_cod_item || it.git_digito = est.get_cod_produto
                         and git_secao in (100,101,102,103,104,105,106,107,108,109,110,111,112,200,201,300,301,302,306,400,401)
                         group by   git_cod_item)lj 
                               
     
    Where cmp.cd_prod = vda.cd_prod 
     and  cmp.cd_prod = cd.git_cod_item
     and  cmp.cd_prod = lj.git_cod_item
    -- and  cmp.tip_codigo||cmp.tip_digito = 14397
    
    

