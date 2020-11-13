-- Empresa : Supermercado São Roque Ltda.
-- Data :06/08/2012 
-- Atualizado em : 06/08/2014
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Solange
-- Descrição : Consultar pagamentos feito a um fornecedor em um determinado periodo retornando
--             data de pagamento, nota fiscal, valor da nota, desconto e valor pago com desconto.

select cpd_forne||dac(cpd_forne) as Fornecedor
       ,substr(to_char(cpm_dtpg,'fm0000000'),6,2)||'/'|| substr(to_char(cpm_dtpg,'fm0000000'),4,2)||'/'||substr(to_char(cpm_dtpg,'fm0000000'),2,2) as dta
       ,cpd_ntfis as NF
       ,cpd_vrnota as Vlr_Nota
       ,round(trunc((cpd_desc/cpd_vrnota)*100,2),1) as Percent_Desc
       ,cpd_desc as Vlr_Desconto
       ,cpd_vlr_pago_cheque + cpd_vlr_pago_dinhei as Vlr_Pago
       

  from ag1pagcp
 where cpd_forne = 2992
   and cpm_dtpg between 70101 and 120731 