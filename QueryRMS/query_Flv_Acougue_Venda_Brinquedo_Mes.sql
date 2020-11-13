 -- Empresa : Supermercado São Roque Ltda. TI
-- Data :25/06/2012
-- Descrição : Movimentações da seção Açougue e FLV por loja.Seções 300,305,401
-- Desenvolvido : Sandro Soares
-- Atualizado em : 25/06/2012

select
                distinct  cd_fil                 as Filial
                         ,to_number(cd_prod||dac(cd_prod))   as Produto
                         ,git_descricao          as Descricao
                         ,ncc.ncc_descricao      as Grupo
                         ,rmsto_date(git_dat_sai_lin) as Dt_Fora_linha
                         ,sum(qtd_cmp)           as Qtd_Compra
                         ,sum(vl_cmp)            as Vl_Compra
                         ,sum(qtd_vda)           as Qtd_Venda
                         ,sum(vl_vda)            as Vl_Venda
                         ,sum(qtd_dvol_vda)      as Qtd_Devol_vda
                         ,sum(vl_dvol_vda)       as Vl_Devol_vda
                         ,sum(qtd_dvol_cmp)      as Qtd_Devol_Compra
                         ,sum(vl_dvol_cmp)       as Vl_Devol_Compra
                         ,sum(qtd_transf_entr)   as Qtd_Transf_entr
                         ,sum(vl_transf_entr)    as Vl_Transf_entr
                         ,sum(qtd_bnf)           as Qtd_Bonificacao
                         ,sum(vl_bnf)            as Vl_Bonificacao
                         ,sum(qtd_sobra)         as Qtd_Sobra
                         ,sum(vl_sobra)          as Vl_Sobra
                         ,sum(qtd_outr_entr)     as Qtd_Outas_Entradas
                         ,sum(vl_outr_entr)      as Vl_Outras_Entradas
                         ,sum(qtd_transf_sai)    as Qtd_Transf_Saida
                         ,sum(vl_transf_sai)     as Vl_Transf_Saida
                         ,sum(qtd_qbra_conh)     as Qtd_Quebra_Conhecida
                         ,sum(vl_qbra_conh)      as Vl_Quebra_Conhecida
                         ,sum(qtd_qbra_inv)      as Qtd_Quebra_Inventario
                         ,sum(vl_qbra_inv)       as Vl_Quebra_Inventario
                         ,sum(qtd_outr_sai)      as Qtd_Outras_Saida
                         ,sum(vl_outr_sai)       as Vl_Outras_Saida

               from

           ( ( Select     id_dt
                         ,cd_fil
                         ,cd_prod
                         ,git_descricao
                         ,git_grupo
                         ,git_dat_sai_lin
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
                         ,0 as qtd_vda
                         ,0 as vl_vda
                         ,0 as qtd_cmp
                         ,0 as vl_cmp

                   from agg_mvto_prod ,
                   (select id_dt as dt,dt_compl from dim_per dim where dt_compl between to_date('&Dt_Inicio','dd/mm/yyyy') and to_date('&Dt_Final','dd/mm/yyyy')),
                   (select git_cod_item ,git_digito,git_secao,git_grupo,git_descricao,git_dat_sai_lin  from aa3citem item where git_secao = '&secao')aa
                    where id_dt = dt
                     and cd_prod = aa.git_cod_item )
           union all
              ( Select
                          id_dt
                         ,cd_fil
                         ,cd_prod
                         ,git_descricao
                         ,git_grupo
                         ,git_dat_sai_lin
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,0
                         ,qtd_vda
                         ,vl_vda
                         ,0
                         ,0

                      from agg_vda_prod,
                      (select id_dt as dt,dt_compl from dim_per dim where dt_compl between to_date('&Dt_Inicio','dd/mm/yyyy') and to_date('&Dt_Final','dd/mm/yyyy')),
                      (select git_cod_item ,git_digito,git_secao,git_grupo,git_descricao,git_dat_sai_lin from aa3citem item where git_secao = '&secao')aa
                       where id_dt = dt
                       and cd_prod = aa.git_cod_item  )

         Union all
        ( Select   id_dt
                  ,cd_fil
                  ,cd_prod
                  ,git_descricao
                  ,git_grupo
                  ,git_dat_sai_lin
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,0
                  ,qtd_cmp
                  ,vl_cmp

                     from agg_cmp_prod,
                      (select id_dt as dt,dt_compl from dim_per dim where dt_compl between to_date('&Dt_Inicio','dd/mm/yyyy') and to_date('&Dt_Final','dd/mm/yyyy')),
                      (select git_cod_item ,git_digito,git_secao,git_grupo,git_descricao,git_dat_sai_lin from aa3citem item where git_secao = '&secao')aa
                       where id_dt = dt
                        and cd_prod = aa.git_cod_item )),
        (select ncc_secao,ncc_grupo,ncc_descricao from aa3cnvcc where ncc_grupo   > 0 
          and ncc_subgrupo  = 0 
          and ncc_categoria = 0 
          and ncc_secao ='&secao' 
            order by ncc_grupo)ncc 
              where ncc.ncc_grupo = git_grupo  
              group by cd_fil,cd_prod,git_descricao,git_grupo,git_dat_sai_lin,ncc.ncc_descricao
              order by cd_fil,git_descricao,produto
