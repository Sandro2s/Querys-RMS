-- Empresa : Supermercado São Roque Ltda.
-- Data : 16/06/2010
-- Atualizado em : 16/06/2010
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Andre Godinho - Compras
-- Descrição : Extrair do gerencial a venda da seção 104, grupo 7

select aa.git_cod_item||'-'||aa.git_digito as "Código RMS",
       aa.git_descricao as "Descrição",
       vda.cd_fil  as "Loja",
       vda.qtd_vda as "Qtd", 
       vda.vl_vda  as "Valor"
  from agg_vda_prod_mes vda,
  (
  select *
          from aa3citem 
         where git_secao = 104
           and git_grupo = 7
           and git_dat_sai_lin = 0 
  )aa
 where vda.id_mes = 201005
   and vda.cd_prod = aa.git_cod_item
   order by vda.cd_fil, git_descricao
