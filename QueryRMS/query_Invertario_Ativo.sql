/*select  rms7to_date(devi_dta_agenda) as Dta_Agenda
       ,devi_Destino as Loja
       ,devi_tpo_agenda as Agenda
       ,devi_nota as Nota
       ,devi_qtd_fat  as Qtda
       ,devi_prc_emb  as Valor_Unit
       ,devi_descr_inf as Descricao
       ,(devi_dta_agenda||devi_destino||devi_tpo_agenda||devi_nota) as flag
  from ag1detdv 
     where devi_tpo_agenda in (522,524,526,528)
     order by dta_agenda,agenda,nota

------------------------------------------------------------------------------------
select  rms7to_date(ie.eschc_data) as Dta_Agenda
       ,to_number(ie.esclc_codigo||ie.esclc_digito) as Lojas
       ,ie.eschc_agenda as Agenda
       ,ie.eschc_nro_nota as Nota
       ,ie.entsaic_quanti_un as Qtda
       ,ie.entsaic_prc_un as Custo_Unit
       ,nvl(ie.entsaic_quanti_un *ie.entsaic_prc_un,0) as Total
       ,ie.eschc_data||to_number(ie.esclc_codigo||ie.esclc_digito||ie.eschc_agenda||ie.eschc_nro_nota )as flag
from ag1iensa ie 
     where ie.eschc_agenda3 in  (522,524,526,528)
order by dta_agenda,agenda,nota*/

------------------------------------------------------------------      
select  dta_agenda
       ,Lojas
       ,agenda
       ,nota
       ,qtda
       ,valor_unit
       ,max(descricao)
       ,(total)
 from 
(
select  rms7to_date(ie.eschc_data) as Dta_Agenda
       ,to_number(ie.esclc_codigo||ie.esclc_digito) as Lojas
       ,ie.eschc_agenda as Agenda
       ,ie.eschc_nro_nota as Nota
       ,sum(ie.entsaic_quanti_un) as Qtda
       ,ie.entsaic_prc_un as Valor_Unit
       ,            ''    as Descricao
       ,nvl(sum(ie.entsaic_quanti_un) *ie.entsaic_prc_un,0) as Total
   
from ag1iensa ie 
     where ie.eschc_agenda3 in  (522,524,526,528)
     group by ie.eschc_data,ie.esclc_codigo,ie.esclc_digito,ie.eschc_agenda,ie.entsaic_prc_un,ie.eschc_nro_nota
--order by dta_agenda,agenda,nota

Union 
select  rms7to_date(devi_dta_agenda) as Dta_Agenda
       ,devi_Destino as Lojas
       ,devi_tpo_agenda as Agenda
       ,devi_nota as Nota
       ,devi_qtd_fat  as Qtda
       ,devi_prc_emb  as Valor_Unit
       ,devi_descr_inf as Descricao
       ,nvl(devi_qtd_fat*devi_prc_emb,0)  as Total
  from ag1detdv 
     where devi_tpo_agenda in (522,524,526,528)
--     order by dta_agenda,agenda,nota  
 )
  group by Lojas,nota,dta_agenda,agenda,qtda,valor_unit,total 
  order by dta_agenda,agenda,nota
  