-- Supermercado São Roque Ltda.
-- Data : 15/08/11 
-- Desenvolvido :Sandro Soares
-- Descrição : Analise de produtos cadastrados por loja.
-- Solicitante : Zezinha
-- Manutenção : 15/08/11

--Total cadastrado na empresa em linha ou fora de linha
select count(aa.git_secao) from aa3citem aa
   where aa.git_secao NOT IN (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
    AND aa.git_depto NOT IN (6,200);

--------------------------------------------------------------------------------------------------------------------
--Produto que já geraram estoque um dia na loja.
select aa.git_secao as secao 
      ,merc.nome as Descricao
      ,count(est.get_cod_produto) as Cad_LJ86

from 
    ( select 
      	ncc_secao as Secao, 
        ncc_descricao as Nome
      from 
      	aa3cnvcc 
        where ncc_grupo   = 0
        and ncc_subgrupo  = 0
        and ncc_categoria = 0
        order by secao )merc ,

aa2cestq est inner join aa3citem aa
on est.get_cod_produto = aa.git_cod_item||dac(aa.git_cod_item)
where est.get_cod_local = 51
 and aa.git_secao NOT IN (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
 and aa.git_depto NOT IN (6,200)
 and aa.git_envia_pdv  = 'S'
 and aa.git_secao = merc.secao
 and aa.git_dat_sai_lin = 0 
 and est.get_estoque > 0
 group by aa.git_secao,merc.nome 
 order by secao;
 --------------------------------------------------------------------------------------------------------------------
-- Quantidade cadastrada por linha de produto, quantide de produto receita e produto com
-- bloqueio por loja.
 Select git_secao as Secao
      ,ncc_descricao as descricao
      ,count (nvl(git_secao,0)) as Cad_linha
      ,sum(Decode (git_tipo_pro,1,0,2,0,3,1))as receita 
      ,sum(Decode (get_bloqueio,0,0,1,0,3,1,4,1)) as Bloqueio
     from
  (select git_secao
         ,git_cod_item||git_digito as cod
         ,git_linha
         ,git_tipo_pro 
      from aa3citem 
  where git_secao NOT IN (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
    and git_depto NOT IN (6,200)
    and git_envia_pdv  = 'S'
    and git_dat_sai_lin = 0
    order by git_secao,cod,git_linha)cadprod,
    
     (select get_cod_local 
         ,get_cod_produto
         ,get_bloqueio
   from aa2cestq 
    where get_cod_local = &Loja --86
     order by get_cod_produto)estq,
     
    ( select 
      	ncc_secao 
       ,ncc_descricao 
      from 
      	aa3cnvcc 
        where ncc_grupo   = 0
          and ncc_subgrupo  = 0
          and ncc_categoria = 0
          and ncc_secao not in (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
        order by ncc_secao )descsec,
      
    (select ch_pri_loja 
        ,ch_pri_linha  
          from aa2clinh  
          where ch_pri_loja  not in (1031,230,566,574,588,590,604)
          order by ch_pri_loja,ch_pri_linha)linha
    
  where cadprod.cod            = estq.get_cod_produto
       and cadprod.git_secao   = descsec.ncc_secao
       and linha.ch_pri_loja   = estq.get_cod_local
       and linha.ch_pri_linha  = cadprod.git_linha
  group by git_secao,ncc_descricao
  order by git_secao
   
