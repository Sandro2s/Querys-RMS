-- Empresa : Supermercado São Roque Ltda. TI
-- Data :17/04/2009
-- Descrição : Apuração com base no inventário e por range de novas figuras fiscais para ST.
-- Desenvolvido : Sandro Soares

--Extração com base nos itens.
select to_number(aa.git_cod_item || aa.git_digito) as Codigo,
       rat.rat_estq_loja as Estoque,
       rat.rat_valor as Custo,
      (nvl(rat.rat_estq_loja, 0) * nvl(rat.rat_valor, 0)) as Valor_Total,
       fis.tfis_aliq_icm as Aliquota,
       round(fis.tfis_aliq_str, 2) as IVA_ST,
        to_number(0,00)  as Vl_Pauta, 
       round(trunc(((nvl(rat.rat_valor, 0) * nvl(fis.tfis_aliq_icm, 0)) / 100) +
                   ((((nvl(rat.rat_valor, 0) * nvl(fis.tfis_aliq_str, 0)) / 100) *
                   nvl(fis.tfis_aliq_icm, 0)) / 100),
                   4) * nvl(rat.rat_estq_loja, 0),
             2) as Devido,
       0 as cod_tip_mer,
       aa.git_descricao as Descricao,
       'UN' as UN
--     aa.git_nat_fiscal as Figura
  from aa3citem aa, ag1nrate rat, aa2tfisc fis
 where aa.git_cod_item = rat.rat_cod_produto
   and rat.rat_num_invent = 69924
   and rat.rat_cod_produto in
   
   ( 10446, 10449, 10451, 10453, 10455, 10602, 10653, 10654, 12611,
        12618, 12619, 19437, 25548, 26037, 26292, 26305, 26306, 26439, 26440,
        26674, 26854, 26855, 26954, 31044, 32959, 66554, 66851, 66973, 71529,
        71531, 71533, 71535, 73835, 73837, 73841, 76423, 76433, 79803, 79936,
        79938, 80552, 80558, 81310, 81314, 81316, 81992, 82298, 96221, 97280,
        98362, 98364, 98368, 98388, 101386, 101428, 105452, 105486, 105494,
        106195, 106252, 106294, 106302, 106304, 106877, 107425, 107573,
        107699, 107701, 107706, 107755, 107783, 107785, 107787, 107961,
        107979, 108019, 108332, 108340, 108342, 108344, 108346, 108348,
        108350, 108352, 108367, 108395, 108542, 108544, 109057, 109872,
        109874, 109876, 109878, 110879, 111559, 112110, 112125, 112127,
        112129, 112131, 112144, 112939, 112941, 113795, 114965, 115774,
        115790, 115808, 115832, 127544, 129890, 129892, 131375, 
        135127, 135131, 135133, 137155, 137157, 138376, 138941, 138990,
        139261, 139295, 139329, 139352, 139741, 144996, 145251, 145313,
        145315, 156414, 170654, 178996, 179002, 192534, 216150, 232298,
        232306, 235275, 241265, 241273, 241299, 241307, 241315, 245118,
        255315, 255331, 258921, 258939, 258947, 294850, 294868, 294900,
        294942, 301465, 308999, 318659, 318667, 318675, 322644, 340091,
        345561, 347856, 347872, 353987, 360420, 360438, 360453, 363713,
        363739, 371088, 372631, 374876, 382192, 382200, 382218, 382226,
        385021) 
   --and aa.git_nat_fiscal >= 275
   --and aa.git_nat_fiscal not in
   --    (181, 189, 193, 199, 200, 201, 203, 213, 227, 239, 240, 252, 256, 257, 259, 264, 265, 269, 271, 272)
   and aa.git_nat_fiscal = fis.tfis_figura
   and fis.tfis_origem = 'SP'
   and fis.tfis_destino = 'SP'
   and fis.tfis_aliq_icm > 0
   and fis.tfis_aliq_str <> 1
  -- and fis.tfis_operacao = 3
  and fis.tfis_codigo in (212,272,112,172)
 group by aa.git_cod_item || aa.git_digito,
          rat.rat_estq_loja,
          rat.rat_valor,
          fis.tfis_aliq_icm,
          fis.tfis_aliq_str,
          aa.git_descricao,
          aa.git_nat_fiscal
 Order by codigo

-- Extração com base na figura fiscal.

/*select to_number(aa.git_cod_item || aa.git_digito) as Codigo,
       rat.rat_estq_loja as Estoque,
       rat.rat_valor as Custo,
       (nvl(rat.rat_estq_loja, 0) * nvl(rat.rat_valor, 0)) as Valor_Total,
       fis.tfis_aliq_icm as Aliquota,
       round(fis.tfis_aliq_str, 2) as IVA_ST,
      to_number('0,00','fm9,99') as Vl_Pauta,
       round(trunc(((nvl(rat.rat_valor, 0) * nvl(fis.tfis_aliq_icm, 0)) / 100) +
                   ((((nvl(rat.rat_valor, 0) * nvl(fis.tfis_aliq_str, 0)) / 100) *
                   nvl(fis.tfis_aliq_icm, 0)) / 100),
                   4) * nvl(rat.rat_estq_loja, 0),
             2) as Devido,
       0 as cod_tip_mer,
       aa.git_descricao as Descricao,
       'UN' as UN
--     aa.git_nat_fiscal as Figura
  from aa3citem aa, ag1nrate rat, aa2tfisc fis
 where aa.git_cod_item = rat.rat_cod_produto
      --   and rat.rat_cod_produto || rat.rat_dig_produto = 833
   and rat.rat_num_invent = 64700
   and aa.git_nat_fiscal >= 275
   and aa.git_nat_fiscal not in
       (181, 189, 193, 199, 200, 201, 203, 213, 227, 239, 240, 252, 256, 257, 259, 264, 265, 269, 271, 272)
   and aa.git_nat_fiscal = fis.tfis_figura
   and fis.tfis_origem = 'SP'
   and fis.tfis_destino = 'SP'
   and fis.tfis_aliq_icm <> 0
   and fis.tfis_aliq_str > 1
   and fis.tfis_operacao = 3
 group by aa.git_cod_item || aa.git_digito,
          rat.rat_estq_loja,
          rat.rat_valor,
          fis.tfis_aliq_icm,
          fis.tfis_aliq_str,
          aa.git_descricao,
          aa.git_nat_fiscal
 Order by codigo
*/
/*select aa.git_cod_item || aa.git_digito as Codigo,
       aa.git_descricao as Descriao,
       aa.git_secao as Secao,
       aa.git_grupo as Grupo,
       aa.git_subgrupo as SubGrupo,
       aa.git_nat_fiscal as Figura,
       it.det_class_fis as Classif_Fiscal,
                      0 as Cod_Tipo_Mercadoria,
              aa.git_dat_sai_lin as Fora_de_linha
  from aa3citem aa, aa1ditem it
 where aa.git_cod_item = it.det_cod_item
   and aa.git_nat_fiscal >= 180
  -- and aa.git_dat_sai_lin <> 0*/

/*Select count(*)
   from ag1nrate rat, aa3citem aa
  where rat.rat_num_invent = 61784
    and rat.rat_cod_produto = aa.git_cod_item
    and aa.git_nat_fiscal > = 180*/

/*Select fis.tfis_figura,fis.tfis_aliq_icm, fis.tfis_aliq_str
   from aa2tfisc fis
  where fis.tfis_origem = 'SP'
    and fis.tfis_destino = 'SP'
    and fis.tfis_figura >= 180
    and fis.tfis_aliq_icm <> 0
    group by fis.tfis_figura,fis.tfis_aliq_icm, fis.tfis_aliq_str*/