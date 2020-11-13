-- Supermercado São Roque Ltda.
-- Data : 25/01/2016
-- Solicitante : Regina Neto
-- Desenvolvedor : Sandro Soares
-- Descrição : Consultar e gerar aquivo texto no layout do Dagno (importar para excell)
-- Manutenção : 25/01/16
Select * from
(
select  git_cod_item||git_digito as Codigo
       ,git_descricao as descricao
       ,git_secao as Secao
       ,det_class_fis as Classif_Fiscal
       ,rmsto_date( git_dat_sai_lin)as Dta_Fora_linha 
       ,git_nat_fiscal as figura
  from aa1ditem
     inner join aa3citem on git_cod_item = det_cod_item
     where git_cod_item > 0
     and git_secao in (100,101,102,103,104,105,106,107,108,109,110,111,112,200,201,300,301,302,303,304,305,306,400,401,402)
        order by secao,classif_fiscal,descricao )
         
           where dta_fora_linha >= to_date('01/01/2015','dd/mm/yyyy')  or dta_fora_linha is null 
           order by 3,2
