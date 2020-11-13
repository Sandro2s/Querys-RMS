-- Empresa : Supermercado São Roque Ltda.
-- Data :06/02/2015 
-- Atualizado em : 06/02/2015
-- Desenvolvedor : Luciana - Superfestval
-- Solicitante : Tony
-- Descrição : Separação Mensal do deposito endereçado.

SELECT
   rms7to_date( t.mit_dt_inic)        AS Dia,
   t.mit_cod_ativ                     AS Ativ,
   i.git_cod_item|| i.git_digito      AS RMS,
   i.git_codigo_ean13 AS EAN,
    i.git_descricao      AS Descricao,
   i.git_sis_abast as S,
  t.mit_tip_movim      AS Tipo,
  t.mit_sta_movim      AS Status,
  t.mit_cliente        AS Filial,
  i.git_tpo_emb_transf AS Emb,
  t.mit_emb_col        AS EmbCol,
  t.mit_quant_sol      AS Pedido,
  t.mit_quant_col as Coletado,
  t.mit_quant_sol - t.mit_quant_col as Rup_pk,
  i.git_emb_transf     AS Qtd,
  t.mit_galpao_orig    AS G,
  t.mit_rua_orig       AS R,
  t.mit_predio_orig    AS P,
  t.mit_nivel_orig     AS N,
  t.mit_apto_orig      AS A,
  p.mov_cod_oper       AS Oper,       
  i.git_secao          AS Secao,
  t.mit_pallet_ean     AS Pallet,
  t.mit_dt_valid       AS Validade

FROM rms.ag5movdt t
INNER JOIN rms.ag5movcp p
ON t.mit_cod_ativ = p.mov_cod_ativ
INNER JOIN rms.aa3citem i
ON i.git_cod_item = t.mit_cod_prod

WHERE t.mit_dt_inic between 1||to_char(to_date('&Dta_Inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd')--1150206 and 1150206
and t.mit_tip_movim = ('CF')
--and t.mit_tip_movim IN ('CF','DL')
--and (t.mit_quant_sol - t.mit_quant_col) >0
and t.mit_sta_movim = ('FC')
--and   t.mit_cliente in 17
--and i.git_cod_item|| i.git_digito  in (1413961  ,
--and i.git_cod_item|| i.git_digito = 90433
--and t.mit_cod_ativ = 1218301
--AND t.mit_pallet_ean  = 898793
