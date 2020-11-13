-- Supermercado São Roque Ltda.
-- Data : 30/08/11 
-- Desenvolvido :Sandro Soares
-- Descrição : Procurar todos produto que participam de receita
-- Solicitante : Ana Cristina - Compras
-- Manutenção : 30/08/11

--- Procura produto que participem de uma ordem de produto (Insumo).
Select  cod as codigo
        ,descricao as Descricao_Cod
        ,item.git_secao as secao
        ,rece_produto  as Prod_Participa
        ,git_descricao as descricao_Insumo 

  from 
(select rece_componente,rece_produto,git_descricao 
  from aa1crece,aa3citem where rece_produto = git_cod_item||git_digito ) rec, 

(select git_cod_item||git_digito as cod, 
        git_descricao as descricao,
        git_tipo_pro as tipo,
        git_secao,
        git_depto
 from aa3citem  
   where git_dat_sai_lin = 0 )item
   
   where rec.rece_componente = item.cod
     and item.tipo = 2
     and item.git_secao NOT IN (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
     and item.git_depto NOT IN (6,200)
     order by secao,descricao_cod, descricao_insumo