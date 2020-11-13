-- Empresa : Supermercado São Roque Ltda.
-- Data :22/12/2014 
-- Atualizado em : 22/12/2014
-- Desenvolvedor : Sandro Soares
-- Solicitante : Tony, Kátia
-- Descrição : Retorna as movimentações da portária.

select tip_razao_social
       ,agdd_doca as Doca
       ,agdc_caixas as Caixas
       ,agdc_paletes as Paletes
       ,rms7to_date(agdd_data_prev) as Dta_Agendado
       ,substr(to_char(agdd_hora_ini,'0000'),1,3)||':'||substr(to_char(agdd_hora_ini,'0000'),4,2) as Agenda_Inicio
       ,substr(to_char(agdd_hora_fim,'0000'),1,3)||':'||substr(to_char(agdd_hora_fim,'0000'),4,2) as Agenda_Fim
       ,substr(to_char(agdc_hora_cheg,'0000'),1,3)||':'||substr(to_char(agdc_hora_cheg,'0000'),4,2) as Chegada
       ,substr(to_char(agdc_hora_ini_des,'0000'),1,3)||':'||substr(to_char(agdc_hora_ini_des,'0000'),4,2) as Descarga_Inicio
       ,substr(to_char(agdc_hora_fim_des,'0000'),1,3)||':'||substr(to_char(agdc_hora_fim_des,'0000'),4,2) as Descarga_Fim
       ,substr(to_char(agdc_hora_saida,'0000'),1,3)||':'||substr(to_char(agdc_hora_saida,'0000'),4,2) as Saida 
       ,agdc_observacao as Observacoes
from ag1agdct,ag1agddc,
       (select tip_codigo, tip_razao_social 
     from aa2ctipo where tip_loj_cli = 'F')forn 
  where agdc_origem =  agdd_origem
  and agdc_destino = agdd_destino
  and agdc_senha = agdd_senha
  and agdc_origem = forn.tip_codigo 
  and agdc_data_prev between   1||to_char(to_date( '&Dta_Inicio' ,'dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date( '&Dta_Final' ,'dd/mm/yyyy'),'yymmdd')     --between 1141201 and 1141231
  order by 5,1

  
  
 