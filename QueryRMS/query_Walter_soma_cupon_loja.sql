-- Supermercado São Roque Ltda.
-- Data : 06/09/2011
-- Solicitante : Tony /Walter
-- Desenvolvedor : Sandro Soares
-- Descrição : Somariza os cupons vendido em uma loja.
--             Dever ser rodado na base de dados VisualMix (vm_log).
-- Manutenção : 15/12/2011

-------------------------------------------------------------------------------------------------------------
-- Soma todos os cupons de uma operadora e pega o primeiro digito da venda. (Loja 1,3,5,8,9,18,20 e 21)
Select a.data as Data
        ,to_number(a.operador)as Operador
        ,Cupom
        ,PDV
        ,tt as valor
        ,Case 
             when tt >= 1 then substr((tt),1,1)  
             when tt < 1 then substr((tt),2,1)  
         end as pri_dig
  from
  (
 select data 
           ,operador
           ,to_number(num_pdv)as PDV
           ,num_cupom as cupom
           ,sum(preco_total)as tt  
       from vm_log.item_venda 
        where data between to_date('&Dta_Inicio','dd/mm/yyyy') and to_date('&Dta_Fim','dd/mm/yyyy')   
        and loja = '&Loja_S_Dig'
        and cancelado = 0 
    group by operador ,data,num_cupom,num_pdv
    --order by data,operador
    )a
    order by operador ,a.tt; 

------------------------------------------------------------------------------
-- Retorna todos itens dos operadores com menos de 1400 cupons.
Select 
        iv.data
       ,iv.OPERADOR
       ,cod_interno as item 
       ,preco_total 
       ,Case 
          when IV.PRECO_TOTAL >= 1 then substr((IV.PRECO_TOTAL),1,1)  
          when IV.PRECO_TOTAL < 1 then substr((IV.PRECO_TOTAL),2,1)  
        end as pri_dig

  from 
     item_venda iv
  inner join
             (
      
      select operador
        from total_cupom
       where loja = 1
         and data between to_date('&Dta_Inicio','dd/mm/yyyy') and to_date('&Dta_Fim','dd/mm/yyyy')    
         and cancelado = 0
         group by operador
         having count(operador) <= 1400
        ) ope
        on iv.operador = ope.operador
          where data between to_date('&Dta_Inicio','dd/mm/yyyy') and to_date('&Dta_Fim','dd/mm/yyyy')   
            and loja = '&Loja_S_Dig'
------------------------------------------------------------------------------
--Movimento dos produtos do Açougue.
Select a.data as Data
        ,to_number(a.operador)as Operador
        ,Cupom
        ,PDV
        ,tt as valor
        ,Case 
             when tt >= 1 then substr((tt),1,1)  
             when tt < 1 then substr((tt),2,1)  
         end as pri_dig
  from
  (
 select data 
           ,operador
           ,to_number(num_pdv)as PDV
           ,num_cupom as cupom
           ,sum(preco_total)as tt  
       from item_venda 
        where data between to_date('&Dta_Inicio','dd/mm/yyyy') and to_date('&Dta_Fim','dd/mm/yyyy')   
        and loja = '&Loja_S_Dig'
        and cancelado = 0 
        and mercadologico2 = 305
    group by operador ,data,num_cupom,num_pdv
    --order by data,operador
    )a
    order by operador ,a.tt; 




------------------------------------------------------------------------------
-- Soma de valor por Operador.
Select to_number( operador) as Operador
        ,sum(tt) as valor
  from
  (
 select    operador
          ,sum(preco_total)as tt  
       from item_venda 
        where data between to_date('&Dta_Inicio','dd/mm/yyyy') and to_date('&Dta_Fim','dd/mm/yyyy')   
        and loja = '&Loja_00'
        and cancelado = 0 
    group by operador ,data,num_cupom,num_pdv
    
    )a
    group by operador
    order by 1
------------------------------------------------------------------------------
--Soma de valor por PDV
Select to_number(pdv) as PDV
        ,sum(tt) as valor
  from
  (
 select    to_number(num_pdv) as PDV
          ,sum(preco_total)as tt  
       from item_venda 
        where data between to_date('&Dta_Inicio','dd/mm/yyyy') and to_date('&Dta_Fim','dd/mm/yyyy')   
        and loja = '&Loja_00'
        and cancelado = 0 
    group by operador ,data,num_cupom,num_pdv
    
    )a
    group by pdv
    order by 1


    
------------------------------------------------------------------------------
-- Retorna o cancelamento por operadora e por loja.
select      Loja
            ,to_number(operador) as operador 
            ,op.nome as Nome
            ,count(operador) as contador
            ,sum(preco_total) as Total_R$  
           -- ,item_venda.*
       from item_venda, (select codigo,nome from vm_databsp.acesso_operadores order by codigo) op 
        where data between to_date('01/09/2012','dd/mm/yyyy') and to_date('30/09/2012','dd/mm/yyyy')   
        and loja in ( 1,3,5,21)
        and cancelado = 1
        and operador = op.codigo 
        group by loja,operador,op.nome
        order by loja,nome



---------------------------------------------------------------------------------
/*select mov.operador as Cod_Op
       ,tipo.nome as Operador
       ,sum( mov.valor) as Valor
       
       from 
(
  Select a.data as Dt_mov
        ,to_number(a.operador)as Operador
        ,Cupom
        ,PDV
        ,tt as valor
        ,Case 
             when tt >= 1 then substr((tt),1,1)  
             when tt < 1 then substr((tt),2,1)  
         end as pri_dig
  from
  (
 select data 
           ,operador
           ,to_number(num_pdv)as PDV
           ,num_cupom as cupom
           ,sum(preco_total)as tt  
       from item_venda 
        where data between to_date('01/03/2012','dd/mm/yyyy') and to_date('31/03/2012','dd/mm/yyyy')   
        and loja = 5
        and cancelado = 0 
    group by operador ,data,num_cupom,num_pdv
    --order by data,operador
    )a
    order by operador ,a.tt)mov,
    (select  to_number(codigo,'99999999')as cod 
             ,nome 
        from vm_databsp.acesso_operadores
        order by codigo)tipo
      
      where mov.operador = tipo.cod
        
    group by mov.operador,tipo.nome
*/    
/*------------------------------------------------------------------------------
-- Soma todos os cupons de uma PDV e pega o primeiro digito da venda.
Select a.data as Dt_mov
        ,to_number(num_pdv)as PDV
        ,Cupom
        , tt as valor
        ,Case 
             when tt >= 1 then substr((tt),1,1)  
             when tt < 1 then substr((tt),2,1)  
         end as pri_dig
  from
  (
 select data 
           ,num_pdv
           ,num_cupom as cupom
           ,sum(preco_total)as tt  
       from item_venda 
        where data between to_date('01/12/2011','dd/mm/yyyy') and to_date('24/12/2011','dd/mm/yyyy')   
        and loja = 5  
        and cancelado = 0 
    group by data,num_pdv,num_cupom
    --order by data,num_pdv
    )a
    order by num_pdv ,a.tt;
-------------------------------------------------------------------------------------------------------------
--
select  data
       ,Num_PDV
       ,to_number(operador) as Operador
       ,Num_cupom  
       ,sum(preco_total) as Total_Cupom
        
  from item_venda 
    where loja = 1  
    and cancelado = 0 
    and data between to_date('01/11/2011','dd/mm/yyyy') and to_date('30/11/2011','dd/mm/yyyy')  
 group by num_cupom,data,cancelado,operador ,Num_PDV
 order by data;
*/
-----------------------------------------------------------------------------------------------
--Pegar o primeiro digito e retornar quantos tem
/*select (a.pri_dig)
       ,(case a.pri_dig 
         when ',' then count(a.pri_dig)
         when '1' then count(a.pri_dig)
         when '2' then count(a.pri_dig)
         when '3' then count(a.pri_dig)
         when '4' then count(a.pri_dig)
         when '5' then count(a.pri_dig)
         when '6' then count(a.pri_dig)
         when '7' then count(a.pri_dig)
         when '8' then count(a.pri_dig)
         when '9' then count(a.pri_dig) 
        end ) as Total_Digito_Pri

 from
(
select cup.cupom
      ,cup.total_cupom
      ,to_char(substr(cup.total_cupom,1,1)) as pri_dig
 from
(
select num_cupom as cupom
       ,sum(preco_total) as Total_Cupom 
   from item_venda 
    where loja = 1  
    and cancelado = 0 
    and data between to_date('01/11/2011','dd/mm/yyyy') and to_date('30/11/2011','dd/mm/yyyy')  
group by num_cupom,operador ,Num_PDV
 )cup )a group by a.pri_dig;
*/ 
 -------------------------------------------------------------------------------------------------
 /*--Pegar o primeiro digito depois da virgula retornar quantidade 
 select (a.seg_dig)
       ,(case a.seg_dig 
         when '0' then count(a.seg_dig)
         when '1' then count(a.seg_dig)
         when '2' then count(a.seg_dig)
         when '3' then count(a.seg_dig)
         when '4' then count(a.seg_dig)
         when '5' then count(a.seg_dig)
         when '6' then count(a.seg_dig)
         when '7' then count(a.seg_dig)
         when '8' then count(a.seg_dig)
         when '9' then count(a.seg_dig) 
        end ) as Total_Digito_Seg

 from
(
select cup.cupom
      ,cup.total_cupom
      ,to_char(substr(to_char(cup.total_cupom,'0000.00'),-2,1)) as seg_dig
 from
(
select num_cupom as cupom
       ,sum(preco_total) as Total_Cupom 
   from item_venda 
    where loja = 1  
    and cancelado = 0 
    and data between to_date('01/11/2011','dd/mm/yyyy') and to_date('30/11/2011','dd/mm/yyyy')  
 group by num_cupom,operador ,Num_PDV
 )cup )a group by a.seg_dig
 
*/ ---------------------------------------------------------------------------------------------------------------
