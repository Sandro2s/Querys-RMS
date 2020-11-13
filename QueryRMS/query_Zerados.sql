-- Empresa : Supermercado São Roque Ltda. TI
-- Data :31/08/2017
-- Descrição : Verifica as quantidade que foram zeradas na separação e conferencia.
-- Desenvolvido : Sandro Soares
-- Solicitante : Andersom Grisolle
-- Atualizado em :
select 
 PALI_PRODUTO || DAC(PALI_PRODUTO)as PRODUTO,
 GIT_DESCRICAO as Descricao,
 PALI_GALPAO ||'.'||TO_CHAR(PALI_RUA, 'FM000')||'.'||TO_CHAR(PALI_NRO, 'FM000')||'.'||SUBSTR(TO_CHAR(PALI_APTO, 'FM000'),1,2)||'-'||SUBSTR(TO_CHAR(PALI_APTO, 'FM000'),3,1) ENDERECO,
 rms7to_date(pale_dta_ini_sep) as DataIni,
 Decode( pali_qtd_ped,0,'0', pali_qtd_ped) as Qtd_Ped,
 Decode( pali_qtd_sep,0,'0', pali_qtd_sep) as Qtd_Sep ,  
 Decode(pali_qtd_cnf,0,'0',pali_qtd_cnf)   as Qtd_Conf,
 PALI_TPO_EMB || TO_char(PALI_QTD_EMB,'fm00000') as TIPO_EMBALAGEM,
 (GET_ESTOQUE /PALI_QTD_EMB) as Estoque ,
 pale_operador ||'/'||decode(pale_tipo_automacao,0,' Romaneio', 1,' PDT RF')as Operador
 
   From ag5cpali, ag5cpall, aa2cestq, aa3citem
     Where pali_deposito    = pale_deposito
     and pali_carga         = pale_carga
     and pali_destino       = pale_destino
     and pali_palete        = pale_palete
     and pali_qtd_ped != decode(nvl(pali_dt_fim_cnf,0),0,pali_qtd_sep,pali_qtd_cnf)
     AND GIT_COD_ITEM       = PALI_PRODUTO
     and GET_COD_PRODUTO(+) = PALI_PRODUTO||DAC(PALI_PRODUTO)
     and GET_COD_LOCAL(+)   = PALI_DEPOSITO||DAC(PALI_DEPOSITO)
     and PALE_AJUSTE   = 1
     AND PALI_DEPOSITO = 100
     AND PALI_CARGA    > 0
     AND PALI_DESTINO  > 0
     AND PALI_PALETE   > 0
     AND GIT_COD_ITEM  > 0
     --AND GIT_COD_ITEM = 1032
     and pale_dta_ini_sep between dateto_rms7(to_date('25/08/17','dd/MM/yy')) and dateto_rms7(to_date('25/08/17','dd/MM/yy')) 
     order by  1
