-- Supermercado São Roque Ltda.
-- Data : 12/02/10
-- Desenvolvedor :Fernando Germano.
-- Descrição : Compara MOVCAIXA.dbf (GZ) com aa3citem comparando os codigos EAN.
-- Manutenção : 12/02/10

select DISTINCT ITEMRMS.GIT_COD_ITEM||'-'||ITEMRMS.GIT_DIGITO CODIGO, itemrms.git_descricao,itemrms.git_codigo_ean13 as Cod_Ean, TEMP.codean
  from aa3citem itemrms ,
                          (select DISTINCT cast(trim(codbarra) as VARCHAR2(13)) as codean from movcaixa WHERE CODBARRA <> '                    ')  TEMP
                           WHERE CAST(TEMP.CODEAN AS VARCHAR2(13)) = CAST(ITEMRMS.GIT_CODIGO_EAN13  AS VARCHAR2(13))                                   
