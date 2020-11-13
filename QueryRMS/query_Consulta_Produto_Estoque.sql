-- Empresa : Supermercado São Roque Ltda.
-- Data :06/02/2018
-- Atualizado em : 
-- Desenvolvedor : Sandro Soares
-- Solicitante : Tony Godinho
-- Descrição : Consulta de produtos com movimento de estoque.
--             
select es.get_cod_local as Loja,
       it.git_secao as Secao,
       cc.ncc_descricao as Des_Secao,
       es.get_cod_produto as Cod_Produto,
       it.git_descricao as Des_Protudo,
       it.git_linha as Linha,
       it.git_sis_abast as Sist_Abaste,
       es.get_estoque as Estoque,
       es.get_qtd_pend as Pendencia_Compra,
       es.get_qtd_pend_vda as Pendencia_Venda
      
       
from aa3citem it, aa2cestq es,
   ( select
        ncc_secao
       ,ncc_descricao
      from
        aa3cnvcc
        where ncc_grupo   = 0
          and ncc_subgrupo  = 0
          and ncc_categoria = 0
          and ncc_secao not in (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
        order by ncc_secao )cc
where it.git_cod_item||it.git_digito = es.get_cod_produto
and it.git_dat_sai_lin = 0
and it.git_secao = cc.ncc_secao
and es.get_cod_local in (19,27,35,43,51,78,86,116,124,183,191,205,213,221,256,267,299,302,329,1007)
order by 1,2,3,5;

------------------------------------------------------------------------------------------------------------
select   secao,
         descricao,
      sum(c_est)as Com_Estoque,
      sum(s_est)as Sem_Estoque
 from 
(
select aa.git_secao             as Secao,
       cc.ncc_descricao         as Descricao,
      count(est.get_estoque)    as C_Est,
       0                        as S_Est
 from aa3citem aa, aa2cestq est,
 ( select
        ncc_secao
       ,ncc_descricao
      from
        aa3cnvcc
        where ncc_grupo   = 0
          and ncc_subgrupo  = 0
          and ncc_categoria = 0
          and ncc_secao not in (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
        order by ncc_secao )cc
    
where aa.git_cod_item||aa.git_digito = est.get_cod_produto
and aa.git_dat_sai_lin = 0
and est.get_estoque  > 0
and aa.git_envia_pdv  = 'S'
and aa.git_secao in (100,101,102,103,104,105,106,107,108,109,110,111,200,201)--NOT IN (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
and aa.git_depto NOT IN (6,200)
and est.get_cod_local = 1007 --in (19,27,35,43,51,78,86,94,108,116,124,159,183,191,205,213,221,256,267,299,302,329,1007)
and aa.git_sis_abast = 1
and aa.git_secao = cc.ncc_secao
group by aa.git_secao,cc.ncc_descricao

Union all 
select aa.git_secao            as Secao,
       cc.ncc_descricao        as Descricao,
       0                       as C_Est,
      count(est.get_estoque)   as S_Est
 from aa3citem aa, aa2cestq est,
 ( select
        ncc_secao
       ,ncc_descricao
      from
        aa3cnvcc
        where ncc_grupo   = 0
          and ncc_subgrupo  = 0
          and ncc_categoria = 0
          and ncc_secao not in (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
        order by ncc_secao )cc
    
where aa.git_cod_item||aa.git_digito = est.get_cod_produto
and aa.git_dat_sai_lin = 0
and est.get_estoque  = 0
and aa.git_envia_pdv  = 'S'
and aa.git_secao in (100,101,102,103,104,105,106,107,108,109,110,111,200,201) --NOT IN (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
and aa.git_depto NOT IN (6,200)
and est.get_cod_local = 1007 --in (19,27,35,43,51,78,86,94,108,116,124,159,183,191,205,213,221,256,267,299,302,329,1007)
and aa.git_sis_abast = 1
and aa.git_secao = cc.ncc_secao
group by  aa.git_secao,cc.ncc_descricao 
 )
  group by secao,descricao

