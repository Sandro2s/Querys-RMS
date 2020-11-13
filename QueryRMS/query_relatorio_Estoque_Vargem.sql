select get_cod_produto
       ,git_descricao
       ,git_emb_for as embalagem
       ,get_estoque as Estoque_Unid
       ,(case
           when get_estoque = 0 then null 
             else round((get_estoque/git_emb_for),3)
         end) as Total_Embalagem
       ,rms7to_date(rms6to_rms7( git_dat_sai_lin )) Fora_linha
  from aa2cestq, aa3citem
 where get_cod_local = 43
   and get_cod_produto = git_cod_item || git_digito
   and git_secao not in(300,301,302,303,304,305,306) 
   and rms7to_date(rms6to_rms7( git_dat_sai_lin )) > to_date('01/01/2012','dd/mm/yyyy') 
   group by get_cod_produto,git_descricao,git_secao,git_dat_sai_lin,get_estoque,git_emb_for
union all
select  get_cod_produto
       ,git_descricao
       ,git_emb_for as embalagem
       ,get_estoque as Estoque_Unid
       ,(case
           when get_estoque = 0 then null 
             else round((get_estoque/git_emb_for),3)
         end) as Total_Embalagem
       ,rms7to_date(rms6to_rms7( git_dat_sai_lin )) Fora_linha
  from aa2cestq, aa3citem
 where get_cod_local = 43
   and get_cod_produto = git_cod_item || git_digito
   and git_secao not in(300,301,302,303,304,305,306) 
   and git_dat_sai_lin = 0
   group by get_cod_produto,git_descricao,git_secao,git_dat_sai_lin,get_estoque,git_emb_for  
   order by git_descricao
   
   