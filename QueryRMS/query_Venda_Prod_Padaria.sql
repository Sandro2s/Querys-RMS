-- Empresa : Supermercado São Roque Ltda.
-- Data :26/05/2009 
-- Atualizado em : 24/12/2010
-- Desenvolvedor : Sandro Soares.
-- Descrição : Traz as venda dos produto da padaria da loja efetuada em um periodo.

--Venda das lojas.
select to_number(ag.eschljc_codigo || ag.eschljc_digito, '999') as Loja,
       to_number(ag.esitc_codigo || ag.esitc_digito, '9999999') as Codigo,
       aa.git_descricao as Descricao,
       sum(ag.entsaic_quanti_un) as Quant,
       sum(ag.entsaic_prc_emb) as Vlr_Venda
  from ag1iensa ag, aa3citem aa
 where ag.eschc_data between &Dta_Ini and &Dta_Fin --1100501 and 1100531
   and ag.eschc_agenda = 53
   and ag.esitc_codigo = aa.git_cod_item(+)
   and ag.esitc_codigo1 || ag.esitc_digito1 in
(45152,71790,82198,17515,58017,57851,45233,17566,
17523,37699,37702,37877,78492,582,590,477,507,17850,	 	 	 
45497,17493,17507,34339,37982,17647,50253,50334,540,
17930,17698,2453,41548,41491,41521,41505,41530,41513,
668842,1015,18708,17655,1880837,19836,19844,14095,515,
168106,168114,15709,15725,41076,24716,3310,3328,3336,
3344,3352,3360,3379,3395,3409,3417,41068,41025,41050,
41041,41033,3450,41211,41181,41190,41203,41220) 
   and ag.eschljc_codigo in
       (1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 14, 15, 18, 19, 20, 21)
 Group by ag.eschljc_codigo || ag.eschljc_digito,
          ag.esitc_codigo || ag.esitc_digito,
          aa.git_descricao
 order by loja, codigo;

-- Soma total da lojas.
select /*to_number(ag.eschljc_codigo || ag.eschljc_digito,'999') as Loja,*/
 to_number(ag.esitc_codigo || ag.esitc_digito, '9999999') as Codigo,
 aa.git_descricao as Descricao,
 sum(ag.entsaic_quanti_un) as Quant,
 sum(ag.entsaic_prc_emb) as Vlr_Venda
  from ag1iensa ag, aa3citem aa
 where ag.eschc_data between &Dta_Ini and &Dta_Fin --1100501 and 1100531
   and ag.eschc_agenda = 53
   and ag.esitc_codigo = aa.git_cod_item(+)
   and ag.esitc_codigo1 || ag.esitc_digito1 in
(45152,71790,82198,17515,58017,57851,45233,17566,
17523,37699,37702,37877,78492,582,590,477,507,17850,	 	 	 
45497,17493,17507,34339,37982,17647,50253,50334,540,
17930,17698,2453,41548,41491,41521,41505,41530,41513,
668842,1015,18708,17655,1880837,19836,19844,14095,515,
168106,168114,15709,15725,41076,24716,3310,3328,3336,
3344,3352,3360,3379,3395,3409,3417,41068,41025,41050,
41041,41033,3450,41211,41181,41190,41203,41220) 
--and ag.eschljc_codigo = 15
 Group by /*ag.eschljc_codigo || ag.eschljc_digito,*/
          ag.esitc_codigo || ag.esitc_digito,
          aa.git_descricao
 order by codigo;

--=======================================================================================================================

--Vendas e Transferencia saida da padaria para lojas.
select Lja as Loja,
       Cod as Codigo,
       Descr as Descricao,
       sum(Quant) as Quantidade,
       sum(Vlr_Vend) as Vlr_Venda
  from (select to_number(ag.esclc_codigo || ag.esclc_digito, '9999') as Lja,
               to_number(ag.esitc_codigo || ag.esitc_digito, '9999999') as Cod,
               aa.git_descricao as Descr,
               ag.entsaic_quanti_un as Quant,
               (ag.entsaic_prc_emb * ag.entsaic_quanti_un) as Vlr_Vend,
               rms7to_date(ag.eschc_data) as data,
               ag.eschc_nro_nota as NF
          from ag1iensa ag, aa3citem aa
         where ag.eschc_data between &Dta_Ini and &Dta_Fin --1100501 and 1100531
           and ag.eschc_agenda in (67, 68)
           and ag.esitc_codigo = aa.git_cod_item(+)
           and ag.esitc_codigo1 || ag.esitc_digito1 in
(45152,71790,82198,17515,58017,57851,45233,17566,
17523,37699,37702,37877,78492,582,590,477,507,17850,	 	 	 
45497,17493,17507,34339,37982,17647,50253,50334,540,
17930,17698,2453,41548,41491,41521,41505,41530,41513,
668842,1015,18708,17655,1880837,19836,19844,14095,515,
168106,168114,15709,15725,41076,24716,3310,3328,3336,
3344,3352,3360,3379,3395,3409,3417,41068,41025,41050,
41041,41033,3450,41211,41181,41190,41203,41220) 
           and ag.esclc_codigo in
               (1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 14, 15, 18, 19,20,21)
         Group by ag.esclc_codigo || ag.esclc_digito,
                  ag.esitc_codigo || ag.esitc_digito,
                  aa.git_descricao,
                  ag.entsaic_quanti_un,
                  ag.entsaic_prc_emb,
                  ag.eschc_data,
                  ag.eschc_nro_nota)
 Group by Lja, Cod, Descr
 order by Lja, Cod;
-- Soma lojas saida e transferencia Padaria.          
select Cod as Codigo,
       Descr as Descricao,
       sum(Quant) as Quantidade,
       sum(Vlr_Vend) as Vlr_Venda
  from (select to_number(ag.esclc_codigo || ag.esclc_digito, '9999') as Lja,
               to_number(ag.esitc_codigo || ag.esitc_digito, '9999999') as Cod,
               aa.git_descricao as Descr,
               ag.entsaic_quanti_un as Quant,
               (ag.entsaic_prc_emb * ag.entsaic_quanti_un) as Vlr_Vend,
               rms7to_date(ag.eschc_data) as data,
               ag.eschc_nro_nota as NF
          from ag1iensa ag, aa3citem aa
         where ag.eschc_data between &Dta_Ini and &Dta_Fin --1100501 and 1100531
           and ag.eschc_agenda in (67, 68)
           and ag.esitc_codigo = aa.git_cod_item(+)
           and ag.esitc_codigo1 || ag.esitc_digito1 in
(45152,71790,82198,17515,58017,57851,45233,17566,
17523,37699,37702,37877,78492,582,590,477,507,17850,	 	 	 
45497,17493,17507,34339,37982,17647,50253,50334,540,
17930,17698,2453,41548,41491,41521,41505,41530,41513,
668842,1015,18708,17655,1880837,19836,19844,14095,515,
168106,168114,15709,15725,41076,24716,3310,3328,3336,
3344,3352,3360,3379,3395,3409,3417,41068,41025,41050,
41041,41033,3450,41211,41181,41190,41203,41220) 
        --and ag.esclc_codigo in (1,2,3,4,5,7,8,9,10,11,12,14,15,18,19,20,21)
         Group by ag.esclc_codigo || ag.esclc_digito,
                  ag.esitc_codigo || ag.esitc_digito,
                  aa.git_descricao,
                  ag.entsaic_quanti_un,
                  ag.entsaic_prc_emb,
                  ag.eschc_data,
                  ag.eschc_nro_nota)
 Group by Cod, Descr
 order by codigo;