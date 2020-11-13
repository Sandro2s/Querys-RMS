-- Empresa : Supermercado São Roque Ltda.
-- Data :24/05/2013 
-- Atualizado em : 24/05/2013
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Solange Pinheiro
-- Descrição : Planilha para conferencia de diferenças no Gerencial.
 

   Select  LJ as Loja
       ,dta
       ,sum(leitura_z)    as leitura_z
       ,sum(ag_21)        as ag_21
       ,sum(ag_53)        as ag_53
       ,sum(gerencial)    as gerencial
       ,trunc (sum(ag_53-gerencial-ag_21)) as Ag_53_X_Ger 
       ,sum(cl) as Cliente
          
from
(
--Leitura Z (Tesouraria)
Select  lz_loja as LJ
       ,rms7to_date( lz_data) dta 
       ,sum(lz_valteclas_1+lz_valteclas_2) as Leitura_Z 
       ,to_number(0) as ag_21
       ,to_number(0) as ag_53
       ,to_number(0) as gerencial
       ,sum(lz_clientes) as cl
       from AG2VLEIZ
where lz_data between '&Dta_Inicio' and '&Dta_Final'--between 1130501 and 1130524
group by lz_loja,lz_data
Union 
--Cancelamento agenda 21
Select to_number(fis_loj_dst||fis_dig_dst) as LJ
       ,rms7to_date(fis_dta_agenda) as dta 
       ,to_number(0) as Leitura_Z
       ,sum(fis_val_cont_ff_1 + fis_val_cont_ff_2 +fis_val_cont_ff_3 + fis_val_cont_ff_4 + fis_val_cont_ff_5) as Ag_21  
       ,to_number(0) as ag_53
       ,to_number(0) as gerencial
       ,to_number(0) as cl
    from aa1cfisc 
  where fis_oper = 21 --fis_loj_dst = 1
  and fis_dta_agenda between'&Dta_Inicio' and '&Dta_Final' --between 1130501 and 1130524
  and fis_loj_dst not in (100,120)
  group by fis_loj_dst,fis_dig_dst,fis_dta_agenda
  --order by 1,2 
Union 
-- Importação agenda 53
Select to_number(fis_loj_org||fis_dig_org) as LJ
       ,rms7to_date(fis_dta_agenda) as dta
       ,to_number(0) as Leitura_z
       ,to_number(0) as ag_21
       ,sum(fis_val_cont_ff_1 + fis_val_cont_ff_2 +fis_val_cont_ff_3 + fis_val_cont_ff_4 + fis_val_cont_ff_5) as Ag_53
       ,to_number(0) as gerencial
       ,to_number(0) as cl 
    
    from aa1cfisc  
  where fis_oper = 53 ----fis_loj_org = 1
   and fis_dta_agenda between'&Dta_Inicio' and '&Dta_Final' --between 1130501 and 1130524
  group by fis_loj_org,fis_dig_org,fis_dta_agenda
  
Union 
 --Consulta Gerencial
 select to_number(cd_fil||dac(cd_fil)) as LJ
        ,dim.dt_compl as Dta
        ,to_number(0) as Leitura_z
        ,to_number(0) as Ag_21
        ,to_number(0) as Ag_53
        ,round(sum (nvl(vl_vda,0)- nvl(vl_dvol_vda,0))) as Gerencial
        ,to_number(0) as cl
    from agg_coml_fil agg ,(select id_dt,dt_compl from dim_per where dt_compl between rms7to_date('&Dta_Inicio') and rms7to_date('&Dta_Final'))dim  
   where cd_fil not in (50,51,52,52,53,100,103,120,13,14)
   and agg.id_dt = dim.id_dt
   group by cd_fil,dim.dt_compl
   )
   group by LJ,DTA --,ag_53,gerencial
   order by 1,2
   