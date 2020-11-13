-- Empresa : Supermercado São Roque Ltda.
-- Data :02/02/2013 
-- Atualizado em : 24/04/2013
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Solange Pinheiro
-- Descrição : Retorna as movimentações de finalizadoras por dia e por loja.
--             Também incluido as devolucoes da agenda 21 por dia, enviar junto.              
 
Select 
        r.cod as Loja
       ,r.finalizadora as finalizadora
       ,r.tab_conteudo as descricao
       ,nvl(sum(r.a),0)as "01",nvl(sum(r.b),0) as "02",nvl(sum(r.c),0)  as "03",nvl(sum(r.d),0)  as "04",nvl(sum(r.e),0)  as "05",nvl(sum(r.f),0)  as "06",nvl(sum(r.g),0)  as "07",nvl(sum(r.h),0) as "08",nvl(sum(r.i),0)  as "09",nvl(sum(r.j),0) as "10"
       ,nvl(sum(r.l),0)  as "11",nvl(sum(r.m),0) as "12",nvl(sum(r.n),0)  as "13",nvl(sum(r.p),0)  as "14",nvl(sum(r.q),0)  as "15",nvl(sum(r.r),0)  as "16",nvl(sum(r.s),0)  as "17",nvl(sum(r.t),0) as "18",nvl(sum(r.u),0)  as "19",nvl(sum(r.v),0) as "20"
       ,nvl(sum(r.x),0)  as "21",nvl(sum(r.z),0) as "22",nvl(sum(r.aa),0) as "23",nvl(sum(r.ab),0) as "24",nvl(sum(r.ac),0) as "25",nvl(sum(r.ad),0) as "26",nvl(sum(r.ae),0) as "27",nvl(sum(r.af),0) as "28",nvl(sum(r.ag),0) as "29",nvl(sum(r.ah),0) as "30"
       ,nvl(sum(r.ai),0) as "31"

from
(
select cod,
       finalizadora,
       tab_conteudo,
       case when dta = '01' then to_number(sum(vlr)) end as A,
       case when dta = '02' then to_number(sum(vlr)) end as B,
       case when dta = '03' then to_number(sum(vlr)) end as C,
       case when dta = '04' then to_number(sum(vlr)) end as D,
       case when dta = '05' then to_number(sum(vlr)) end as E,
       case when dta = '06' then to_number(sum(vlr)) end as F,
       case when dta = '07' then to_number(sum(vlr)) end as G,
       case when dta = '08' then to_number(sum(vlr)) end as H,
       case when dta = '09' then to_number(sum(vlr)) end as I,
       case when dta = '10' then to_number(sum(vlr)) end as J,
       case when dta = '11' then to_number(sum(vlr)) end as L,
       case when dta = '12' then to_number(sum(vlr)) end as M,
       case when dta = '13' then to_number(sum(vlr)) end as N,
       case when dta = '14' then to_number(sum(vlr)) end as P,
       case when dta = '15' then to_number(sum(vlr)) end as Q,
       case when dta = '16' then to_number(sum(vlr)) end as R,
       case when dta = '17' then to_number(sum(vlr)) end as S,
       case when dta = '18' then to_number(sum(vlr)) end as T,
       case when dta = '19' then to_number(sum(vlr)) end as U,
       case when dta = '20' then to_number(sum(vlr)) end as V,
       case when dta = '21' then to_number(sum(vlr)) end as X,
       case when dta = '22' then to_number(sum(vlr)) end as Z,
       case when dta = '23' then to_number(sum(vlr)) end as AA, 
       case when dta = '24' then to_number(sum(vlr)) end as AB,
       case when dta = '25' then to_number(sum(vlr)) end as AC,
       case when dta = '26' then to_number(sum(vlr)) end as AD,
       case when dta = '27' then to_number(sum(vlr)) end as AE,
       case when dta = '28' then to_number(sum(vlr)) end as AF,
       case when dta = '29' then to_number(sum(vlr)) end as AG,
       case when dta = '30' then to_number(sum(vlr)) end as AH,
       case when dta = '31' then to_number(sum(vlr)) end as AI
from vw_finalizadora,
(
select mcof_loja, 
       mcof_finaliza,
       nvl(mcof_valor,0) vlr,
       substr(mcof_data,6,7) as dta
  from ag2vmcof
 where mcof_agenda in 
       (122, 123, 124, 125, 126, 127, 128, 129, 130, 136, 140, 142, 143, 144)
       and mcof_data between 1||to_char(to_date('&Dta_Inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd') ---between (1130301) and (1130331)
      )A 
      
      where cod  = mcof_loja (+)
      and finalizadora  = mcof_finaliza (+) 
      group by cod,dta,finalizadora,tab_conteudo
      
      )r where r.cod not in (132,140,167,175,388)
      group by  r.cod ,r.finalizadora ,r.tab_conteudo 
      order by loja,finalizadora;

-----------------------------------------------------------------------------------------------------------------------------------

-- Retorna valores para conferencia das venda. 
Select  LJ as Loja
           ,dta
           ,sum(leitura_z)    as leitura_z
           ,sum(ag_21)        as ag_21
           ,sum(ag_53)        as ag_53
           ,sum(gerencial)    as gerencial
           ,trunc (sum(ag_53-gerencial-ag_21)) as Ag_53_X_Ger
           ,sum(cl) as Cliente
           ,sum(cup) as cupom 
           ,round(sum(qt_vd)) as qtde_vda
          
from
(
--Leitura Z (Tesouraria)
Select  rl_loja as LJ
       ,rms7to_date( rl_data) dta
       ,sum(rl_totmaq_1) as Leitura_Z
       ,to_number(0) as ag_21
       ,to_number(0) as ag_53
       ,to_number(0) as gerencial
       ,sum(rl_clientes_1) as cl
       ,to_number(0) as cup
       ,to_number(0) as qt_vd
       
       from AG2VRLCX
where rl_data between 1||to_char(to_date('&Dta_Inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd')--(select 1||to_char((add_months(sysdate,-retro)-1),'yymmdd') as Dta_Inicio from dual) and (select 1||To_char(sysdate,'yymmdd') dta_final from dual)
group by rl_loja,rl_data
/*Select  lz_loja as LJ
       ,rms7to_date( lz_data) dta 
       ,sum(lz_valteclas_1 + lz_valteclas_2 ) as Leitura_Z 
       ,to_number(0) as ag_21
       ,to_number(0) as ag_53
       ,to_number(0) as gerencial
       ,sum(lz_clientes) as cl
       from AG2VLEIZ
where lz_data between 1||to_char(to_date('&Dta_Inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd') ---between (1130301) and (1130331)
group by lz_loja,lz_data */Union 
--Cancelamento agenda 21
Select to_number(fis_loj_dst||fis_dig_dst) as LJ
       ,rms7to_date(fis_dta_agenda) as dta 
       ,to_number(0) as Leitura_Z
       ,sum(fis_val_cont_ff_1 + fis_val_cont_ff_2 +fis_val_cont_ff_3 + fis_val_cont_ff_4 + fis_val_cont_ff_5) as Ag_21  
       ,to_number(0) as ag_53
       ,to_number(0) as gerencial
       ,to_number(0) as cl
       ,to_number(0) as cup
       ,to_number(0) as qt_vd
    from aa1cfisc 
  where fis_oper in (20,21,621)   --fis_oper = 21 --fis_loj_dst = 1
  and fis_dta_agenda between 1||to_char(to_date('&Dta_Inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd') ---between (1130301) and (1130331)
  and fis_loj_dst not in (9,10,100,120)
  and fis_situacao <> '9'
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
       ,to_number(0) as cup
       ,to_number(0) as qt_vd 
    
    from aa1cfisc  
  where fis_oper = 53 ----fis_loj_org = 1
   and fis_dta_agenda between 1||to_char(to_date('&Dta_Inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd') ---between (1130301) and (1130331)
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
        ,to_number(0) as cup
        ,(agg.qtd_vda - nvl(agg.qtd_dvol_vda,0))as qt_vd
    from agg_coml_fil agg ,(select id_dt,dt_compl from dim_per where dt_compl between to_date('&dta_inicial','dd/mm/yy') and to_date('&Dta_Final','dd/mm/yy'))dim  
   where cd_fil not in (9,10,50,51,52,52,53,100,103,120,13,14)
   and agg.id_dt = dim.id_dt 
   group by cd_fil,dim.dt_compl,agg.qtd_vda,agg.qtd_dvol_vda

Union
 -- Consulta cupons Visual Mix
select  to_number(loja||dac(loja)) as LJ
       ,data as Dta
       ,to_number(0) as Leitura_z
       ,to_number(0) as Ag_21
       ,to_number(0) as Ag_53
       ,to_number(0) as Gerencial
       ,to_number(0) as cl
       ,sum(qtd_cuponsvenda)as cup
       ,to_number(0) as qt_vd
  from vm_log.total_oper
 where data between to_date('&dta_inicial', 'dd/mm/yyyy') and to_date('&Dta_Final', 'dd/mm/yyyy')
       group by loja,data 
      
   )
   group by LJ,DTA 
   order by 1,2



/* --Enviar junto com o moviemnto da tesourária as devoluções da agenda 21
 
 select  to_number(fis_loj_org||fis_dig_org) as LJ
       ,rms7to_date(fis_dta_agenda)as dta
       ,fis_oper as agenda
       ,sum(fis_val_cont_ff_1+fis_val_cont_ff_2+fis_val_cont_ff_3+fis_val_cont_ff_4+fis_val_cont_ff_5)as vl

  from aa1cfisc
 where rms7to_date(FIS_DTA_AGENDA) between to_date('&Dta_Inicial','dd/mm/yyyy') and to_date('&Dta_Final','dd/mm/yyyy')
   and fis_oper = 21
   and fis_situacao <> '9'
   and fis_loj_org  not in (1007)
   group by fis_loj_org,fis_dig_org,fis_dta_agenda,fis_oper
   order by 1,2  */
