-- Empresa : Supermercado São Roque Ltda. TI
-- Data :27/08/2018
-- Descrição : Analise das pendencia,saida média e dias de cobertura do produtos sistemática 01
-- Desenvolvido : Sandro Soares
-- Solicitante : 
-- Atualizado em :
-------------------------------------------------------------------------------------------
select * from 
(select git_secao,
       git_cod_item||git_digito as cod,
       git_descricao,
       get_estoque,
       get_qtd_pend,
       get_vend_acum_ano as Saida_media,
      round(decode((get_vend_acum_ano),0,0,((get_estoque + get_qtd_pend)/get_vend_acum_ano))) as Dias_Cobertura,
      dep.estcd
        
       
from aa3citem,aa2cestq, (select get_cod_produto as codpro,get_estoque as estcd from aa2cestq where get_cod_local = 1007)dep
where git_cod_item||git_digito = get_cod_produto
and git_dat_sai_lin = 0
and git_sis_abast = 1
and git_secao in (100,101,102,103,104,105,106,107,108,109,110,111,112,200,201,302,306,400)
and get_cod_local = 19
and get_cod_produto = dep.codpro
--and get_qtd_pend = 0 --!= 0
order by 1,3)
where dias_cobertura <= 8

--(select get_cod_produto,get_estoque from aa2cestq where get_cod_local = 1007)dep
