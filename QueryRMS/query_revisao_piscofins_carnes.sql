 select to_number(det_cod_item || dac(det_cod_item)) as cod,
        git_descricao as Descricao,
        det_class_fis as Classif_Fiscal,
        git_secao as Secao,
       rmsto_date( git_dat_sai_lin) as Linha,
        decode(git_categoria_ant,4,'4 - Carne Vermelha',5,'5 - Carne Branca') as Pis_Cofins
   from aa1ditem
  inner join aa3citem on git_cod_item = det_cod_item
   where git_categoria_ant in (4,5)
    --and rmsto_date( git_dat_sai_lin) > to_date('01/12/2011','dd/mm/yyyy') or git_dat_sai_lin = 0
       order by secao
                
 