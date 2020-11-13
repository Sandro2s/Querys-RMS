-- Empresa : Supermercado São Roque Ltda. TI
-- Data :25/06/2012
-- Descrição : Movimentações de todas seções 
-- Desenvolvido : Sandro Soares
-- Atualizado em : 25/06/2012

select fsg.*, nvl(ag1.vl_estq,0) vl_estq, nvl(ag1.qtd_estq,0) qtd_estq from (
Select        cd1.cd_fil                  as Filial
             ,cd1.cd_set                  as Secao
             ,cd1.cd_grp                  as Grupo
             ,descricao                   as Descricao
             ,sum(qtd_cmp)                as Qtd_Compra
             ,sum(vl_cmp)                 as Vl_compra
             ,sum(qtd_vda)                as Qtd_Venda
             ,sum(vl_vda)                 as Vl_Venda
             ,sum(qtd_dvol_vda)           as Qtd_Devol_vda
             ,sum(vl_dvol_vda)            as Vl_Devol_vda
             ,sum(qtd_dvol_cmp)           as Qtd_Devol_Compra
             ,sum(vl_dvol_cmp)            as Vl_Devol_Compra
             ,sum(qtd_transf_entr)        as Qtd_Transf_entr
             ,sum(vl_transf_entr)         as Vl_Transf_entr
             ,sum(qtd_bnf)                as Qtd_Bonificacao
             ,sum(vl_bnf)                 as Vl_Bonificacao
             ,sum(qtd_sobra)              as Qtd_Sobra
             ,sum(vl_sobra)               as Vl_Sobra
             ,sum(qtd_outr_entr)          as Qtd_Outras_Entradas
             ,sum(vl_outr_entr)           as Vl_Outras_Entradas
             ,sum(qtd_transf_sai)         as Qtd_Transf_Saida
             ,sum(vl_transf_sai)          as Vl_Transf_Saida
             ,sum(qtd_qbra_conh)          as Qtd_Quebra_Conhecida
             ,sum(vl_qbra_conh)           as Vl_Quebra_Conhecida
             ,sum(qtd_qbra_inv)           as Qtd_Quebra_Inventario
             ,sum(vl_qbra_inv)            as Vl_Quebra_Inventario
             ,sum(qtd_outr_sai)           as Qtd_Outras_Saida
             ,sum(vl_outr_sai)            as Vl_Outras_Saida
    from

  ( Select   id_dt
             ,cd_fil
             ,cd_set
             ,cd_grp
             ,descgrp.ncc_descricao  as descricao
             ,qtd_transf_entr
             ,vl_transf_entr
             ,qtd_bnf
             ,vl_bnf
             ,qtd_dvol_vda
             ,vl_dvol_vda
             ,qtd_sobra
             ,vl_sobra
             ,qtd_outr_entr
             ,vl_outr_entr
             ,qtd_transf_sai
             ,vl_transf_sai
             ,qtd_dvol_cmp
             ,vl_dvol_cmp
             ,qtd_qbra_conh
             ,vl_qbra_conh
             ,qtd_qbra_inv
             ,vl_qbra_inv
             ,qtd_outr_sai
             ,vl_outr_sai
             ,qtd_vda
             ,vl_vda
             ,qtd_cmp
             ,vl_cmp

       from agg_coml_sgrp , aa2ctipo ,
       (select id_dt as dt,dt_compl from dim_per dim where dt_compl between to_date('&Dta_Inicial','dd/mm/yyyy') and to_date('&Dta_Final','dd/mm/yyyy'))dt,
       (select ncc_secao,ncc_grupo,ncc_descricao from aa3cnvcc where ncc_grupo   > 0
         and ncc_subgrupo  = 0
         and ncc_categoria = 0 and ncc_secao in (100,101,102,103,104,105,106,107,108,109,110,111,112,200,201,300,301,302,303,304,305,306,400,401,402,403)              order by ncc_grupo) descgrp

        where id_dt   = dt.dt
          and cd_set = descgrp.ncc_secao
          and cd_grp = descgrp.ncc_grupo
          and tip_codigo = cd_fil
          and tip_empresa in (1,2,12) ) cd1

          group by cd1.cd_fil, cd1.cd_set, cd1.cd_grp,descricao
          order by 1,2,3  ) fsg,

( Select agg.cd_fil, agg.cd_set, agg.cd_grp, sum(nvl(vl_estq_ult_entr, 0)) vl_estq, sum(nvl(qtd_estq, 0)) qtd_estq
          from agg_coml_sgrp agg, aa2ctipo
         where agg.cd_fil = cd_fil and agg.cd_set = cd_set and agg.cd_grp = cd_grp
           and agg.id_dt = ((select id_dt as dt from dim_per dim where dt_compl = to_date('&Dta_Final','dd/mm/yyyy')))
           and tip_codigo = agg.cd_fil and tip_empresa in (1,2,12)
           and agg.cd_set in (100,101,102,103,104,105,106,107,108,109,110,111,112,200,201,300,301,302,303,304,305,306,400,401,402,403) group by agg.cd_fil, agg.cd_set, agg.cd_grp ) ag1
  where fsg.filial = ag1.cd_fil (+)
    and fsg.secao  = ag1.cd_set (+)
    and fsg.grupo  = ag1.cd_grp (+)
