-- Supermercado São Roque Ltda.
-- Data : 07/02/2014
-- Solicitante : Solange / André
-- Desenvolvedor : Sandro Soares
-- Descrição : Totalizar a venda, custo e cupom que passaram no PDV 31 e 32.
--             Dever ser rodado na base de dados VisualMix (vm_log).
--              vm_log senha:pa$$VMx10
-- Manutenção : 07/02/2014

Select  Mes
       ,sum(pc) as TT_Custo
       ,sum(pv) as TT_Venda
       ,count(NC) as TT_Cupom
 from 
(
select  to_char(data,'MM')mes
       , sum(preco_custo) as PC 
       ,sum(preco_total-desconto) as PV
       ,num_cupom as NC

from  vm_log.item_venda  --  item_venda 
  where data between to_date('&Dta_Inicial','dd/mm/yyyy') and to_date('&Dta_Final','dd/mm/yyyy') 
   and mercadologico2 not in  401
   and num_pdv in (31,32,110,111)
   and loja = 2
   and cancelado = 0
   group by num_cupom,data 
   )
   group by mes
   order by mes 
   --select to_char(to_date('13/02/2014','dd/mm/yyyy'),'MM') from dual
