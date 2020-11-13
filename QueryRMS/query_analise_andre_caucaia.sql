-- Empresa : Supermercado São Roque Ltda.
-- Data : 23/08/2010
-- Atualizado em : 23/08/2010
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Andre Godinho - Compras
-- Descrição : Base para comparação dos produto da loja de Caucaia.

select aa.git_codigo_ean13 as EAN,
       aa.git_cod_for||dac(aa.git_cod_for) as Cod_Fornec,
       aa.git_descricao as Descricao,
      aa.git_sis_abast as Sist_Abast,
      round(sum(aa.git_cus_for / aa.git_emb_for),2) as Cto_Unit,
       aa.git_prc_ven_1 as Preco_Venda,
       aa.git_prc_ven_2 as Preco_Nivel2,
       aa.git_secao as secao,
       aa.git_grupo as grupo,
       est.saida_media,
       aa.git_cod_item||'-'||aa.git_digito as "Codigo RMS",
       aa.git_tpo_emb_transf as "Tipo Forn",
       aa.git_emb_for as "Emb.Fornecedor",
       aa.git_tpo_emb_transf as "Tipo Transf",
       aa.git_emb_transf as "Emb.Tranferencia",
       rmsto_date( aa.git_dat_sai_lin) as Saida_Linha
  from aa3citem aa left join
  (select get_cod_produto as Produto,
       get_vend_acum_ano as Saida_Media
        from aa2cestq  where get_cod_local = 140) est on aa.git_cod_item||aa.git_digito = est.produto
 where git_secao not in
       (1, 30, 210, 211, 212, 213, 214, 215, 216, 600, 601, 602, 603, 604, 605, 606, 607, 608)
   and aa.git_codigo_ean13 > 600000
  

 group by aa.git_codigo_ean13, aa.git_descricao, aa.git_prc_ven_1,aa.git_dat_sai_lin,aa.git_secao,
          aa.git_grupo, aa.git_sis_abast,aa.git_prc_ven_2,est.saida_media,aa.git_cod_for,
          aa.git_cod_item,aa.git_digito,aa.git_emb_for,aa.git_emb_transf,aa.git_tpo_emb_transf,
          aa.git_tpo_emb_transf
                 
 order by  ean