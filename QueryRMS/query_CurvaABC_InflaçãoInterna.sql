-- Empresa : Supermercado S�o Roque Ltda.
-- Data :01/04/2014 
-- Atualizado em : 14/06/2018
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Zezinho
-- Descri��o : Traz 194 produtos pertencente a curva ABC para calculo da infla��o interna.
--Limpa as duas tabelas temporarias
truncate table tmp_abc; 

--Inserte para usar data da digita��o do pedido
INSERT INTO tmp_abc 
 (Select to_number(vda.id_mes) as mes,
         to_number(git_cod_item) as cod,
         to_number(git_digito) as dig,
         to_number(git_secao) as sec,
       decode (git_secao,100,'Molhos e Condimentos',102,'Bomboniere',103,'Oleos e Azeites',104,'Bebidas',105,'Matinais',108,'Biscoitos',
                109,'Cereais e Empacotados',110,'Massas',200,'Perfumaria',201,'Limpreza',300,'Hortifruti-Granjeiro',301,'Congelados',
                302,'Frios e Laticinios',305,'A�ougue',306,'Padaria',400,'Utilidades' ) as secao,  
               git_grupo as grupo ,git_descricao as descricao,sum(nvl(q_vda-q_dvol,0))qtd,sum(nvl(v_vda-v_dvol,0))valor

   from (select id_mes,cd_prod,sum(nvl(qtd_vda,0))q_vda,sum(nvl(vl_vda,0))v_vda from agg_vda_prod_mes a group by id_mes,cd_prod )vda,
        (select id_mes,cd_prod,sum(nvl(qtd_dvol_vda,0))q_dvol,sum(nvl(vl_dvol_vda,0))v_dvol from agg_mvto_prod_mes group by id_mes,cd_prod )mvt,
        (select git_cod_item,git_digito,git_descricao,git_secao,git_grupo 
              from aa3citem 
                where git_secao NOT IN (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506))item
              
        
        where vda.id_mes = mvt.id_mes
          and vda.cd_prod = mvt.cd_prod
          and vda.cd_prod = item.git_cod_item 
          and vda.id_mes between '&Inicial' and '&Final'   ---201601 and 201601
        group by vda.id_mes,git_cod_item,git_digito,git_secao, git_grupo,git_descricao); 
--- consulta
select * from tmp_abc
 where cod in (16,25,54,1000,1009,1028,1040,1043,1045,1047,1055,1057,1059,1063,1067,1068,1071,1077,1081,
          1085,1089,1092,1097,1104,1161,1162,1163,1164,1165,1167,1170,1220,1231,1232,1233,1239,1240,
          1242,1243,1244,1252,1254,1355,1417,1423,1511,1519,1552,1616,1617,1617,1620,1637,1643,1643,
          1644,1645,1654,1655,1657,1657,1658,1659,1662,1667,1696,1708,1708,1713,1720,1736,1765,1785,
          1866,1870,1913,1925,1990,2019,2030,2196,2262,2337,2402,2471,2550,2758,3526,3603,3689,3703,
          3783,3784,3785,3856,3962,3969,4111,4458,4459,4460,4469,4470,4471,4487,4491,4501,4510,4518,
          4699,4703,4703,4706,4707,4708,4711,4711,4712,4714,4715,4716,4717,4718,4722,4724,4726,4730,
          4732,4735,4736,4740,4745,4817,4818,4818,4819,4820,4821,4821,4822,4823,4825,4826,4827,4828,
          4829,4830,4830,4833,4833,4834,4834,4839,4840,4841,4845,4845,4846,4847,4848,4850,5256,5264,
          5272,5306,5330,5645,5678,5710,5942,6221,10009,10125,10140,10845,10854,10907,26556,26653,
          27313,27529,60879,60911,60912,66734,66735,66736,91002,96617,98102,108233,108656,111575,112466,
          112623,113522,113613,114926,119826,129286,130443,131599,133480,133595,134437,135873,137097,
          137208,137315,139444,139725,139857,142026,142780,144667,144691,144741,145367,145790,147595,
          148460,148528,150631,150912,150938,151928,152031,152629,154028,154042,154050,154066,154098,
          155357,155556,157784,158139,158186,159723,173864,179184,188092,188286,188473,188604,189848,
          190432,191030,191112,191302,191303,192623,192921,193379,193592,194733,194894,195042,197153,
          197586,197967,218842,230433,233577,234237,235804,246702,276469,296137,315655,331009,344218,
          349621,353086,356055,357715,368753,371740,382010,385294,390286)
          order by sec


/*Select Mes,cod,dig,sec,secao,grupo,ncc_descricao as Gr_Desc,descricao,qtd,valor

from

(
  Select vda.id_mes as mes,git_cod_item as cod,git_digito as dig,
         git_secao as sec,
       decode (git_secao,100,'Molhos e Condimentos',102,'Bomboniere',103,'Oleos e Azeites',104,'Bebidas',105,'Matinais',108,'Biscoitos',
                109,'Cereais e Empacotados',110,'Massas',200,'Perfumaria',201,'Limpreza',300,'Hortifruti-Granjeiro',301,'Congelados',
                302,'Frios e Laticinios',305,'A�ougue',306,'Padaria',400,'Utilidades' ) as secao,  
               git_grupo as grupo ,git_descricao as descricao,sum(nvl(q_vda-q_dvol,0))qtd,sum(nvl(v_vda-v_dvol,0))valor

   from (select id_mes,cd_prod,sum(nvl(qtd_vda,0))q_vda,sum(nvl(vl_vda,0))v_vda from agg_vda_prod_mes a group by id_mes,cd_prod )vda,
        (select id_mes,cd_prod,sum(nvl(qtd_dvol_vda,0))q_dvol,sum(nvl(vl_dvol_vda,0))v_dvol from agg_mvto_prod_mes group by id_mes,cd_prod )mvt,
        (select git_cod_item,git_digito,git_descricao,git_secao,git_grupo 
              from aa3citem 
                where git_secao NOT IN (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506))item
              
        
        where vda.id_mes = mvt.id_mes
          and vda.cd_prod = mvt.cd_prod
          and vda.cd_prod = item.git_cod_item 
        group by vda.id_mes,git_cod_item,git_digito,git_secao, git_grupo,git_descricao )agg , aa3cnvcc
               
          where agg.mes between '&Inicial' and '&Final'   ---201601 and 201601
          and cod in (16,25,54,1000,1009,1028,1040,1043,1045,1047,1055,1057,1059,1063,1067,1068,1071,1077,1081,
          1085,1089,1092,1097,1104,1161,1162,1163,1164,1165,1167,1170,1220,1231,1232,1233,1239,1240,
          1242,1243,1244,1252,1254,1355,1417,1423,1511,1519,1552,1616,1617,1617,1620,1637,1643,1643,
          1644,1645,1654,1655,1657,1657,1658,1659,1662,1667,1696,1708,1708,1713,1720,1736,1765,1785,
          1866,1870,1913,1925,1990,2019,2030,2196,2262,2337,2402,2471,2550,2758,3526,3603,3689,3703,
          3783,3784,3785,3856,3962,3969,4111,4458,4459,4460,4469,4470,4471,4487,4491,4501,4510,4518,
          4699,4703,4703,4706,4707,4708,4711,4711,4712,4714,4715,4716,4717,4718,4722,4724,4726,4730,
          4732,4735,4736,4740,4745,4817,4818,4818,4819,4820,4821,4821,4822,4823,4825,4826,4827,4828,
          4829,4830,4830,4833,4833,4834,4834,4839,4840,4841,4845,4845,4846,4847,4848,4850,5256,5264,
          5272,5306,5330,5645,5678,5710,5942,6221,10009,10125,10140,10845,10854,10907,26556,26653,
          27313,27529,60879,60911,60912,66734,66735,66736,91002,96617,98102,108233,108656,111575,112466,
          112623,113522,113613,114926,119826,129286,130443,131599,133480,133595,134437,135873,137097,
          137208,137315,139444,139725,139857,142026,142780,144667,144691,144741,145367,145790,147595,
          148460,148528,150631,150912,150938,151928,152031,152629,154028,154042,154050,154066,154098,
          155357,155556,157784,158139,158186,159723,173864,179184,188092,188286,188473,188604,189848,
          190432,191030,191112,191302,191303,192623,192921,193379,193592,194733,194894,195042,197153,
          197586,197967,218842,230433,233577,234237,235804,246702,276469,296137,315655,331009,344218,
          349621,353086,356055,357715,368753,371740,382010,385294,390286)
          and ncc_secao = sec
          and ncc_grupo = grupo
          and ncc_grupo > 0 
          and ncc_subgrupo = 0 */
      
/*16,25,54,1000,1009,1028,1040,1043,1045,1047,1055,1057,1059,1063,
                      1067,1068,1071,1077,1081,1085,1089,1092,1097,1104,1161,1162,1163,
                      1164,1165,1167,1170,1220,1231,1232,1233,1239,1240,1242,1243,1244,
                      1252,1254,1355,1417,1423,1511,1519,1552,1617,1637,1643,1657,1662,1667,1708,1736,1765,
                      1785,1866,1870,1913,1925,1990,2019,2030,2196,2337,2402,2471,2550,
                      2758,3526,3603,3689,3703,3783,3784,3785,3856,3962,3969,4111,4711,4703,4818,4821,4830,4833,4834,4845,5256,
                      5264,5272,5306,5330,5645,5678,5710,6221,10009,10125,10140,10845,
                      10854,10907,26556,26653,27313,27529,60879,60911,60912,66734,66735,
                      66736,91002,96617,98102,108233,108656,111575,112466,112623,113522,
                      113613,114926,119826,129286,130443,131599,133480,133595,134437,135873,
                      137097,137208,137315,139444,139725,139857,142026,142780,144667,144691,
                      144741,145367,145790,147595,148460,148528,150631,150912,150938,151928,
                      152031,152629,154028,154042,154050,154066,154098,155357,155556,157784,
                      158139,158186,159723,173864,179184,188092,188286,188473,188604,189848,
                      190432,191030,191112,191302,191303,192623,192921,193379,193592,194733,
                      194894,195042,197153,197586,197967,218842,230433,233577,234237,235804,
                      246702,276469,296137,315655,331009,344218,349621,353086,356055,357715,
                      368753,371740,382010,385294,390286*/
