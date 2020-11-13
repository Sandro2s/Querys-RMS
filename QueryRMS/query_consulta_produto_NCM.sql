    select to_number(det_cod_item||dac(det_cod_item))as cod
           ,git_descricao
           ,det_class_fis
           ,git_secao
           , case git_categoria_ant 
             when 0 then ' 00 - Normal' 
             when 1 then ' 01 - Antecipado'
             when 2 then ' 02 - Isento'
             end as Pis_Cofins
           from aa1ditem inner join aa3citem on  git_cod_item = det_cod_item
           where --det_cod_item > 0 
              det_class_fis like '1902%' or det_class_fis like'11010010' 
                             or det_class_fis like'1001%' or det_class_fis like'19012000'
                             or det_class_fis like'19059090'
         order by git_secao,git_descricao
                            