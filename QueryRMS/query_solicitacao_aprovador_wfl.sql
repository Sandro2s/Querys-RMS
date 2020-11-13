-- Supermercado São Roque Ltda.
-- Data : 13/08/10 
-- Sandro Soares
-- Descrição : Extrair do Workflow as solicitações aprovadas por aprovador.
-- Manutenção : 13/08/10
--


Select capa.slc_codigo as Numero,
       usu.nome as aprovador,
       item.ite_descricao as Item,
       forn.frn_descricao as fornecedor,
       soli.sli_valor as Valor,
       capa.slc_dataaprovacao as Dta_Aprovacao
       
 from 

   (Select slc_codigo,slc_fornecedor,slc_aprovador,slc_dataaprovacao from despesa.os_solicitacao_capa where slc_status = 'A' /*and slc_codigo = 407435*/) capa,
   (Select sli_codigo,sli_solicitacao,sli_item,sli_valor,sli_aprovador from despesa.os_solicitacao_item /*where sli_solicitacao = 407435*/)soli,
   (Select * from despesa.os_fornecedor /*where frn_codigo = 32948*/)forn,
   (Select ite_codigo,ite_descricao from despesa.os_item  /*where ite_codigo = 2056*/)item,
   (select id_codigo,nome from despesa.tb_usuario where tipo = 'P' /*and id_codigo = 582*/)usu
   
   where capa.slc_codigo = soli.sli_solicitacao
   and capa.slc_fornecedor = forn.frn_codigo
   and soli.sli_item = item.ite_codigo
   and soli.sli_aprovador = usu.id_codigo
   and capa.slc_dataaprovacao between to_date('01/05/2012','dd/mm/yyyy') and to_date('31/05/2012','dd/mm/yyyy')   
   --   and capa.slc_dataaprovacao >= to_date('05/01/2009','dd/mm/yyyy')
  order by aprovador,Dta_Aprovacao
   
   
   /*Select slc_codigo,slc_fornecedor,slc_aprovador,slc_dataaprovacao from despesa.os_solicitacao_capa where slc_status = 'A' and slc_codigo = 407435;
   Select sli_codigo,sli_solicitacao,sli_item,sli_valor,sli_aprovador from despesa.os_solicitacao_item where sli_solicitacao = 407435;
   Select * from despesa.os_fornecedor where frn_codigo = 32948;
   Select ite_codigo,ite_descricao from despesa.os_item  where ite_codigo = 2056;
   select id_codigo,nome from despesa.tb_usuario where tipo = 'P' and id_codigo = 582;*/