-- Empresa : Supermercado São Roque Ltda.
-- Data :23/04/2014 
-- Atualizado em : 24/04/2014
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Solange Pinheiro
-- Descrição : Auditoria na tesouraria no novimento de quebras

Select * from
 (
 Select 
        r.mcof_loja as Loja
       ,'Entradas Transf' as Descricao
       ,nvl(sum(r.a),0)as "01",nvl(sum(r.b),0) as "02",nvl(sum(r.c),0)  as "03",nvl(sum(r.d),0)  as "04",nvl(sum(r.e),0)  as "05",nvl(sum(r.f),0)  as "06",nvl(sum(r.g),0)  as "07",nvl(sum(r.h),0) as "08",nvl(sum(r.i),0)  as "09",nvl(sum(r.j),0) as "10"
       ,nvl(sum(r.l),0)  as "11",nvl(sum(r.m),0) as "12",nvl(sum(r.n),0)  as "13",nvl(sum(r.p),0)  as "14",nvl(sum(r.q),0)  as "15",nvl(sum(r.r),0)  as "16",nvl(sum(r.s),0)  as "17",nvl(sum(r.t),0) as "18",nvl(sum(r.u),0)  as "19",nvl(sum(r.v),0) as "20"
       ,nvl(sum(r.x),0)  as "21",nvl(sum(r.z),0) as "22",nvl(sum(r.aa),0) as "23",nvl(sum(r.ab),0) as "24",nvl(sum(r.ac),0) as "25",nvl(sum(r.ad),0) as "26",nvl(sum(r.ae),0) as "27",nvl(sum(r.af),0) as "28",nvl(sum(r.ag),0) as "29",nvl(sum(r.ah),0) as "30"
       ,nvl(sum(r.ai),0) as "31"

from
 (
 select       
       mcof_loja,
       case when dta = '01' then to_number(sum(ent_transf)) end as A,
       case when dta = '02' then to_number(sum(ent_transf)) end as B,
       case when dta = '03' then to_number(sum(ent_transf)) end as C,
       case when dta = '04' then to_number(sum(ent_transf)) end as D,
       case when dta = '05' then to_number(sum(ent_transf)) end as E,
       case when dta = '06' then to_number(sum(ent_transf)) end as F,
       case when dta = '07' then to_number(sum(ent_transf)) end as G,
       case when dta = '08' then to_number(sum(ent_transf)) end as H,
       case when dta = '09' then to_number(sum(ent_transf)) end as I,
       case when dta = '10' then to_number(sum(ent_transf)) end as J,
       case when dta = '11' then to_number(sum(ent_transf)) end as L,
       case when dta = '12' then to_number(sum(ent_transf)) end as M,
       case when dta = '13' then to_number(sum(ent_transf)) end as N,
       case when dta = '14' then to_number(sum(ent_transf)) end as P,
       case when dta = '15' then to_number(sum(ent_transf)) end as Q,
       case when dta = '16' then to_number(sum(ent_transf)) end as R,
       case when dta = '17' then to_number(sum(ent_transf)) end as S,
       case when dta = '18' then to_number(sum(ent_transf)) end as T,
       case when dta = '19' then to_number(sum(ent_transf)) end as U,
       case when dta = '20' then to_number(sum(ent_transf)) end as V,
       case when dta = '21' then to_number(sum(ent_transf)) end as X,
       case when dta = '22' then to_number(sum(ent_transf)) end as Z,
       case when dta = '23' then to_number(sum(ent_transf)) end as AA, 
       case when dta = '24' then to_number(sum(ent_transf)) end as AB,
       case when dta = '25' then to_number(sum(ent_transf)) end as AC,
       case when dta = '26' then to_number(sum(ent_transf)) end as AD,
       case when dta = '27' then to_number(sum(ent_transf)) end as AE,
       case when dta = '28' then to_number(sum(ent_transf)) end as AF,
       case when dta = '29' then to_number(sum(ent_transf)) end as AG,
       case when dta = '30' then to_number(sum(ent_transf)) end as AH,
       case when dta = '31' then to_number(sum(ent_transf)) end as AI
from
(
 select --mcof_agenda,
      
      mcof_loja,
      substr( mcof_data,6,7) dta,
      mcof_finaliza, 
      sum (decode(tbc_intg_3,'S', decode(mcof_serie,'TRF',mcof_valor,0))) ent_transf 
 
 from ag2vmcof,
      aa1ctcon
where tbc_agenda = mcof_agenda
  and tbc_codigo = 0 
  --and mcof_loja  = 27
  and mcof_data  between 1||to_number(to_char(to_date('&Dta_Inicio','dd/mm/yyyy'),'yymmdd')) and  1||to_number(to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd')) --1140301 and 1140331
  and mcof_tipo_mov  = 1
  and mcof_finaliza = 124 
  and mcof_agenda = 135
  group by mcof_data,mcof_finaliza,mcof_loja) 
    group by mcof_loja,ent_transf,dta)r
     group by r.mcof_loja
 
 Union all
  Select 
        r.mcof_loja as Loja
       ,'Saidas' as Descricao
       ,nvl(sum(r.a),0)as "01",nvl(sum(r.b),0) as "02",nvl(sum(r.c),0)  as "03",nvl(sum(r.d),0)  as "04",nvl(sum(r.e),0)  as "05",nvl(sum(r.f),0)  as "06",nvl(sum(r.g),0)  as "07",nvl(sum(r.h),0) as "08",nvl(sum(r.i),0)  as "09",nvl(sum(r.j),0) as "10"
       ,nvl(sum(r.l),0)  as "11",nvl(sum(r.m),0) as "12",nvl(sum(r.n),0)  as "13",nvl(sum(r.p),0)  as "14",nvl(sum(r.q),0)  as "15",nvl(sum(r.r),0)  as "16",nvl(sum(r.s),0)  as "17",nvl(sum(r.t),0) as "18",nvl(sum(r.u),0)  as "19",nvl(sum(r.v),0) as "20"
       ,nvl(sum(r.x),0)  as "21",nvl(sum(r.z),0) as "22",nvl(sum(r.aa),0) as "23",nvl(sum(r.ab),0) as "24",nvl(sum(r.ac),0) as "25",nvl(sum(r.ad),0) as "26",nvl(sum(r.ae),0) as "27",nvl(sum(r.af),0) as "28",nvl(sum(r.ag),0) as "29",nvl(sum(r.ah),0) as "30"
       ,nvl(sum(r.ai),0) as "31"

from
 (
 select       
       mcof_loja,
       case when dta = '01' then to_number(sum(saidas)) end as A,
       case when dta = '02' then to_number(sum(saidas)) end as B,
       case when dta = '03' then to_number(sum(saidas)) end as C,
       case when dta = '04' then to_number(sum(saidas)) end as D,
       case when dta = '05' then to_number(sum(saidas)) end as E,
       case when dta = '06' then to_number(sum(saidas)) end as F,
       case when dta = '07' then to_number(sum(saidas)) end as G,
       case when dta = '08' then to_number(sum(saidas)) end as H,
       case when dta = '09' then to_number(sum(saidas)) end as I,
       case when dta = '10' then to_number(sum(saidas)) end as J,
       case when dta = '11' then to_number(sum(saidas)) end as L,
       case when dta = '12' then to_number(sum(saidas)) end as M,
       case when dta = '13' then to_number(sum(saidas)) end as N,
       case when dta = '14' then to_number(sum(saidas)) end as P,
       case when dta = '15' then to_number(sum(saidas)) end as Q,
       case when dta = '16' then to_number(sum(saidas)) end as R,
       case when dta = '17' then to_number(sum(saidas)) end as S,
       case when dta = '18' then to_number(sum(saidas)) end as T,
       case when dta = '19' then to_number(sum(saidas)) end as U,
       case when dta = '20' then to_number(sum(saidas)) end as V,
       case when dta = '21' then to_number(sum(saidas)) end as X,
       case when dta = '22' then to_number(sum(saidas)) end as Z,
       case when dta = '23' then to_number(sum(saidas)) end as AA, 
       case when dta = '24' then to_number(sum(saidas)) end as AB,
       case when dta = '25' then to_number(sum(saidas)) end as AC,
       case when dta = '26' then to_number(sum(saidas)) end as AD,
       case when dta = '27' then to_number(sum(saidas)) end as AE,
       case when dta = '28' then to_number(sum(saidas)) end as AF,
       case when dta = '29' then to_number(sum(saidas)) end as AG,
       case when dta = '30' then to_number(sum(saidas)) end as AH,
       case when dta = '31' then to_number(sum(saidas)) end as AI
from
(
 select --mcof_agenda,
      mcof_loja,
      substr(mcof_data,6,7) dta,
      mcof_finaliza, 
      sum(decode(tbc_intg_3,'E', decode(mcof_serie,'TRF',0,mcof_valor))) saidas 
 from ag2vmcof,
      aa1ctcon
where tbc_agenda = mcof_agenda
  and tbc_codigo = 0 
  --and mcof_loja  = 27
  and mcof_data  between 1||to_number(to_char(to_date('&Dta_Inicio','dd/mm/yyyy'),'yymmdd')) and  1||to_number(to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd')) --1140301 and 1140331
  and mcof_tipo_mov  = 1
  and mcof_finaliza = 124 
  and mcof_agenda = 199 
  group by mcof_data,mcof_finaliza,mcof_loja) 
    group by mcof_loja,saidas,dta)r
     group by r.mcof_loja
     
 Union all
  Select 
        r.mcof_loja as Loja
       ,'Saidas Trans' as Descricao
       ,nvl(sum(r.a),0)as "01",nvl(sum(r.b),0) as "02",nvl(sum(r.c),0)  as "03",nvl(sum(r.d),0)  as "04",nvl(sum(r.e),0)  as "05",nvl(sum(r.f),0)  as "06",nvl(sum(r.g),0)  as "07",nvl(sum(r.h),0) as "08",nvl(sum(r.i),0)  as "09",nvl(sum(r.j),0) as "10"
       ,nvl(sum(r.l),0)  as "11",nvl(sum(r.m),0) as "12",nvl(sum(r.n),0)  as "13",nvl(sum(r.p),0)  as "14",nvl(sum(r.q),0)  as "15",nvl(sum(r.r),0)  as "16",nvl(sum(r.s),0)  as "17",nvl(sum(r.t),0) as "18",nvl(sum(r.u),0)  as "19",nvl(sum(r.v),0) as "20"
       ,nvl(sum(r.x),0)  as "21",nvl(sum(r.z),0) as "22",nvl(sum(r.aa),0) as "23",nvl(sum(r.ab),0) as "24",nvl(sum(r.ac),0) as "25",nvl(sum(r.ad),0) as "26",nvl(sum(r.ae),0) as "27",nvl(sum(r.af),0) as "28",nvl(sum(r.ag),0) as "29",nvl(sum(r.ah),0) as "30"
       ,nvl(sum(r.ai),0) as "31"

from
 (
 select       
       mcof_loja,
       case when dta = '01' then to_number(sum(sai_transf)) end as A,
       case when dta = '02' then to_number(sum(sai_transf)) end as B,
       case when dta = '03' then to_number(sum(sai_transf)) end as C,
       case when dta = '04' then to_number(sum(sai_transf)) end as D,
       case when dta = '05' then to_number(sum(sai_transf)) end as E,
       case when dta = '06' then to_number(sum(sai_transf)) end as F,
       case when dta = '07' then to_number(sum(sai_transf)) end as G,
       case when dta = '08' then to_number(sum(sai_transf)) end as H,
       case when dta = '09' then to_number(sum(sai_transf)) end as I,
       case when dta = '10' then to_number(sum(sai_transf)) end as J,
       case when dta = '11' then to_number(sum(sai_transf)) end as L,
       case when dta = '12' then to_number(sum(sai_transf)) end as M,
       case when dta = '13' then to_number(sum(sai_transf)) end as N,
       case when dta = '14' then to_number(sum(sai_transf)) end as P,
       case when dta = '15' then to_number(sum(sai_transf)) end as Q,
       case when dta = '16' then to_number(sum(sai_transf)) end as R,
       case when dta = '17' then to_number(sum(sai_transf)) end as S,
       case when dta = '18' then to_number(sum(sai_transf)) end as T,
       case when dta = '19' then to_number(sum(sai_transf)) end as U,
       case when dta = '20' then to_number(sum(sai_transf)) end as V,
       case when dta = '21' then to_number(sum(sai_transf)) end as X,
       case when dta = '22' then to_number(sum(sai_transf)) end as Z,
       case when dta = '23' then to_number(sum(sai_transf)) end as AA, 
       case when dta = '24' then to_number(sum(sai_transf)) end as AB,
       case when dta = '25' then to_number(sum(sai_transf)) end as AC,
       case when dta = '26' then to_number(sum(sai_transf)) end as AD,
       case when dta = '27' then to_number(sum(sai_transf)) end as AE,
       case when dta = '28' then to_number(sum(sai_transf)) end as AF,
       case when dta = '29' then to_number(sum(sai_transf)) end as AG,
       case when dta = '30' then to_number(sum(sai_transf)) end as AH,
       case when dta = '31' then to_number(sum(sai_transf)) end as AI
from
(
 select --mcof_agenda,
      mcof_loja,
      substr(mcof_data,6,7) dta,
      mcof_finaliza, 
      sum(decode(tbc_intg_3,'E', decode(mcof_serie,'TRF',mcof_valor,0))) sai_transf
 
 from ag2vmcof,
      aa1ctcon 
where tbc_agenda = mcof_agenda
  and tbc_codigo = 0 
  --and mcof_loja  = 27
  and mcof_data  between 1||to_number(to_char(to_date('&Dta_Inicio','dd/mm/yyyy'),'yymmdd')) and  1||to_number(to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd')) --1140301 and 1140331
  and mcof_tipo_mov  = 1
  and mcof_finaliza = 1
  and mcof_agenda = 196
  group by mcof_data,mcof_finaliza,mcof_loja ) 
    group by mcof_loja,sai_transf,dta )r
     group by r.mcof_loja )
          
     order by 1,2
     
     