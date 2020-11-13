select aa.git_codigo_ean13 as ean,
       aa.git_cod_item || aa.git_digito as codigo,
       aa.git_descricao as descricao,
       aa.git_secao as secao,
       aa.git_grupo as grupo,
       --aa.git_dat_sai_lin,
       --aa.git_depto,
       aa.git_prc_ven_1 as Preco_venda_1,
       aa.git_prc_ven_2 as Preco_venda_2,
       aa.git_prc_ven_3 as Preco_venda_3,
       aa.git_cus_ult_ent_bru as Cust_Ult_Entrada,
       rms7to_date(aa.git_dat_sai_lin) as FL
       

  from aa3citem aa
  where aa.git_dat_sai_lin = 0
  and aa.git_depto not in (005,006,007,100)
 and aa.git_codigo_ean13 <=  3010000000000
  --and aa.git_cod_item||aa.git_digito = 1521500
  order by git_codigo_ean13 desc

  --select * from aa3ccean