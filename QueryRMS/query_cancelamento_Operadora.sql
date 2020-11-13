-- Supermercado São Roque Ltda.
-- Data : 11/12/2012
-- Solicitante : Pamela / Solange
-- Desenvolvedor : Sandro Soares
-- Descrição : Traz a soma dos cancelamento por operadora.
--             Esta query dever ser rodada no banco da visual mix.
-- Manutenção : 11/12/2011

-- Retorna o cancelamento por operadora e por loja.
select      Loja
            ,to_number(operador) as operador
            ,op.nome as Nome
            ,count(operador) as contador
            ,sum(preco_total) as Total_R$
           -- ,item_venda.*
       from item_venda, (select codigo,nome from vm_databsp.acesso_operadores order by codigo) op
        where data between to_date('&Dta_Inicio: ','dd/mm/yyyy HH24:MI:SS') and to_date('&Dta_Final:','dd/mm/yyyy HH24:MI:SS')
        and loja in (1,2,3,4,5,7,8,9,11,12,15,18,19,20,21,22)
        and cancelado = 1
        and operador = op.codigo
        group by loja,operador,op.nome
        order by loja,nome
----------------------------------------------------------------------------------------------------------------------------------------
-- Retorna o cancelamento de um operador dia a dia
select      Loja
            ,data
            ,to_number(operador) as operador
            ,op.nome as Nome
            ,operador as contador
            ,preco_total as Total_R$
       from item_venda, (select codigo,nome from vm_databsp.acesso_operadores order by codigo) op
        where data between to_date('&Dta_Inicio: ','dd/mm/yyyy HH24:MI:SS') and to_date('&Dta_Final:','dd/mm/yyyy HH24:MI:SS')
        and loja = 1
        and cancelado = 1
        and operador = op.codigo
        and operador = 103521
        
        order by loja,nome