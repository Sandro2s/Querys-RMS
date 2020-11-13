select ac.lanc_codigo                 as codigo,
       rms7to_date( ac.lanc_data)     as Dta_Inclusao,
       rms7to_date(ac.lanc_vencimento)as Vencimeno,
       ac.lanc_loja                   as Loja,
       ac.lanc_valor                  as Valor,
       ac.lanc_convenio               as Convenio,
       ac.lanc_modalidade,
       ac.lanc_parcela
 from ac1clanc ac where ac.lanc_vencimento = 1100220
 order by dta_inclusao,codigo



--select * from ac1clanc ac where ac.lanc_codigo = 11157690