-- Empresa : Supermercado São Roque Ltda.
-- Data :22/08/2012 
-- Atualizado em : 29/08/2018
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Solange
-- Descrição : Consultar pagamentos feito a um fornecedor em um determinado periodo retornando
--             data de pagamento, nota fiscal, valor da nota, desconto,abatimento e valor pago 
--             nota a nota. .


Select * from  
(
select case when cpd_desc >= 0 or cpd_vrsoci >= 0 then to_number(cpd_forne||dac(cpd_forne)) end Fornecedor
       ,cpd_loja||cpd_digito as Loja
       ,cpd_portador as Portador
       ,tipo.tip_nome_fantasia as Nome_Fantasia
       --,substr(to_char(cpm_dtpg,'fm0000000'),4,2)||'/'||substr(to_char(cpm_dtpg,'fm0000000'),2,2) as mes 
       ,cpd_ntfis  as NF
       ,cpd_vrnota as Vlr_Nota
       ,cpd_desc   as Vlr_Desconto
       ,cpd_vrsoci as Vlr_Abatimento
       ,cpd_desc   as Desconto
       ,cpd_juros  as Juros
       ,(cpd_vlr_pago_cheque + cpd_vlr_pago_dinhei)as Vlr_Pago
       ,Substr((cpm_dtpg),5,6)||'/'||Substr((cpm_dtpg),3,2)||'/'||Substr((cpm_dtpg),1,2) as Dta_Pagamento
       ,cpd_agenda as agenda
       ,cpd_secao as secao
       ,obs.observa as Obs
      
  from ag1pagcp,(select tip_codigo,tip_digito,tip_razao_social,tip_nome_fantasia from aa2ctipo where tip_loj_cli in('F','L','C','D'))tipo/*,
       (select  OBS_NTFIS as NT,obs_observacao as observa from  rms.aa1pobsr where OBS_NTFIS <> 0  group by OBS_NTFIS,obs_observacao) ob*/
       ,(select  OBS_NTFIS as NT,(listagg (rtrim(obs_observacao),' ')within group (order by obs_observacao)) as observa 
   from  rms.aa1pobsr where OBS_NTFIS <> 0 group by OBS_NTFIS)obs
 where cpm_dtpg between to_char(to_date('&dt_inicial','dd/mm/yyyy'),'yymmdd') and to_char(to_date('&dt_final','dd/mm/yyyy'),'yymmdd')-- incluir formato DD/MM/YY  
 --and cpd_forne not in (1,2,3,4,5,7,8,11,12,15,18,19,20,21,23,24,25,100,120)
 and cpd_forne = tipo.tip_codigo 
  and cpd_ntfis = obs.nt(+)
 --and cpd_agenda in (2,3,7)
 --and cpd_forne in (5386,4379,7783,7115,4172,1724,2574,3594,5219,1625)
 -- and cpd_desc <> 0 or cpd_vrsoci <> 0
 --and  to_number(cpd_forne||dac(cpd_forne)) is null

/*  group by cpd_forne,
        tip_nome_fantasia,
        cpd_loja,
        cpd_digito,
        cpd_portador,
        cpd_ntfis,
        cpd_vrnota,
        cpd_desc,
        cpd_vlr_pago_cheque,
        cpd_vlr_pago_dinhei,
        cpd_vrsoci,
        cpd_desc,
        cpd_juros,
        cpm_dtpg,
        cpd_agenda,
        cpd_secao,
        observa  */
         
  order by 8,1
 ) where Fornecedor is not null;

---------------------------------------------------------------------------------------------------------------
-- SOMA OS PAGEMENTOS DO FORNECEDOR
/*Select Fornecedor
       ,Nome_Fantasia
       ,Loja
       ,Portador 
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
       ,sum(Juros)        as Juro
       ,sum(vlr_pago)     as Valor_Pago
  from
(
select to_number(cpd_forne||dac(cpd_forne)) as Fornecedor
       ,tipo.tip_nome_fantasia as Nome_Fantasia
       --,substr(to_char(cpm_dtpg,'fm0000000'),4,2)||'/'||substr(to_char(cpm_dtpg,'fm0000000'),2,2) as mes 
       --,cpd_ntfis as NF
       ,cpd_loja||cpd_digito as Loja
       ,cpd_portador as Portador
       ,(cpd_vrnota) as Vlr_Nota 
       ,(cpd_desc) as Vlr_Desconto
       ,(cpd_juros)as Juros 
       ,(cpd_vlr_pago_cheque + cpd_vlr_pago_dinhei)as Vlr_Pago


  from ag1pagcp,(select tip_codigo,tip_digito,tip_razao_social,tip_nome_fantasia from aa2ctipo where tip_loj_cli = 'F')tipo
 where cpm_dtpg between 1||to_char(to_date('&dt_inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&dt_final','dd/mm/yyyy'),'yymmdd')-- incluir formato DD/MM/YY  
 and cpd_forne not in (1,2,3,4,5,7,8,9,10,11,12,14,15,18,19,20,21,23,24,100,120)
 and cpd_forne = tipo.tip_codigo
-- and cpd_forne = 1093 
    )
  group by fornecedor,Nome_Fantasia,Loja,Portador )
  
  Group by Fornecedor
       ,Nome_Fantasia
       ,Valor_Nota
       ,Valor_Desconto
       ,valor_pago
       ,Loja
       ,Portador
   order by 2
*/
--select * from aa1pobsr


