-- Empresa : Supermercado São Roque Ltda.
-- Data : 18/03/2011
-- Atualizado em : 18/03/2011
-- Desenvolvedor : Sandro Soares.
-- Descrição : consulta da classificação mercadologica.

select * from 
(select ncc_secao as secao,
        ncc_descricao as Descricao
      from aa3cnvcc a 
     where ncc_secao not in  (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
      and ncc_grupo = 0 
      order by ncc_secao )secao,
        
(select
       ncc_secao as secao, 
       ncc_grupo as grupo,
       ncc_descricao as Descricao
     from aa3cnvcc b 
     where ncc_secao not in  (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
      --and a.ncc_secao = 100
      and ncc_subgrupo = 0
       order by ncc_secao)grupo
       
  Where secao.secao = grupo.secao 
--------------------------------------------------------------------------------------------------------------  
  select a.ncc_secao,a.ncc_grupo as grupo,
       a.ncc_descricao as Descricao
   from aa3cnvcc a
     where a.ncc_secao not in  (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
      --and a.ncc_secao = 100
      and a.ncc_subgrupo = 0
       order by ncc_secao