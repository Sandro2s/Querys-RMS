-- Supermercado São Roque Ltda.
-- Data : 23/09/2011
-- Solicitante : José Santiago
-- Desenvolvedor : Sandro Soares
-- Descrição : Auditoria do contas a pagar.
-- Manutenção : 23/09/2011


select  cpd_empresa as empresa
       ,cpd_loja||cpd_digito as Loja
       ,cpd_forne||dac(cpd_forne) as Fornecedor
       ,descricao.tip_nome_fantasia as Descricao
       ,cpd_ntfis  as NF
       ,cpd_agenda as agenda
       ,cpd_portador as Portador
       ,to_date(substr(to_char(cpd_recep,'000000'),6,2)||'/'||substr(to_char(cpd_recep,'000000'),4,2)||'/'||substr(to_char(cpd_recep,'000000'),2,2),'dd/mm/yy') as Dta_Entrada
      -- ,substr(to_char(cpd_apanha,'000000'),6,2)||'/'||substr(to_char(cpd_apanha,'000000'),4,2)||'/'||substr(to_char(cpd_apanha,'000000'),2,2) as Dta_Apanha
       ,rms7to_date(cpm_venc) as venc
       ,nvl(substr(to_char(cpm_dtpg,'000000'),6,2)||'/'||substr(to_char(cpm_dtpg,'000000'),4,2)||'/'||substr(to_char(cpm_dtpg,'000000'),2,2),0)as Dta_Pagamento
       ,cpd_vrnota as Valor
       
from ag1pagcp,
(
 select tip_codigo,tip_digito ,tip_nome_fantasia from aa2ctipo where tip_codigo > 0 order by tip_codigo
 ) descricao 
   where CPD_EMPRESA > 1
    --and cpd_loja  not in (100,120) 
    and cpd_agenda not in (651,652,653,654,674,725) 
    and  to_date(substr(to_char(cpd_recep,'000000'),6,2)||'/'||substr(to_char(cpd_recep,'000000'),4,2)||'/'||substr(to_char(cpd_recep,'000000'),2,2),'dd/mm/yy') 
         between to_date('01/01/2011','dd/mm/yyyy')and to_date('31/08/2011','dd/mm/yyyy') 
    and cpd_forne  = descricao.tip_codigo
   order by cpd_loja,dta_entrada 