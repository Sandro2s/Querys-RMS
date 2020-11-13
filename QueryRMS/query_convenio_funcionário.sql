-- Empresa : Supermercado São Roque Ltda.
-- Data : 28/02/12 
-- Desenvolvedor : Sandro Soares
-- Solicitante : Solange Pinheiro
-- Descrição : 
-- Entradas de produtos.

select * from 
( select cli_codigo||cli_digito as Codigo
       ,cli_nome as Nome
       ,cli_nro_func as Matricula
       ,cli_nome_empresa as Loja
       ,cli_convenio as convenio

  from cad_cliente inner join 
              (select lim_codigo||lim_digito as cod
                     ,lim_status as status
                     from ac1qlimi 
                     where lim_Modalidade = 3
                     and lim_status <> 1 )limite 
                    on cli_codigo||cli_digito = limite.cod

  where cli_nome like 'C0%' or
        cli_nome like 'C1%' or 
        cli_nome like 'C2%' or
        cli_nome like 'C3%' or
        cli_nome like 'C4%' or
        cli_nome like 'C5%' or
        cli_nome like 'C6%' or
        cli_nome like 'C7%' or
        cli_nome like 'C8%' or
        cli_nome like 'C9%' 
    order by convenio,cli_nome )
    where convenio in (1,2,3,4,5,6,7,8,9,10,11,12,15,16,50,51,56,57,58,63,64,65,66,67,85,86,91)                                                           
    
    