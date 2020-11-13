-- Empresa : Supermercado São Roque Ltda.
-- Data :26/03/2018
-- Atualizado em : 
-- Desenvolvedor : Sandro Soares
-- Solicitante : Zezinho
-- Descrição : Produtos que São Roque compra de outro fornecedor e tem no galli

SELECT GIT_CODIGO_EAN13 AS EAN13,
       TIP_RAZAO_SOCIAL as Razao_Social,
       GIT_DESCRICAO AS DESCRICAO,
       GIT_CUS_ULT_ENT_BRU AS CST_FOR_SMSR,
       GL_CST_UN_NFE as CST_FOR_GALLI,
       GL_CST_UN_CAD 
       
 FROM AA3CITEM, GLPRCOMP, aa2ctipo
 WHERE  GIT_DAT_SAI_LIN = 0
 AND GIT_SECAO IN (100,101,102,103,104,105,106,107,108,109,110,111,112,200,201,300,301,302,303,304,305,306,400,401,402,403) 
 AND GL_EAN13 = GIT_CODIGO_EAN13
 AND TIP_CODIGO = git_cod_for 
 AND GIT_COD_FOR != 1538


