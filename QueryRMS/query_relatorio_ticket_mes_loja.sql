-- Empresa : Supermercado São Roque Ltda.
-- Data :04/05/2012 
-- Atualizado em : 04/05/2012
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Zezinho
-- Descrição : Consulta de Ticket mes por loja.
  
 select loja 
        ,sum(a) as Janeiro
        ,sum(b) as Fevereiro
        ,sum(c) as Marco
        ,sum(d) as Abril
        ,sum(e) as Maio
        ,sum(f) as Junho
        ,sum(g) as Julho
        ,sum(h) as Agosto
        ,sum(i) as Setembro
        ,sum(j) as Outubro
        ,sum(l) as Novembro
        ,sum(m) as Dezembro
        from  
 
 (
 Select a.loja
        --,sum(a.ticket)
        ,case dta when '01' then ticket end A
        ,case dta when '02' then ticket end B
        ,case dta when '03' then ticket end C
        ,case dta when '04' then ticket end D
        ,case dta when '05' then ticket end E
        ,case dta when '06' then ticket end F
        ,case dta when '07' then ticket end G
        ,case dta when '08' then ticket end H
        ,case dta when '09' then ticket end I
        ,case dta when '10' then ticket end J
        ,case dta when '11' then ticket end L
        ,case dta when '12' then ticket end M
        from
 
 (
select  max(rl_loja) as Loja
       ,max(to_char(rms7to_date(rl_data),'MM'))as Dta
       ,sum(rl_clientes_1) as ticket 

  from ag2vrlcx
Where rl_Loja >= 19
 and rms7to_date( rl_data) between to_date('&Dta_Inicial_ddmmyyyy','dd/mm/yyyy') and to_date('&Dta_Final_ddmmyyyy','dd/mm/yyyy')
group by rl_loja,rl_data
  )a
   group by a.loja,dta,ticket
 ) group by loja