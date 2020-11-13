-- Supermercado São Roque Ltda.
-- Data : 01/04/2013
-- Solicitante : Solange
-- Desenvolvedor : Sandro Soares
-- Descrição : Trazer todas as notas conforme agenda de dobra apontadas.
-- Manutenção : 01/04/2013
Select * from 
(select rms7to_date(fis_dta_agenda) as Dt_agenda,
       to_number(fis_loj_org||fis_dig_org) as Loja,
       fis_oper as Agenda_Saida,
       fis_nro_nota as Nr_nota,
       --fis_serie as Serie,
       (fis_val_cont_ff_1+fis_val_cont_ff_2+fis_val_cont_ff_3+fis_val_cont_ff_4+fis_val_cont_ff_5) as Vlr_Contabil,
       fis_situacao --decode (fis_situacao,'9','Cancelada')as Situacao
  from aa1cfisc
 where rms7to_date(fis_dta_agenda) between to_date('&Dta_Inicio','dd/mm/yyyy') and to_date('&Dta_Final','dd/mm/yyyy')
 and fis_oper in (42,43,47,48,49,57,67,68,72,74,667,669,670,671,673,675,679)
 and fis_situacao <> '9' )A,
 
 (select rms7to_date(fis_dta_agenda) as Dt_agenda,
       to_number(fis_loj_dst||fis_dig_dst) as Loja,
       fis_oper as Agenda_Entrada,
       fis_nro_nota as Nr_nota,
       --fis_serie as Serie,
       sum(fis_val_cont_ff_1+fis_val_cont_ff_2+fis_val_cont_ff_3+fis_val_cont_ff_4+fis_val_cont_ff_5) as Vlr_Contabil,
       fis_situacao --decode (fis_situacao,'9','Cancelada')as Situacao
  from aa1cfisc
 where rms7to_date(fis_dta_agenda) between to_date('&Dta_Inicio','dd/mm/yyyy') and to_date('&Dta_Final','dd/mm/yyyy')
 and fis_oper in (12,13,14,22,37,39,651,652,653,654,668,671,672,674,676,681)group by fis_dta_agenda,fis_loj_dst,fis_dig_dst,fis_oper,fis_nro_nota,fis_situacao)B
  where a.nr_nota = b.nr_nota (+)
   and b.agenda_entrada is null
   order by 1,2