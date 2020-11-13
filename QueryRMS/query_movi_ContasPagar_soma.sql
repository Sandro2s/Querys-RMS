-- Empresa : Supermercado São Roque Ltda.
-- Data :06/08/2012 
-- Atualizado em : 25/06/2013
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Solange
-- Descrição : Consultar pagamentos feito a um fornecedor em um determinado periodo retornando
--             data de pagamento, nota fiscal, valor da nota, desconto e valor pago com desconto.

Select Fornecedor
       ,Nome_Fantasia
       ,Valor_Nota
       ,Valor_Desconto
       ,case
        when valor_desconto = 0 or valor_nota = 0 then 0
        else round(trunc((Valor_Desconto/Valor_Nota)*100,2),2)end  Percent_Desc
       ,valor_pago
 from
(
select Fornecedor
       ,Nome_fantasia
       ,sum(vlr_nota)  as Valor_Nota
       ,sum(vlr_desconto) as Valor_Desconto
       ,sum(vlr_pago)     as Valor_Pago
  from
(
select to_number(cpd_forne||dac(cpd_forne)) as Fornecedor
       ,tipo.tip_nome_fantasia as Nome_Fantasia
       --,substr(to_char(cpm_dtpg,'fm0000000'),4,2)||'/'||substr(to_char(cpm_dtpg,'fm0000000'),2,2) as mes 
       --,cpd_ntfis as NF
       ,(cpd_vrnota) as Vlr_Nota
       ,(cpd_desc) as Vlr_Desconto
       ,(cpd_vlr_pago_cheque + cpd_vlr_pago_dinhei)as Vlr_Pago


  from ag1pagcp,(select tip_codigo,tip_digito,tip_razao_social,tip_nome_fantasia from aa2ctipo where tip_loj_cli = 'F')tipo
 where cpm_dtpg between 140501 and 140531
 and cpd_forne not in (1,2,3,4,5,7,8,9,10,11,12,14,15,18,19,20,21,23,24,100,120)
 and cpd_forne = tipo.tip_codigo
-- and cpd_forne = 1093
  order by 1 )
  group by fornecedor,Nome_Fantasia )
  
  Group by Fornecedor
       ,Nome_Fantasia
       ,Valor_Nota
       ,Valor_Desconto
       ,valor_pago





/*Select  distinct(Fornecedor)
       ,Nome_Fantasia
       ,Mes
       ,sum(vlr_nota) as vlr_nota
       ,case
        when vlr_desconto = 0 or vlr_pago = 0 then 0 
        else round(trunc((vlr_desconto/vlr_pago)*100,2),1)end Percent_Desc
       ,Vlr_Desconto
       ,sum(Vlr_Pago) as vlr_pago
from
(
select (cpd_forne||'-'||dac(cpd_forne)) as Fornecedor
       ,tipo.tip_nome_fantasia as Nome_Fantasia
       ,substr(to_char(cpm_dtpg,'fm0000000'),4,2)||'/'||substr(to_char(cpm_dtpg,'fm0000000'),2,2) as mes 
       ,cpd_ntfis as NF
       ,cpd_vrnota as Vlr_Nota
       \*,case
        when cpd_desc = 0 or cpd_vrnota = 0 then 0 
        else round(trunc((cpd_desc/cpd_vrnota)*100,2),1)end Percent_Desc*\
       ,cpd_desc as Vlr_Desconto
       ,cpd_vlr_pago_cheque + cpd_vlr_pago_dinhei as Vlr_Pago


  from ag1pagcp,(select tip_codigo,tip_digito,tip_razao_social,tip_nome_fantasia from aa2ctipo where tip_loj_cli = 'F')tipo
 where cpm_dtpg between 130501 and 130531
 and cpd_forne not in (1,2,3,4,5,7,8,9,10,11,12,14,15,18,19,20,21,23,24,100,120)
 and cpd_forne = tipo.tip_codigo
 order by 1 )
  group by Fornecedor
           ,Nome_Fantasia
           ,Mes
           ,vlr_desconto
           ,vlr_pago
           */