-- Empresa : Supermercado São Roque Ltda.
-- Data :08/06/2015 
-- Atualizado em : 08/06/2015
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Tony/Tersi
-- Descrição : Retorna vendas de todas as lojas por sistemática e periodo.

select  item.git_cod_item||git_digito as Cod
       ,item.git_secao as Secao
       ,item.git_descricao as Descricao
       ,item.git_emb_Transf as Emb_Trans
       ,item.git_tpo_emb_transf as Tipo
       ,vda.qtd_vda as Quant_Vda
       ,dvol.qtd_dvol_vda as Quant_Devol
       ,item.git_sis_abast as Sistematica
       

 from 
(select cd_prod,sum(qtd_vda) as qtd_vda
    from agg_vda_prod_mes 
        where id_mes between 201503 and 201505
         group by cd_prod)vda,

(select cd_prod,sum(qtd_dvol_vda)as qtd_dvol_vda  
    from  agg_mvto_prod_mes 
       where id_mes between 201503 and 201505
       group by cd_prod)dvol,

(select git_cod_item,git_digito,git_secao, git_descricao,git_emb_transf ,git_tpo_emb_transf,git_sis_abast 
  from aa3citem 
   where git_dat_sai_lin = 0 
    and git_sis_abast in(10,11) 
    and git_secao not in  (1,7,30,210,211,212,213,214,215,216,600,601,602,603,604,605,606,607,608)
    ) item
     where vda.cd_prod (+) = dvol.cd_prod
          and dvol.cd_prod = item.git_cod_item
          
    order by 2,3
