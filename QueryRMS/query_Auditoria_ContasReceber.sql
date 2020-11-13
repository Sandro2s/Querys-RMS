-- Empresa : Supermercado São Roque Ltda.
-- Data :24/04/2017
-- Atualizado em : 24/04/2017
-- Desenvolvedor : Joaquim.
-- Solicitante : Solange Pinheiro
-- Descrição : Saldo do contas a receber desenvolvido para auditória.
--             retorna a notas em aberto

Select   rms7to_date(dup.dup_dt_pag) as Dt_Pagmento
        ,to_number(dup.dup_cod_cli||dup.dup_dig_cli) as Cliente , tip_razao_social
        ,dup.dup_filial||dup.dup_dig_filial as Loja
        ,dup.dup_titulo as Titulo
        ,dup.dup_agenda as agenda
        ,to_date((to_char(dup_dt_emi,'000000')),'yymmdd') as dt_emissao
        ,rms7to_date(dup.dup_venc) as Dta_Vencimento
        ,dup.dup_valor as Vlr_Bruto
        ,dup.dup_abatimento as Abatimento
        ,dup.dup_valor_pag  as Vl_Liquido
        ,dup.dup_desc as Desconto
        ,dup.dup_juros as Juros
from aa1rtitu dup, aa2ctipo
 where dup.dup_dt_agenda <= to_char(to_date('&Ult_Dia_Mes','dd/mm/yyyy'),'yymmdd')
  and (dup.dup_dt_pag = 0 or (dup_dt_pag > 1||to_char(to_date('&Ult_Dia_Mes','dd/mm/yyyy'),'yymmdd')) )
  and tip_codigo = dup.dup_cod_cli
  order by dup.dup_filial, rms7to_date(1||dup.dup_dt_emi), dup.dup_cod_cli, dup.dup_titulo
