-- Empresa : Supermercado São Roque Ltda. TI
-- Data :01/09/2017
-- Descrição : Verifica endereço que esta como sistematica 01 e fora de linha e produtos 
--             que tem endereço e não é sistematica 01
-- Desenvolvido : Sandro Soares
-- Solicitante : Andersom Grisolle
-- Atualizado em :
Select * 
from
(SELECT 
ees_galpao||'.'||Lpad(ees_rua,3,0)||'.'||Lpad(ees_nro,3,0)||'.'||Lpad(substr(ees_apt,1,1),2,0)||'.'||substr(ees_apt,2) as endereco,
EES_PROD_RESE as Codigo,
GIT_DESCRICAO as Descricao,
 CASE
    when git_sis_abast = 1 and  git_dat_sai_lin > 0  then nvl(git_sis_abast,0)
      when git_sis_abast !=1   then nvl(git_sis_abast,0)
        end as Sis_Abast,
   
--git_sis_abast,
rms7to_date(rms6to_rms7(git_dat_sai_lin)) as Fora_Linha 

 FROM AG3CEEST, AA3CITEM,
 AG1TPEST TPEST,
 AG1TPUNI TPUNI,
 AA2CTABE ZONA
WHERE AG3CEEST.EES_DEPOSITO = 1007
AND AG3CEEST.EES_TIPO_ENDERECO_1 = 1
AND SUBSTR(TO_CHAR(EES_PROD_RESE,'fm00000000'),1,7)  = GIT_COD_ITEM (+)
AND SUBSTR(TO_CHAR(EES_PROD_RESE,'fm00000000'),8,1)  = GIT_DIGITO   (+)
AND AG3CEEST.EES_GALPAO > 0
AND AG3CEEST.EES_RUA > 0
AND TPEST.EST_CODIGO (+) = EES_ESTRUTURA
AND UNI_CODIGO       (+) = EST_UNITIZADOR
AND ZONA.TAB_CODIGO (+) = 32
AND ZONA.TAB_ACESSO (+) = 'ZONA'||RPAD(TO_CHAR(SUBSTR(EES_ZONA,1,3),'fm000'),6,' ')
and EES_PROD_RESE > 0
ORDER BY git_sis_abast ,EES_DEPOSITO,EES_GALPAO,EES_RUA,EES_NRO,EES_APT)
 where sis_abast is not null
 

