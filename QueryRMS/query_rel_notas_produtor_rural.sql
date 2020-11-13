-- Empresa : Supermercado São Roque Ltda.
-- Data :22/07/2013 
-- Atualizado em : 22/07/2013
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Solange Pinheiro
-- Descrição : Retorna os valores das comptras do produtor rural.

select  to_number(fis_loj_dst||fis_dig_dst)  as Filial
       ,to_number(fis_loj_org||fis_Dig_org)  as cod
       ,tipo.tip_razao_social     as Razao
       ,tipo.tip_cgc_cpf          as CNPJ_CPF
       ,tipo.tip_cidade           as Cidade
       ,fis_nro_nota              as Nr_nota
       ,(fis_val_cont_ff_1+fis_val_cont_ff_2+fis_val_cont_ff_3+fis_val_cont_ff_4+fis_val_cont_ff_5) as Vlr_Contabil

from aa1cfisc ,
( select tip_codigo as Codigo
        ,tip_razao_social
        ,tip_cidade
        ,tip_cgc_cpf
        
   from aa2ctipo
  where tip_loj_cli = 'F'
    and tip_natureza in ('FF', 'FP'))tipo 

where fis_oper in( 04, 10)
 and fis_dta_agenda between  1||to_char(to_date( '&Dta_Inicio' ,'dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date( '&Dta_Final' ,'dd/mm/yyyy'),'yymmdd') --1141001 and 1141031
  and tipo.codigo = fis_loj_org 
order by 1,3
