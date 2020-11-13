Select mes
       ,fis_loj_org_dst as Loja
       ,sum(compra) as compra 
       ,sum(Trans_Entrada) as Trans_Entrada
       ,sum(Trans_Saida) as Trans_Saida
       ,sum(Devol_Compra) as Devol_Compra
       ,sum(Devol_Venda) as Devol_Venda
       ,sum(Bonificacao) as Bonificacao
from
-- Supermercado São Roque Ltda.
-- Data : 24/05/2013
-- Solicitante : Solange
-- Desenvolvedor : Sandro Soares
-- Descrição : Extração dos dados do Fiscal (VGLUCFIS) para conciliacao com gerencial.
-- Manutenção : 24/05/2013
 (select  to_char(rms7to_date(fis_dta_agenda),'MM') as Mes
       ,fis_loj_org_dst
       ,sum (Case when fis_oper in (2,3,4,6,7,8,28,33,38,250,702,703,704,706,707,718) then (fis_val_cont_ff_1 + fis_val_cont_ff_2 +fis_val_cont_ff_3 + fis_val_cont_ff_4 + fis_val_cont_ff_5) end)compra
       ,sum (Case when fis_oper in (12,13,14,22,37,39,651,652,653,654,668,671,672,674,678,712,714,717,725,726,727,998) then (fis_val_cont_ff_1 + fis_val_cont_ff_2 +fis_val_cont_ff_3 + fis_val_cont_ff_4 + fis_val_cont_ff_5) end)Trans_Entrada
       ,sum (Case when fis_oper in (42,43,47,48,49,57,67,68,72,74,667,669,670,673,675,729,730,734,735,736,737,738,741,854,997) then (fis_val_cont_ff_1 + fis_val_cont_ff_2 +fis_val_cont_ff_3 + fis_val_cont_ff_4 + fis_val_cont_ff_5) end)Trans_Saida
       ,sum (Case when fis_oper in (44,45,49,71,642,643,731) then (fis_val_cont_ff_1 + fis_val_cont_ff_2 +fis_val_cont_ff_3 + fis_val_cont_ff_4 + fis_val_cont_ff_5) end)Devol_Compra
       ,sum (Case when fis_oper in (21,20,61,564,729) then (fis_val_cont_ff_1 + fis_val_cont_ff_2 +fis_val_cont_ff_3 + fis_val_cont_ff_4 + fis_val_cont_ff_5) end)Devol_Venda
       ,sum (Case when fis_oper in (9,10,249,655,709,710,917) then (fis_val_cont_ff_1 + fis_val_cont_ff_2 +fis_val_cont_ff_3 + fis_val_cont_ff_4 + fis_val_cont_ff_5) end)Bonificacao
      from aa1cfisc where fis_oper > 0  
       and fis_dta_agenda between 1130101 and 1130430
       and fis_loj_org_dst in (1,2,3,4,5,7,8,9,10,11,12,14,15,18,19,20,21,22,100,120) 
      -- and fis_loj_org = 1327   
      group by fis_dta_agenda,fis_loj_org_dst)
      group by mes,fis_loj_org_dst
      order by 1,2