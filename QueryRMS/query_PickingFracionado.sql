-- Empresa : Supermercado São Roque Ltda. TI
-- Data :31/08/2017
-- Descrição : Verifica produtos fracionados no picking
-- Desenvolvido : Sandro Soares
-- Solicitante : Anderson Grisolla

SELECT
    les_galpao||'.'||lpad(les_rua,3,0)||'.'||lpad(les_nro,3,0)||'.'||lpad(substr(Les_apt,1,1),2,0)||'.'||substr(Les_apt,2)as End_Picking, 
    GIT_COD_ITEM||GIT_DIGITO as Codigo,
    GIT_DESCRICAO as descricao,
    rms7to_date(les_validade) as Dta_Validade,
    rms7to_date(les_dta_agenda) as Dta_Entrada,
    round((les_qtd_estq_un /GIT_EMB_FOR),2) as Embalagem,
    trunc(les_qtd_estq_un) as unidade
   
FROM AG3CLEST, AA3CITEM,AA1DITEM, AG1TPEST,(SELECT DISTINCT EES_DEPOSITO,      EES_COD_ENTIDADE,
                                         EES_GALPAO,        EES_RUA,
                                         EES_NRO, EES_APT , EES_TIPO_ENDERECO_1,
                                         EES_ESTRUTURA, EES_PROD_RESE
                                         From AG3CEEST
                                         WHERE EES_DEPOSITO   = 1007
                                         AND EES_COD_ENTIDADE = 1007
                                         AND    EES_GALPAO         > 0
                                         AND    ees_tipo_endereco_1 <> 7)
WHERE LES_DEPOSITO_1 = 1007
AND LES_COD_ENTIDADE_1 = 1007
AND EES_TIPO_ENDERECO_1 = 1
AND LES_GALPAO <> 8
AND LES_QTD_ESTQ_UN <> 0 
AND GIT_COD_ITEM = TRUNC(LES_PRODUTO / 10)
AND GIT_DIGITO = SUBSTR( TO_CHAR(LES_PRODUTO,'fm00000000'),8,1)
AND DET_COD_ITEM (+) = GIT_COD_ITEM 
AND EES_DEPOSITO      (+)= LES_DEPOSITO
AND EES_COD_ENTIDADE  (+)= LES_COD_ENTIDADE
AND EES_GALPAO        (+)= LES_GALPAO
AND EES_RUA           (+)= LES_RUA
AND EES_NRO           (+)= LES_NRO
AND EES_APT           (+)= LES_APT
and est_codigo        (+) = ees_estrutura
and git_emb_for = git_emb_transf
and MOD(les_qtd_estq_un ,GIT_EMB_FOR) > 0
order by 1
--and GIT_COD_ITEM = 350413
