-- Supermercado São Roque Ltda.
-- Data : 29/10/2013
-- Solicitante : Zezinho 
-- Desenvolvedor : Sandro Soares
-- Descrição : Retornar quantidade de cupons por faixa de valor da compra.
--             Dever ser rodado na base de dados VisualMix (vm_log).
-- Manutenção : 29/10/2013

Select Loja
       ,sum(A) as "De 0 Ate R$50.00"
       ,sum(B) as "De R$51.00 ate R$100.00"
       ,sum(C) as "De R$101.00 ate R$200.00"
       ,sum(D) as "Maior R$201.00"


from
(
Select  
     Loja
    -- ,ct.tt
     ,Case
       when ct.tt > 0 and ct.tt <= 50.99 then count(ct.num_cupom) end A--Ate_50
     ,Case
       when ct.tt >= 51.00 and ct.tt <= 100.99 then count(ct.num_cupom) end B--De51_ate100
     ,Case
       when ct.tt >= 101.00 and ct.tt <= 200.99 then count(ct.num_cupom) end C--De101_ate200
     ,Case
       when ct.tt >= 201.00 then count(ct.num_cupom) end D--Maior_201


from
(
 select     Loja
            ,num_cupom 
            ,sum(preco_total)as tt  
       from item_venda 
        where data between to_date('&Dta_Inicio','dd/mm/yyyy') and to_date('&Dta_Fim','dd/mm/yyyy')   
        and cancelado = 0 
        group by loja,num_cupom
   )ct
    group by ct.Loja,ct.tt
 )
   group by loja
   order by 1;
--==========================================================================================================================
-- Traz cupons de todas as loja em um periodo, dia a dia 

Select Loja
       ,data
       ,sum(D) as "Maior R$100.00"


from
(
Select  
     Loja
     ,data
     ,Case
       when ct.tt >= 100.00 then count(ct.num_cupom) end D--Maior_201


from
(
 select     Loja
            ,data
            ,num_cupom 
            ,sum(preco_total)as tt  
       from item_venda 
        where data between to_date('&Dta_Inicio','dd/mm/yyyy') and to_date('&Dta_Fim','dd/mm/yyyy')   
        and cancelado = 0 
        group by loja,num_cupom,data
   )ct
    group by ct.Loja,ct.tt,ct.data
 )
   group by loja,data
   order by 1