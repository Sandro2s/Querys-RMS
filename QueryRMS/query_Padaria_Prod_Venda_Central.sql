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
 where ag.eschc_data between 1||to_char(to_date('&Dta_Inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd') --&Dta_Ini and &Dta_Fin --1100501 and 1100531
   and ag.eschc_agenda = 53
   and ag.esitc_codigo = aa.git_cod_item(+)
   and ag.esitc_codigo1 || ag.esitc_digito1 in
      (515,540,582,590,1015,2372,3310,3328,3328,3336,3344,3352,3360,3379,3395,
        3409,3417,3450,4421,14095,15903,17493,17507,17507,17515,17523,17523,51055,
        17582,17582,17647,17655,17698,17850,17850,17930,18708,18708,19836,19844,
        23485,24716,34339,37982,38644,41025,41025,41033,41041,41050,41068,44016,
        44270,44288,44296,44490,45071,45152,45233,45497,46078,47660,47678,47686,
        47694,47708,47716,48658,48712,50253,50334,50334,50580,51055,51055,57932,
        58017,71790,78492,82198,82198,168106,168106,168114,668842,980811,1880837,
        2030896,2031205)
   and ag.eschljc_codigo in
       (1, 2, 3, 4, 5, 7, 8, 11, 12, 15, 18, 19, 20, 21, 22, 25, 26, 29, 30,32)
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
 where ag.eschc_data between 1||to_char(to_date('&Dta_Inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd')--&Dta_Ini and &Dta_Fin --1100501 and 1100531
   and ag.eschc_agenda = 53
   and ag.esitc_codigo = aa.git_cod_item(+)
   and ag.esitc_codigo1 || ag.esitc_digito1 in
        (515,540,582,590,1015,2372,3310,3328,3328,3336,3344,3352,3360,3379,3395,
        3409,3417,3450,4421,14095,15903,17493,17507,17507,17515,17523,17523,51055,
        17582,17582,17647,17655,17698,17850,17850,17930,18708,18708,19836,19844,
        23485,24716,34339,37982,38644,41025,41025,41033,41041,41050,41068,44016,
        44270,44288,44296,44490,45071,45152,45233,45497,46078,47660,47678,47686,
        47694,47708,47716,48658,48712,50253,50334,50334,50580,51055,51055,57932,
        58017,71790,78492,82198,82198,168106,168106,168114,668842,980811,1880837,
        2030896,2031205)
 	 

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
         where ag.eschc_data between 1||to_char(to_date('&Dta_Inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd')--&Dta_Ini and &Dta_Fin --1100501 and 1100531
           and ag.eschc_agenda in (67, 68)
           and ag.esitc_codigo = aa.git_cod_item(+)
           and ag.esitc_codigo1 || ag.esitc_digito1 in
             (515,540,582,590,1015,2372,3310,3328,3328,3336,3344,3352,3360,3379,3395,
              3409,3417,3450,4421,14095,15903,17493,17507,17507,17515,17523,17523,51055,
              17582,17582,17647,17655,17698,17850,17850,17930,18708,18708,19836,19844,
              23485,24716,34339,37982,38644,41025,41025,41033,41041,41050,41068,44016,
              44270,44288,44296,44490,45071,45152,45233,45497,46078,47660,47678,47686,
              47694,47708,47716,48658,48712,50253,50334,50334,50580,51055,51055,57932,
              58017,71790,78492,82198,82198,168106,168106,168114,668842,980811,1880837,
              2030896,2031205)

           and ag.esclc_codigo in
               (1, 2, 3, 4, 5, 7, 8, 11, 12, 15, 18, 19, 20, 21, 22, 25,26, 29, 30,32)
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
         where ag.eschc_data between 1||to_char(to_date('&Dta_Inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd')--&Dta_Ini and &Dta_Fin --1100501 and 1100531
           and ag.eschc_agenda in (67, 68)
           and ag.esitc_codigo = aa.git_cod_item(+)
           and ag.esitc_codigo1 || ag.esitc_digito1 in
               (515,540,582,590,1015,2372,3310,3328,3328,3336,3344,3352,3360,3379,3395,
                3409,3417,3450,4421,14095,15903,17493,17507,17507,17515,17523,17523,51055,
                17582,17582,17647,17655,17698,17850,17850,17930,18708,18708,19836,19844,
                23485,24716,34339,37982,38644,41025,41025,41033,41041,41050,41068,44016,
                44270,44288,44296,44490,45071,45152,45233,45497,46078,47660,47678,47686,
                47694,47708,47716,48658,48712,50253,50334,50334,50580,51055,51055,57932,
                58017,71790,78492,82198,82198,168106,168106,168114,668842,980811,1880837,
                2030896,2031205)
	 	 

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
 
 
/*(45152,71790,82198,17515,38644,47660,47678,47686,47694,47716,47708,
58017,45233,17523,44270,44288,44296,44490,78492,57932,2372,980811,							
582,590,17850,23485,46078,45497,17493,17507,34339,37982,17647,50253,
50334,540,17930,17698,668842,1015,18708,17655,1880837,19836,19844,							
44016,45071,17582,15903,4421,14095,515,168106,168114,24716,3310,3328,
3336,3344,3352,3360,3379,3395,3409,3417,41068,41025,41050,41041,41033,
3450,50580,2031205,2030896)	*/
	 	  
