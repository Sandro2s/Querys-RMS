-- Supermercado São Roque Ltda.
-- Data : 09/09/10 (Validado com  Andre Godinho)
-- Desenvolvedor:Sandro Soares
-- Descrição : Extração dos preços cadastrados para verificação de preço de venda
-- Manutenção : 29/09/11

select --aa.git_codigo_ean13 as EAN,
       aa.git_cod_item||aa.git_digito as Cod_RMS,
       aa.git_descricao as Descricao,
 --    aa.git_dat_sai_lin as fora_Linha,
       aa.git_mrg_lucro_1 as Margem_1,
       aa.git_prc_ven_1   as Nivel_1,
       aa.git_mrg_lucro_2 as Margem_2,
       aa.git_prc_ven_2   as Nivel_2,
       aa.git_mrg_lucro_3 as Margem_3,
       aa.git_prc_ven_3   as Nivel_3,
       aa.git_secao       as Secao
       
        from aa3citem aa 
         where aa.git_secao not in (001,030,210,211,212,213,214,215,216,600,601,602,603,604,605,606,607,608) 
         and aa.git_codigo_ean13 >= 40000000
         and aa.git_dat_sai_lin = 0
         --and aa.git_cod_item||aa.git_digito = 100501
         order by Secao,Descricao
        