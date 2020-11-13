-- Empresa : Supermercado São Roque Ltda. TI
-- Data :30/08/2017
-- Descrição : Verifica a validade do pulmao com a do picking
-- Desenvolvido : Sandro Soares
-- Solicitante : Andersom Grisolle
-- Atualizado em :

SELECT les_galpao||'.'||lpad(les_rua,3,0)||'.'||lpad(les_nro,3,0)||'.'||lpad(substr(Les_apt,1,1),2,0)||'.'||substr(Les_apt,2)as End_Pulmao,
les_produto as Produto,
GIT_DESCRICAO as Descricao,
rms7to_date(les_dta_agenda) as Dta_Entrada,
(les_qtd_estq_un / git_emb_for) as Embalagem,
rms7to_date(les_validade) as Dta_Val_Pulmao,
pck.End_Picking,
pck.Dta_Val_Picking,
to_date(rms7to_date(les_validade)) - pck.dta_val_picking  as diferenca,
git_secao as secao


FROM AG3CLEST, AA3CITEM,AA1DITEM, 
AG1TPEST,(SELECT DISTINCT EES_DEPOSITO, EES_COD_ENTIDADE,
                                         EES_GALPAO, EES_RUA,
                                         EES_NRO, EES_APT, EES_TIPO_ENDERECO_1,
                                         EES_ESTRUTURA, EES_PROD_RESE
                                          From AG3CEEST
                                           WHERE EES_DEPOSITO   = 1007
                                           AND EES_COD_ENTIDADE = 1007
                                           AND    EES_GALPAO         > 0
                                           AND    ees_tipo_endereco_1 <> 7),
        (SELECT ees_prod_rese,
    les_galpao||'.'||lpad(les_rua,3,0)||'.'||lpad(les_nro,3,0)||'.'||lpad(substr(Les_apt,1,1),2,0)||'.'||substr(Les_apt,2)as End_Picking,
    rms7to_date(les_validade) as Dta_Val_Picking
   
From AG3CEEST,AG3CLEST 
  WHERE ees_prod_rese = les_produto
     and EES_DEPOSITO   = 1007
     AND EES_COD_ENTIDADE = 1007
     AND EES_GALPAO         > 0
     and ees_rua = les_rua 
     and ees_nro = les_nro
     and ees_apt = les_apt
     AND ees_tipo_endereco_1 = 1
     and nvl(les_validade,0) > 0 )pck
     
WHERE LES_DEPOSITO_1 = 1007
AND LES_COD_ENTIDADE_1 = 1007
AND EES_TIPO_ENDERECO_1 = 2
AND LES_GALPAO <> 8
AND LES_QTD_ESTQ_UN <> 0 
AND GIT_COD_ITEM = TRUNC(LES_PRODUTO / 10)
AND GIT_DIGITO = SUBSTR( TO_CHAR(LES_PRODUTO,'fm00000000'),8,1)
AND DET_COD_ITEM (+) = GIT_COD_ITEM 
AND NVL(DET_CONTROLE_LOTE_SERIE,'0') = '4' 
AND EES_DEPOSITO      (+)= LES_DEPOSITO
AND EES_COD_ENTIDADE  (+)= LES_COD_ENTIDADE
AND EES_GALPAO        (+)= LES_GALPAO
AND EES_RUA           (+)= LES_RUA
AND EES_NRO           (+)= LES_NRO
AND EES_APT           (+)= LES_APT
and est_codigo        (+) = ees_estrutura
and GIT_COD_ITEM = trunc(pck.ees_prod_rese/10)
and to_date(rms7to_date(les_validade)) - pck.dta_val_picking < 0
order by 9 asc

 
--and les_produto = 2088983
