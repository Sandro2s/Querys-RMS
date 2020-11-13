-- Empresa : Supermercado São Roque Ltda.
-- Data :26/05/2009 
-- Atualizado em : 26/05/2009
-- Desenvolvedor : Sandro Soares.
-- Descrição : Venda da Padaria da loja 1 , 2 e 3.

 
Select Loja                as Loja,
       Descricao           as Descricao,
       codigo              as Codigo,
       max(Tipo)           as Tipo,
       max(Agenda_1)       as Agenda_1,
       sum(nvl(Valor_1,0)) as Valor_1,
       sum(nvl(Quant_1,0)) as Quant_1,
       max(Agenda_2)       as Agenda_2,
       sum(nvl(Valor_2,0)) as Valor_2,
       sum(nvl(Quant_2,0)) as Quant_2,
       max(Agenda_3)       as Agenda_3,
       sum(nvl(Valor_3,0)) as Valor_3,
       sum(nvl(Quant_3,0)) as Quant_3
from
(
Select ie.eschljc_codigo3||ie.eschljc_digito3               as Loja,
       aa.git_descricao                                     as Descricao,
       ie.esitc_codigo||ie.esitc_digito                     as Codigo,
       ie.entsaic_tpo_emb                                   as Tipo,
       ie.eschc_agenda3                                     as Agenda_1,
       sum(nvl(ie.entsaic_quanti_un * ie.entsaic_prc_un,0)) as Valor_1,
       sum(NVL(ie.entsaic_quanti_un,0) )                    as Quant_1,
       0                                                    as Agenda_2,
       0                                                    as Valor_2,
       0                                                    as Quant_2,
       0                                                    as Agenda_3,
       0                                                    as Valor_3,
       0                                                    as Quant_3
  from ag1iensa ie, aa3citem aa
 where ie.esitc_codigo = aa.git_cod_item
   and ie.eschc_agenda3 = 53
   and ie.eschljc_codigo3 in (1,2,3)
   and ie.eschc_data3 between &datainicio and &datafinal --= 1090801
   --and aa.git_cod_item  = ie.esitc_codigo
   and aa.git_cod_item in
          (1773, 1783, 4952, 3962, 4994, 8052, 1957, 1762, 1774, 6221, 2239, 2290, 2292,
           2392, 2394, 2396, 1802, 1614, 2402, 2404, 2406, 2477, 3766, 3767)
          --order by codigo
          Group by ie.eschljc_codigo3||ie.eschljc_digito3,ie.esitc_codigo||ie.esitc_digito,
                   ie.entsaic_tpo_emb,ie.eschc_agenda3,aa.git_descricao
 Union
Select ie.esclc_codigo||ie.esclc_digito                     as Loja,
       aa.git_descricao                                     as Descricao,
       ie.esitc_codigo||ie.esitc_digito                     as Codigo,
       ie.entsaic_tpo_emb                                   as Tipo,
       0                                                    as Agenda_1,
       0                                                    as Valor_1,
       0                                                    as Quant_1,
       ie.eschc_agenda3                                     as Agenda_2,
       sum(nvl(ie.entsaic_quanti_un * ie.entsaic_cus_un,0)) as Valor_2,
       sum(NVL(ie.entsaic_quanti_un,0) )                    as Quant_2,
       0                                                    as Agenda_3,
       0                                                    as Valor_3,
       0                                                    as Quant_3
  from ag1iensa ie,aa3citem aa
 where ie.esitc_codigo = aa.git_cod_item
   and ie.eschc_agenda3 = 916
   and ie.esclc_codigo in (1,2,3)
   and ie.eschc_data3 between &datainicio and &datafinal  --= 1090801
   and ie.esitc_codigo in
          (1773, 1783, 4952, 3962, 4994, 8052, 1957, 1762, 1774, 6221, 2239, 2290, 2292,
           2392, 2394, 2396, 1802, 1614, 2402, 2404, 2406, 2477, 3766, 3767)
       group by ie.esclc_codigo||ie.esclc_digito, ie.eschljc_codigo3||ie.eschljc_digito3,ie.esitc_codigo||ie.esitc_digito,
          ie.entsaic_tpo_emb,ie.eschc_agenda3,aa.git_descricao
       -- order by codigo
Union
Select ie.eschljc_codigo3||ie.eschljc_digito3               as Loja,
       aa.git_descricao                                     as Descricao,
       ie.esitc_codigo||ie.esitc_digito                     as Codigo,
       ie.entsaic_tpo_emb                                   as Tipo,
       0                                                    as Agenda_1,
       0                                                    as Valor_1,
       0                                                    as Quant_1,
       0                                                    as Agenda_2,
       0                                                    as Valor_2,
       0                                                    as Quant_2,
       ie.eschc_agenda3                                     as Agenda_3,
       sum(nvl(ie.entsaic_quanti_un * ie.entsaic_cus_un,0)) as Valor_3,
       sum(NVL(ie.entsaic_quanti_un,0) )                    as Quant_3
  from ag1iensa ie,aa3citem aa
 where ie.esitc_codigo = aa.git_cod_item
   and ie.eschc_agenda3 = 63
   and ie.esclc_codigo in (1,2,3)
   and ie.eschc_data3 between &datainicio and &datafinal --= 1090801
   and ie.esitc_codigo in
          (1773, 1783, 4952, 3962, 4994, 8052, 1957, 1762, 1774, 6221, 2239, 2290, 2292,
           2392, 2394, 2396, 1802, 1614, 2402, 2404, 2406, 2477, 3766, 3767)
         group by ie.eschljc_codigo3||ie.eschljc_digito3,ie.esitc_codigo||ie.esitc_digito,
          ie.entsaic_tpo_emb,ie.eschc_agenda3,aa.git_descricao
 union
 Select ie.eschljc_codigo3 || ie.eschljc_digito3 as Loja,
        aa.git_descricao                         as Descricao,
        aa.git_cod_item||aa.git_digito           as Codigo,
        ie.entsaic_tpo_emb                       as Tipo,
        0                                        as Agenda_1,
        0                                        as Valor_1,
        0                                        as Quant_1,
        0                                        as Agenda_2,
        0                                        as Valor_2,
        0                                        as Quant_2,
        0                                        as Agenda_3,
        0                                        as Valor_3,
        0                                        as Quant_3

  from aa3citem aa
  left outer join (select  *
               from ag1iensa
              where eschc_agenda3 = 53
               and eschljc_codigo3 in (1,2,3)
               and eschc_data3 between &datainicio and &datafinal) ie on aa.git_cod_item = ie.esitc_codigo
               and esitc_codigo in
                    (1773, 1783, 4952, 3962, 4994, 8052, 1957, 1762, 1774, 6221, 2239, 2290, 2292, 2392, 2394, 2396, 1802, 1614, 2402,
                     2404, 2406, 2477,3766, 3767)
                
                
 where aa.git_cod_item in
       (1773, 1783, 4952, 3962, 4994, 8052, 1957, 1762, 1774, 6221, 2239,
        2290, 2292, 2392, 2394, 2396, 1802, 1614, 2402, 2404, 2406, 2477,3766, 3767)
         )

Group by codigo,descricao,loja
Order by loja,codigo --codigo,loja