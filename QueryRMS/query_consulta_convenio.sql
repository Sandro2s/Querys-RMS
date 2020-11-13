-- Empresa : Supermercado São Roque Ltda. TI
-- Data :21/06/2012
-- Descrição : Consulta dos convenios
-- Desenvolvido : Sandro Soares
-- Atualizado em : 21/06/2012

      select a.conv_codigo as codigo,
             c.conv_descricao as decricao,
             a.cicl_codigo as ciclo,
             rms7to_date( a.cicl_dta_inicio)as dta_Incio,
             rms7to_date( a.cicl_dta_fim)as dta_fim,
             nvl(sum(lanc_valor ),0 )   as vl_vda
      from   ac2cvcic a, ac1clanc b, ac1cconv c
      Where  b.lanc_convenio   (+)  = a.conv_codigo
      and    b.lanc_modalidade (+) = 3
      and    b.lanc_tipo       (+)<> 2
      and    b.lanc_vencimento (+) between a.cicl_dta_inicio and a.cicl_dta_fim
      and    a.conv_codigo = c.conv_codigo
      group  by a.cicl_codigo, a.cicl_dta_inicio, a.cicl_dta_fim, a.cicl_dia_venc, a.cicl_status,a.conv_codigo, c.conv_descricao
      order by a.conv_codigo,a.cicl_codigo;
--------------------------------------------------------------------------------------------------------------------------------------
-- Retorna o valor total, contagem de quantos valores existe e a média.
Select  Codigo
        ,Descricao
        ,sum(vl_vda) as Venda_Valor
        ,count(codigo)as cotagem
        ,round(avg(vl_vda),2) as Media
 
 from  
 (
  select a.conv_codigo as codigo,
         c.conv_descricao as descricao,
         nvl(sum(lanc_valor), 0) as vl_vda
           from ac2cvcic a, ac1clanc b, ac1cconv c
   Where b.lanc_convenio(+) = a.conv_codigo
     and b.lanc_modalidade(+) = 3
     and b.lanc_tipo(+) <> 2
     and b.lanc_vencimento(+) between a.cicl_dta_inicio and a.cicl_dta_fim
     and a.conv_codigo = c.conv_codigo
     and b.lanc_valor > 0
   group by a.cicl_codigo,
            a.cicl_dta_inicio,
            a.cicl_dta_fim,
            a.cicl_dia_venc,
            a.cicl_status,
            a.conv_codigo,
            c.conv_descricao
   order by a.conv_codigo, a.cicl_codigo
  )
  group by codigo, descricao 
 