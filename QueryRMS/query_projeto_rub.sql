--- consula das classes de produtos.
select 'clas'||clm.ncc_secao as clas
       ,clm.ncc_secao 
       ,clm.ncc_grupo
       ,clm.ncc_subgrupo
       ,clm.ncc_categoria 
       ,clm.ncc_descricao as Descricao
      from aa3cnvcc  clm
      where ncc_secao = 100
      and clm.ncc_grupo = 0
      and clm.ncc_subgrupo = 0
      and clm.ncc_categoria = 0
      
union all     
select  'clas'||clm.ncc_secao||'.'||clm.ncc_grupo as clas
       ,clm.ncc_secao 
       ,clm.ncc_grupo
       ,clm.ncc_subgrupo
       ,clm.ncc_categoria 
       ,clm.ncc_descricao as Descricao
      from aa3cnvcc  clm
     where clm.ncc_secao = 100
     and clm.ncc_grupo = 1
     and clm.ncc_subgrupo = 0
     and clm.ncc_categoria = 0 

union all
select 'clas'||clm.ncc_secao||'.'||clm.ncc_grupo||'.'||clm.ncc_subgrupo as clas
       ,clm.ncc_secao 
       ,clm.ncc_grupo
       ,clm.ncc_subgrupo
       ,clm.ncc_categoria 
       ,clm.ncc_descricao as Descricao
      from aa3cnvcc  clm
     where clm.ncc_secao = 100
     and clm.ncc_grupo = 1
     and clm.ncc_subgrupo = 1 
     and clm.ncc_categoria = 0

union all
select 'clas'||clm.ncc_secao||'.'||clm.ncc_grupo||'.'||clm.ncc_subgrupo||'.'||clm.ncc_categoria as clas
       ,clm.ncc_secao 
       ,clm.ncc_grupo
       ,clm.ncc_subgrupo
       ,clm.ncc_categoria 
       ,clm.ncc_descricao as Descricao
      from aa3cnvcc  clm
     where clm.ncc_secao = 100
     and clm.ncc_grupo = 1
     and clm.ncc_subgrupo = 1
     and clm.ncc_categoria = 1
--=======================================================================================================
-- Cadeia de Produtos ( Produto Pai )
select 'Cdia' as Cdia
       ,aa.git_cod_item||aa.git_digito as cod_cadeia
       --,aa.git_codigo_pai as cod_cadeia
       ,aa.git_descricao as descricao
    from aa3citem aa , 
     (
       select distinct fam_pai from aa1fitem
      ) pai 
     where aa.git_dat_sai_lin = 0
       --and aa.git_codigo_pai = 0 
       and aa.git_envia_pdv = 'S'
       and aa.git_cod_item  = pai.fam_pai   
       and aa.git_secao not in  (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
--========================================================================================================
-- Produtos
--Consulta com base a loja 01 ( Matriz)

select 'Prod' as Prod
       ,aa.git_descricao as Descricao
       ,to_number(aa.git_cod_item||aa.git_digito) as codigo_prod
       ,'' as complemento
       ,aa.git_secao||'.'||aa.git_grupo||'.'||aa.git_subgrupo||'.'||aa.git_categoria as calss
       ,aa.git_codigo_pai as caddia
       ,decode (aa.git_depto,1,'ALIMENTOS',2,'HIGIENE',3,'PERECIVEL',4,'BAZAR',5,'ADMINISTRATIVO') as setor
       ,decode (aa.git_envia_balanca,'S',0,'N', 1)as peso_vari
       ,to_number('1')  as gerenciado
       ,cust.prcus as Custo
       ,to_number('000') as Cod_Preco
                  
   from aa3citem aa,
   (
     select  get_cod_produto as cod
             ,get_cus_ult_ent as prcus
              from aa2cestq est 
              where get_cod_local = 19
    )cust
     where aa.git_dat_sai_lin = 0
      and aa.git_envia_pdv = 'S' 
      and aa.git_envia_pdv = 'S' 
      and aa.git_cod_item||aa.git_digito = cust.cod
      and aa.git_depto not in (6,200)
      and aa.git_secao not in  (1,30,500,502,503,504,505,506)

--============================================================================================================
--Embalagem (venda)
-- Consulta com base a loja 01 ( Matriz)
select 'Emb' as Emb
       
       ,aa.git_emb_venda as Quantidade
       ,'1' as Ativo
       ,esto.prven as prc_unit
       ,sum(aa.git_emb_venda*esto.prven) as prc_emb
       ,aa.git_tpo_emb_venda as Descricao
       --,to_number(aa.git_cod_item||aa.git_digito) as codigo_prod
       --,aa.git_descricao as Descricao                  
   from aa3citem aa,
      (
          select get_cod_produto as cod
                ,get_preco_venda as prven
              from aa2cestq est 
              where get_cod_local = 19
               -- and get_cod_produto = 103969
       )esto
    where aa.git_dat_sai_lin = 0
       and aa.git_cod_item||aa.git_digito = esto.cod
       and aa.git_envia_pdv = 'S' 
       and aa.git_secao = 100
      --and aa.git_secao not in  (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
      --and aa.git_grupo = 1
      --and aa.git_subgrupo = 1
      --and aa.git_categoria = 1
     group by aa.git_emb_venda,aa.git_tpo_emb_venda,aa.git_cod_item,aa.git_digito,esto.prven,aa.git_descricao,git_emb_venda
--===========================================================================================================
--Código EAN
 select 'Codp' as Codp
        ,ean.ean_cod_ean
        --,ean.ean_cod_pro_alt
        --,ean.ean_flag_princ
   from aa3ccean ean, aa3citem aa
  where ean.ean_cod_pro_alt = aa.git_cod_item || aa.git_digito
    and ean_flag_princ  in 'P'
    and aa.git_dat_sai_lin = 0
    and aa.git_envia_pdv = 'S'
    and aa.git_secao not in  (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
    order by  ean.ean_cod_ean desc


--===========================================================================================================
--Estoque
-- Consulta com base a loja 01 ( Matriz)
select 'ESTQ' as Estq
       ,est.get_cod_produto as Produto
       ,est.get_estoque as quantidade
    from aa2cestq est, aa3citem aa 
    where get_cod_local = 19
    and est.get_cod_produto = aa.git_cod_item||aa.git_digito
    and aa.git_secao not in  (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
      --and get_cod_produto = 103969

--===============================================================================================================
--Agrupando Produto/embalagem e cadeia

select 'Prod' as Prod
       ,aa.git_descricao as Descricao
       ,to_number(aa.git_cod_item||aa.git_digito) as codigo_prod
       ,'' as complemento
       ,aa.git_secao||'.'||aa.git_grupo||'.'||aa.git_subgrupo||'.'||aa.git_categoria as calss
       ,aa.git_codigo_pai as caddia
       ,decode (aa.git_depto,1,'ALIMENTOS',2,'HIGIENE',3,'PERECIVEL',4,'BAZAR',5,'ADMINISTRATIVO') as setor
       ,decode (aa.git_envia_balanca,'S',0,'N', 1)as peso_vari
       ,to_number('1')  as gerenciado
       ,cust.prcus as Custo
       ,to_number('000') as Cod_Preco
       ,aa.git_emb_venda as Quantidade
       ,'1' as Ativo
       ,cust.prven as prc_unit
       ,sum(aa.git_emb_venda*cust.prven) as prc_emb
       ,aa.git_tpo_emb_venda as embalagem
                  
   from aa3citem aa,
   (
     select  get_cod_produto as cod
             ,get_cus_ult_ent as prcus
             ,get_preco_venda as prven
              from aa2cestq est 
              where get_cod_local = 19
    )cust
     where aa.git_cod_item > 0
      and aa.git_dat_sai_lin = 0
      and aa.git_envia_pdv = 'S' 
      and aa.git_envia_pdv = 'S' 
      and aa.git_cod_item||aa.git_digito = cust.cod
      and aa.git_depto not in (6,200)
      and aa.git_secao not in  (1,30,500,502,503,504,505,506)
      group by aa.git_descricao,aa.git_cod_item,aa.git_digito,aa.git_secao,aa.git_grupo,aa.git_subgrupo,aa.git_categoria,
               aa.git_codigo_pai,aa.git_depto,aa.git_envia_balanca,aa.git_emb_venda,cust.prcus,cust.prven,aa.git_tpo_emb_venda