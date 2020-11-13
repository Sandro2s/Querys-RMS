select  vend.dt as Dta
       ,sum(vend.cl) as Cliente
       ,sum(vend.reg) as Venda_Bruto
       ,sum(vend.maq) as Venda_Liquida
       ,sum(vend.can) as Cancelados
        from 
(
select rms7to_date (rl_data) dt
       ,sum (rl_clientes_1) cl
   --  ,rl_caixa  as Caixa
       ,sum(rl_vendreg_1) reg
       ,sum(rl_totmaq_1) maq
       ,sum(rl_cancelado_1)as can 
    from ag2vrlcx
where rms7to_date(rl_data) between to_date('&Dta_Incial','dd/mm/yyyy') and to_date('&Dta_Final','dd/mm/yyyy')
and rl_loja = 27
and rl_caixa in(31,32)
group by rl_caixa,rl_data
order by rl_data )vend
 group by vend.dt
