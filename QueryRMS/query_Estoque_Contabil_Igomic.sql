-- Empresa : Supermercado São Roque Ltda.
-- Data : 26/10/2010
-- Atualizado em : 26/10/2010
-- Desenvolvedor : Sandro Soares.
-- Descrição : Faz previsão de tributação (Pis/Cofins e Icms) com base no inventário 
--             contabil gerado.

select distinct 
       operacao
       ,rat_cod_local as Loja
       ,sum(qtd_estoque) as qtd_estoque
       ,round(sum(vlr_total),2) as vlr_total
       ,round(sum(vlr_total),2) as vlr_total
       ,round(sum(vlr_PisCofins),2) as vlr_PisCofins
       ,round(sum(vlr_Icms),2)as vlr_Icms 

 from 
          (
          Select (case git_sis_abast
                      when  20 then 'Venda'
                      Else 'Devolução'
                   end)as Operacao
                 -- rat_cod_produto||rat_dig_produto as Codigo
                 ,sum(rat_estq_loja) as Qtd_Estoque
                 --,rat_valor as Vlr_Unit
                ,sum(vlr_total) as Vlr_Total 
                 --,git_nat_fiscal as Figura
                 --,git_sis_abast as Sist_Abast
                 --,pis_cofins as Aliq_PisCofins
                 --,tfis_codigo as CFOP
                 --,tfis_aliq_icm as Aliq_ICMS
                 --,tfis_base_reduz as reducao
                 ,sum((vlr_total* pis_cofins)/100) as Vlr_PisCofins
                 ,sum((vlr_total*(tfis_aliq_icm-(tfis_aliq_icm*(tfis_base_reduz/100))))/100) as Vlr_ICMS
                 ,rat_cod_local
           from
                  (
                          Select * from 
                          (
                          select rat_cod_local
                                ,rat_cod_produto 
                                ,rat_dig_produto
                                ,rat_estq_loja
                                ,rat_valor
                                ,rat_valor * rat_estq_loja as vlr_total
                                 from  ag1nrate where rat_num_invent in(113659,113660)
                                group by rat_cod_produto,rat_dig_produto,rat_estq_loja,rat_valor,rat_cod_local
                                order by rat_cod_produto
                           )rateio inner join
                                
                           (     select  git_cod_item
                                        ,git_digito
                                        ,git_nat_fiscal
                                        ,git_sis_abast
                                        ,decode ( git_categoria_ant ,0, '9,25', 1,0,2,0)as Pis_Cofins  
                                   from aa3citem
                                 --  where  git_secao in (100,101,102,103,104,105,106,107,108,109,110,111,112,200,201,300,301,302,303,304,305,306,400,401,402,403,501)
                                   order by git_cod_item
                             )prod on rateio.rat_cod_produto = prod.git_cod_item
                            
                     ) ratprod inner join          
               ( select tfis_figura
                      ,tfis_codigo
                      ,tfis_aliq_icm
                      ,tfis_base_reduz
                      ,decode(tfis_aliq_str,0.0100,0,tfis_aliq_str) as IVA
                   from aa2tfisc
                     where tfis_origem = 'SP'
                     and tfis_destino = 'SP'
                     and tfis_codigo in (512,574,532,578)
                     order by tfis_figura
               ) tab on ratprod.git_nat_fiscal = tab.tfis_figura
               
             where vlr_total > 0
              --and git_sis_abast not in  20
              and tfis_codigo = 532
              group by git_sis_abast,rat_cod_local
          )
           group by operacao, rat_cod_local
           order by Loja