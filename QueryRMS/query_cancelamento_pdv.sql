-- Supermercado São Roque Ltda.
-- Data : 11/12/2012
-- Solicitante : Solange
-- Desenvolvedor : Sandro Soares
-- Descrição : Cancelamento por PDV que sobem pela Tesourária RMS.
-- Manutenção : 11/12/2011

--Retorna cancelamento por PDV
select  rl_loja as Loja
         ,rms7to_date (rl_data) as Dta
         ,rl_caixa as PDV
         ,rl_cancelado_1 as cancelamento

    from ag2vrlcx
 where  rms7to_date(rl_data) between to_date('&Dt_Inicio','dd/mm/yyyy') and to_date('&Dt_Final','dd/mm/yyyy')
 and rl_cancelado_1 > 0
 order by Loja,dta,pdv
