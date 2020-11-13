-- Supermercado São Roque Ltda.
-- Data : 05/01/2012
-- Solicitante : 
-- Desenvolvedor : Sandro Soares
-- Descrição : Fazer alteração de categoria de Pis/Cofins utilizando uma subquery
-- Manutenção : 05/01/2012


update aa3citem
   set git_categoria_ant = 5
 where git_cod_item||git_digito in
(
  select cod from
  ( select cod, a.git_secao from
          (
             select to_number(det_cod_item||dac(det_cod_item))as cod
             ,git_descricao
             ,det_class_fis
             ,git_secao
             ,git_dat_sai_lin
             from aa1ditem inner join aa3citem on  git_cod_item = det_cod_item
             where  det_class_fis like '201%' or det_class_fis like'202%'
                              or det_class_fis like'2061000%' or det_class_fis like'2062%'
                              or det_class_fis like'2062100%' or det_class_fis like'20629%'
                              or det_class_fis like'2102000%' or det_class_fis like'5069000%'
                              or det_class_fis like'5100010%' or det_class_fis like'1502001%'
                              
           )a where a.git_secao = 305 ))
   
                                        

