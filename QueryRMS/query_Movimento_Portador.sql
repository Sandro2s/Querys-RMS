-- Empresa : Supermercado São Roque Ltda.
-- Data :20/08/2013 
-- Atualizado em : 19/01/2015
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Solange
-- Descrição : Traz a tela de pagamentos (VAPMPGTO) dos valores pagos por portador e fornecedor.


SELECT P_PORT as Portador,
       P_CHEQUE as Controle,
       P_NUM_CHQ as Cheque,
       rms7to_date(P_DT_PGTO) AS Dt_Pgto,
       P_FAVORECIDO as Fornecedor,
       to_number(P_VLR_CHQ + P_VLR_DIN) as Valor_Pagto,
       P_NUMERO as Qtde_Titulos,
       decode(p_nominal,'F','Fornecedor','P','Portador','B','Banco') as Nominal
  FROM AG1CDPAG
 WHERE P_PORT in (2341,237,3411,3341,9341,12341,4341)   
   AND (P_DT_PGTO >= 1||to_char(to_date( '&Dta_Inicio' ,'dd/mm/yyyy'),'yymmdd') AND P_DT_PGTO <= 1||to_char(to_date( '&Dta_Final' ,'dd/mm/yyyy'),'yymmdd'))
   AND P_FLAG_BAI = 'S'
   AND P_FLAG_CAN <> 'S'
   
