-- Empresa : Supermercado São Roque Ltda.
-- Data : 05/10/11 
-- Desenvolvedor : Sandro Soares
-- Descrição : Analisar e solucionar problema de não gravar tickt no gerencial.

-- Consulta de quantidade de tickt por dia e por loja.
select * from agg_fvda_fil 
   where cd_fil = 18 
   and id_dt between 7943and 7946; --for update;
  
 -- Consulta de quantidade de tickt por mes e por loja. 
select * from agg_fvda_fil_mes 
  where cd_fil = 18
   and id_mes = 201105; --for update;
   
-- Consulta do id da data. 
select * from dim_per where dt_compl between to_date('01/10/2011','dd/mm/yyyy') and to_date('04/10/2011','dd/mm/yyyy');

--É desta tabela é pego a quantidade de item por dia e por loja.
select rms7to_date(rl_data) as dta
       ,rl_loja
      -- ,rl_caixa
       ,sum(rl_clientes_1)
  from ag2vrlcx 
   where rl_loja = 183 
   and rl_data between 1110901 and 1110930
  group by rl_data,rl_loja