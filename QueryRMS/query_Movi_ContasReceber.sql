-- Empresa : Supermercado São Roque Ltda.
-- Data :13/12/2013 
-- Atualizado em : 06/10/2016
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Solange
-- Descrição : Retorna os titulos recebido do Contas a Receber.

Select * from 
(
Select   rms7to_date(dup.dup_dt_pag) as Dt_Pagmento
        ,to_number(dup.dup_cod_cli||dup.dup_dig_cli) as Cliente
        ,dup.dup_filial||dup.dup_dig_filial as Loja
        ,dup.dup_titulo as Titulo
        ,dup.dup_agenda as agenda
        ,dup.dup_port as portador
        ,rms7to_date(1||dup.dup_dt_emi) as dt_emissao
        ,rms7to_date(dup.dup_venc) as dt_vencimento
        ,dup.dup_valor as Vlr_Bruto
        ,dup.dup_abatimento as Abatimento
        ,dup.dup_valor_pag  as Vl_Liquido
        ,dup.dup_desc as Desconto
        ,dup.dup_juros as Juros
        ,dup.obs_observacao as  obs
        

from

(
select *  from aa1rtitu  left outer  join aa1robsr 
  on  dup_titulo = obs_titulo
  and dup_desd = obs_desd
  and dup_cod_fil = obs_cod_fil 

)dup
 where dup.dup_dt_pag between 1||to_char(to_date('&dt_inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&dt_final','dd/mm/yyyy'),'yymmdd')-- incluir formato DD/MM/YY
  and dup.dup_dt_pag <> 0
  and nvl(obs_nro_seq,0) = 1
     
Union all

Select   rms7to_date(dup.dup_dt_pag) as Dt_Pagmento
        ,to_number(dup.dup_cod_cli||dup.dup_dig_cli) as Cliente
        ,dup.dup_filial||dup.dup_dig_filial as Loja
        ,dup.dup_titulo as Titulo
        ,dup.dup_agenda as agenda
        ,dup.dup_port as portador
        ,rms7to_date(1||dup.dup_dt_emi) as dt_emissao
        ,rms7to_date(dup.dup_venc) as dt_vencimento
        ,dup.dup_valor as Vlr_Bruto
        ,dup.dup_abatimento as Abatimento
        ,dup.dup_valor_pag  as Vl_Liquido
        ,dup.dup_desc as Desconto
        ,dup.dup_juros as Juros
        ,dup.obs_observacao as  obs
        

from

(
select *  from aa1rtitu  left outer  join aa1robsr 
  on  dup_titulo = obs_titulo
  and dup_desd = obs_desd
  and dup_cod_fil = obs_cod_fil 

)dup
 where dup.dup_dt_pag between 1||to_char(to_date('&dt_inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&dt_final','dd/mm/yyyy'),'yymmdd')-- incluir formato DD/MM/YY 
  and dup.dup_dt_pag <> 0
  and nvl(obs_nro_seq,0) = 0
 )
 --where substr(cliente,1,4) in (5386,4379,7783,7115,4172,1724,2574,3594,5219,1625)
 order by 1,2,3

-----------------------------------------------------------------------------------------------------------------------------
/*Select   rms7to_date(dup.dup_dt_pag) as Dt_Pagmento
        ,to_number(dup.dup_cod_cli||dup.dup_dig_cli) as Cliente
        ,dup.dup_filial||dup.dup_dig_filial as Loja
        ,dup.dup_titulo as Titulo
        ,dup.dup_agenda as agenda
        ,dup.dup_port as portador
        ,rms7to_date(1||dup.dup_dt_emi) as dt_emissao
        ,rms7to_date(dup.dup_venc) as dt_vencimento
        ,dup.dup_valor as Vlr_Bruto
        ,dup.dup_abatimento as Abatimento
        ,dup.dup_valor_pag  as Vl_Liquido
        ,dup.dup_desc as Desconto
        ,dup.dup_juros as Juros
        ,ob.observacao as Observacao
        
      

from aa1rtitu dup, (select obs_titulo,obs_desd,obs_cod_fil,(listagg(rtrim(obs_observacao),' ')within group (order by obs_nro_seq ))as observacao 
from aa1robsr group by obs_titulo,obs_desd,obs_cod_fil)ob
 where dup.dup_dt_pag between 1||to_char(to_date('&dt_inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&dt_final','dd/mm/yyyy'),'yymmdd')-- incluir formato DD/MM/YY
  and dup.dup_dt_pag <> 0
  and dup.dup_titulo  (+)= ob.obs_titulo
  and dup.dup_desd    (+)= ob.obs_desd
  and dup.dup_cod_fil (+)= ob.obs_cod_fil

 
 group by dup_dt_pag,
          dup_cod_cli,
          dup_dig_cli,
          dup_filial,
          dup_dig_filial,
          dup_titulo, 
          dup_agenda,
          dup_port,
          dup_dt_emi,
          dup_venc,
          dup_valor, 
          dup_abatimento,
          dup_valor_pag,
          dup_desc, 
          dup_juros,
          ob.Observacao 
*/
