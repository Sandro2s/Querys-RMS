-- Empresa : Supermercado São Roque Ltda.
-- Data :12/12/2014 
-- Atualizado em : 12/12/2014
-- Desenvolvedor : Vanderson Moreno
-- Solicitante : Solange Pinheiro
-- Descrição : Consulta e retorna os pdvs atulizados na tesourária.
select rl_loja as LOJA,
       rl_caixa as ECF,
       rms7to_date(rl_data) as DATA
from ag2vrlcx
where rl_data between 1141201 and 1141219
and rl_totmaq_1  > 0 
order by 1,2,3

