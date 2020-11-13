-- Empresa : Supermercado São Roque Ltda.
-- Data : 28/10/2010
-- Atualizado em : 01/11/2012
-- Desenvolvedor : Sandro Soares.
-- Descrição : Gera tabela de quantidade de produtos por seção em linha.
Select get_cod_local as Loja
      ,git_secao as Secao
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
    where get_cod_local in (19,27,35,43,51,78,86,94,108,116,124,159,183,191,205,213,221,256,267,299,,1007)--= '&Codigo_Loja' --86
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
  group by git_secao,ncc_descricao,get_cod_local
  order by get_cod_local,git_secao
