-- Empresa : Supermercado São Roque Ltda.
-- Data :29/10/2012 
-- Atualizado em : 29/10/2012
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Solange Pinheiro
-- Descrição : Gera valores para construção do fluxo de caixa da empresa.


-- Previsto.
Select  Cod_Agrupamento  as Agrupamento
       ,Desc_Agrupamento as Descricao
       ,nvl(sum(r.a),0)as"01",nvl(sum(r.b),0)as"02",nvl(sum(r.c),0)as"03",nvl(sum(r.d),0)as"04",nvl(sum(r.e),0)as"05",nvl(sum(r.f),0)as"06",nvl(sum(r.g),0)as"07",nvl(sum(r.h),0)as"08",nvl(sum(r.i),0)as"09",nvl(sum(r.j),0)as"10"
       ,nvl(sum(r.l),0)as"11",nvl(sum(r.m),0)as"12",nvl(sum(r.n),0)as"13",nvl(sum(r.o),0)as"14",nvl(sum(r.p),0)as"15",nvl(sum(r.q),0)as"16",nvl(sum(r.r),0)as"17",nvl(sum(r.s),0)as"18",nvl(sum(r.t),0)as"19",nvl(sum(r.u),0)as"20"
       ,nvl(sum(r.v),0)as"21",nvl(sum(r.x),0)as"22",nvl(sum(r.z),0)as"23",nvl(sum(r.aa),0)as"24",nvl(sum(r.ab),0)as"25",nvl(sum(r.ac),0)as"26",nvl(sum(r.ad),0)as"27",nvl(sum(r.ae),0)as"28",nvl(sum(r.af),0)as"29",nvl(sum(r.ag),0)as"30"
       ,nvl(sum(r.ah),0)as"31"
       

 from

(
Select  cod_Agrupamento
       ,Desc_Agrupamento
       ,case  when to_char(venc,'dd') = '01' then nvl(sum(valor),0)  end as a 
       ,case  when to_char(venc,'dd') = '02' then nvl(sum(valor),0)  end as b 
       ,case  when to_char(venc,'dd') = '03' then nvl(sum(valor),0)  end as c 
       ,case  when to_char(venc,'dd') = '04' then nvl(sum(valor),0)  end as d 
       ,case  when to_char(venc,'dd') = '05' then nvl(sum(valor),0)  end as e 
       ,case  when to_char(venc,'dd') = '06' then nvl(sum(valor),0)  end as f
       ,case  when to_char(venc,'dd') = '07' then nvl(sum(valor),0)  end as g
       ,case  when to_char(venc,'dd') = '08' then nvl(sum(valor),0)  end as h
       ,case  when to_char(venc,'dd') = '09' then nvl(sum(valor),0)  end as i
       ,case  when to_char(venc,'dd') = '10' then nvl(sum(valor),0)  end as j
       ,case  when to_char(venc,'dd') = '11' then nvl(sum(valor),0)  end as l
       ,case  when to_char(venc,'dd') = '12' then nvl(sum(valor),0)  end as m
       ,case  when to_char(venc,'dd') = '13' then nvl(sum(valor),0)  end as n
       ,case  when to_char(venc,'dd') = '14' then nvl(sum(valor),0)  end as o
       ,case  when to_char(venc,'dd') = '15' then nvl(sum(valor),0)  end as p
       ,case  when to_char(venc,'dd') = '16' then nvl(sum(valor),0)  end as q
       ,case  when to_char(venc,'dd') = '17' then nvl(sum(valor),0)  end as r
       ,case  when to_char(venc,'dd') = '18' then nvl(sum(valor),0)  end as s 
       ,case  when to_char(venc,'dd') = '19' then nvl(sum(valor),0)  end as t
       ,case  when to_char(venc,'dd') = '20' then nvl(sum(valor),0)  end as u
       ,case  when to_char(venc,'dd') = '21' then nvl(sum(valor),0)  end as v
       ,case  when to_char(venc,'dd') = '22' then nvl(sum(valor),0)  end as x
       ,case  when to_char(venc,'dd') = '23' then nvl(sum(valor),0)  end as z
       ,case  when to_char(venc,'dd') = '24' then nvl(sum(valor),0)  end as aa
       ,case  when to_char(venc,'dd') = '25' then nvl(sum(valor),0)  end as ab
       ,case  when to_char(venc,'dd') = '26' then nvl(sum(valor),0)  end as ac
       ,case  when to_char(venc,'dd') = '27' then nvl(sum(valor),0)  end as ad
       ,case  when to_char(venc,'dd') = '28' then nvl(sum(valor),0)  end as ae
       ,case  when to_char(venc,'dd') = '29' then nvl(sum(valor),0)  end as af
       ,case  when to_char(venc,'dd') = '30' then nvl(sum(valor),0)  end as ag
       ,case  when to_char(venc,'dd') = '31' then nvl(sum(valor),0)  end as ah 
 
 from 

(
Select   a.venc
        ,a.agrup as Cod_Agrupamento
        ,a.cont as Desc_Agrupamento
        ,sum(a.valor - a.funrural) as Valor

 from
(
select  rms7to_date(cpm_venc) as venc 
       ,cpd_agenda as agenda
       ,ag.tbc_tpo_rg_fiscal as agrup
       ,ag.tab_conteudo as cont
       ,cpd_vrnota as valor
       ,cpd_funrural as funrural
        
        
  from ag1pagcp,
  (  select tbc_tpo_rg_fiscal --,aa1ctcon.*
         ,agp.tab_conteudo
         ,tbc_agenda
         
    from aa1ctcon ,(
    select to_number(tab_acesso)as agrup
          ,tab_conteudo
     from aa2ctabe 
       where tab_codigo = 14 and tab_conteudo like'AGRUP%'
       order by 1)agp
     where tbc_agenda > 0 
       and tbc_codigo = 0
       and tbc_intg_1 = 'S' 
       and tbc_intg_3 = 'E' 
       and tbc_tpo_rg_fiscal = agp.agrup
    order by 1,2)ag
     where to_number(cpm_venc) between to_char('1'||to_char(to_date('&Dt_Inicial','dd/mm/yyyy'),'yymmdd')) and to_char('1'||to_char(to_date('&Dt_Final','dd/mm/yyyy'),'yymmdd'))
     and cpd_agenda = ag.tbc_agenda
     and cpm_dtpg = 0 
    
Union all   
select  rms7to_date(dup_venc) as venc 
       ,dup_agenda as agenda
       ,ag.tbc_tpo_rg_fiscal as agrup
       ,ag.tab_conteudo as cont
       ,(dup_valor - dup_abatimento) as Valor
       ,0  as funrural
       
  from aa1rtitu,
  (  select tbc_tpo_rg_fiscal --,aa1ctcon.*
         ,agp.tab_conteudo
         ,tbc_agenda
         
    from aa1ctcon ,(
    select to_number(tab_acesso)as agrup
          ,tab_conteudo
     from aa2ctabe 
       where tab_codigo = 14 and tab_conteudo like'AGRUP%'
       order by 1)agp
     where tbc_agenda > 0 
       and tbc_codigo = 0
       and tbc_intg_5 = 'S' 
       and tbc_intg_3 = 'S' 
       and tbc_tpo_rg_fiscal = agp.agrup
    order by 1,2)ag
     where to_number(dup_venc) between to_char('1'||to_char(to_date('&Dt_Inicial','dd/mm/yyyy'),'yymmdd')) and to_char('1'||to_char(to_date('&Dt_Final','dd/mm/yyyy'),'yymmdd'))
     and dup_agenda = ag.tbc_agenda
     and dup_dt_pag  = 0 )a  
    group by a.venc,a.agrup ,a.cont
    order by 1
 )
  group by  venc,cod_agrupamento,Desc_Agrupamento
 )r
  having Cod_Agrupamento not in(609,611,615,736)
  group by Cod_Agrupamento,Desc_Agrupamento ;
  
--------------------------------------------------------------------------------------------------
--Realizado

Select  tbc_tpo_rg_fiscal as Agrupamento
       ,tab_conteudo as Descricao
       ,nvl(sum(r.a),0)as"01",nvl(sum(r.b),0)as"02",nvl(sum(r.c),0)as"03",nvl(sum(r.d),0)as"04",nvl(sum(r.e),0)as"05",nvl(sum(r.f),0)as"06",nvl(sum(r.g),0)as"07",nvl(sum(r.h),0)as"08",nvl(sum(r.i),0)as"09",nvl(sum(r.j),0)as"10"
       ,nvl(sum(r.l),0)as"11",nvl(sum(r.m),0)as"12",nvl(sum(r.n),0)as"13",nvl(sum(r.o),0)as"14",nvl(sum(r.p),0)as"15",nvl(sum(r.q),0)as"16",nvl(sum(r.r),0)as"17",nvl(sum(r.s),0)as"18",nvl(sum(r.t),0)as"19",nvl(sum(r.u),0)as"20"
       ,nvl(sum(r.v),0)as"21",nvl(sum(r.x),0)as"22",nvl(sum(r.z),0)as"23",nvl(sum(r.aa),0)as"24",nvl(sum(r.ab),0)as"25",nvl(sum(r.ac),0)as"26",nvl(sum(r.ad),0)as"27",nvl(sum(r.ae),0)as"28",nvl(sum(r.af),0)as"29",nvl(sum(r.ag),0)as"30"
       ,nvl(sum(r.ah),0)as"31"
       

 from
(
Select tbc_tpo_rg_fiscal
       ,tab_conteudo
       ,case  when to_char(dt_pagamento,'dd') = '01' then nvl(sum(valor),0)  end as a 
       ,case  when to_char(dt_pagamento,'dd') = '02' then nvl(sum(valor),0)  end as b 
       ,case  when to_char(dt_pagamento,'dd') = '03' then nvl(sum(valor),0)  end as c 
       ,case  when to_char(dt_pagamento,'dd') = '04' then nvl(sum(valor),0)  end as d 
       ,case  when to_char(dt_pagamento,'dd') = '05' then nvl(sum(valor),0)  end as e 
       ,case  when to_char(dt_pagamento,'dd') = '06' then nvl(sum(valor),0)  end as f
       ,case  when to_char(dt_pagamento,'dd') = '07' then nvl(sum(valor),0)  end as g
       ,case  when to_char(dt_pagamento,'dd') = '08' then nvl(sum(valor),0)  end as h
       ,case  when to_char(dt_pagamento,'dd') = '09' then nvl(sum(valor),0)  end as i
       ,case  when to_char(dt_pagamento,'dd') = '10' then nvl(sum(valor),0)  end as j
       ,case  when to_char(dt_pagamento,'dd') = '11' then nvl(sum(valor),0)  end as l
       ,case  when to_char(dt_pagamento,'dd') = '12' then nvl(sum(valor),0)  end as m
       ,case  when to_char(dt_pagamento,'dd') = '13' then nvl(sum(valor),0)  end as n
       ,case  when to_char(dt_pagamento,'dd') = '14' then nvl(sum(valor),0)  end as o
       ,case  when to_char(dt_pagamento,'dd') = '15' then nvl(sum(valor),0)  end as p
       ,case  when to_char(dt_pagamento,'dd') = '16' then nvl(sum(valor),0)  end as q
       ,case  when to_char(dt_pagamento,'dd') = '17' then nvl(sum(valor),0)  end as r
       ,case  when to_char(dt_pagamento,'dd') = '18' then nvl(sum(valor),0)  end as s 
       ,case  when to_char(dt_pagamento,'dd') = '19' then nvl(sum(valor),0)  end as t
       ,case  when to_char(dt_pagamento,'dd') = '20' then nvl(sum(valor),0)  end as u
       ,case  when to_char(dt_pagamento,'dd') = '21' then nvl(sum(valor),0)  end as v
       ,case  when to_char(dt_pagamento,'dd') = '22' then nvl(sum(valor),0)  end as x
       ,case  when to_char(dt_pagamento,'dd') = '23' then nvl(sum(valor),0)  end as z
       ,case  when to_char(dt_pagamento,'dd') = '24' then nvl(sum(valor),0)  end as aa
       ,case  when to_char(dt_pagamento,'dd') = '25' then nvl(sum(valor),0)  end as ab
       ,case  when to_char(dt_pagamento,'dd') = '26' then nvl(sum(valor),0)  end as ac
       ,case  when to_char(dt_pagamento,'dd') = '27' then nvl(sum(valor),0)  end as ad
       ,case  when to_char(dt_pagamento,'dd') = '28' then nvl(sum(valor),0)  end as ae
       ,case  when to_char(dt_pagamento,'dd') = '29' then nvl(sum(valor),0)  end as af
       ,case  when to_char(dt_pagamento,'dd') = '30' then nvl(sum(valor),0)  end as ag
       ,case  when to_char(dt_pagamento,'dd') = '31' then nvl(sum(valor),0)  end as ah 
 
 from 

(
select to_date( to_char(to_date(cpm_dtpg,'dd/mm/yy'),'yy/mm/dd')) as Dt_Pagamento 
       ,ag.tbc_tpo_rg_fiscal
       ,ag.tab_conteudo
       ,(cpd_vlr_pago_cheque + cpd_vlr_pago_dinhei)as valor
        
  from ag1pagcp,
  ( select tbc_tpo_rg_fiscal 
       ,agp.tab_conteudo
       ,tbc_agenda
         
    from aa1ctcon ,
    (  
    select to_number(tab_acesso)as agrup
          ,tab_conteudo
     from aa2ctabe 
       where tab_codigo = 14 and tab_conteudo like'AGRUP%'
       order by 1)agp
     where tbc_agenda > 0 
       and tbc_codigo = 0
       and tbc_intg_3 = 'E' 
       and tbc_intg_1 = 'S'
       and tbc_tpo_rg_fiscal = agp.agrup 
    /*order by 1,2*/)ag
     where cpm_dtpg between to_char(to_char(to_date('&Dt_Inicial','dd/mm/yyyy'),'yymmdd')) and to_char(to_char(to_date('&Dt_Final','dd/mm/yyyy'),'yymmdd'))
     and cpd_agenda = ag.tbc_agenda 
  
Union all
select rms7to_date(fis_dta_agenda) as Dt_Pagamento
       --,to_number('0')
       ,ag.tbc_tpo_rg_fiscal as Cod_Agrupamento
       ,ag.dsc as Desc_Agrupamento
       ,fis_val_cont_inf as Valor
       
  from aa1cfisc,
     (  select tbc_tpo_rg_fiscal 
         ,agp.tab_conteudo as dsc
         ,tbc_agenda
         
    from aa1ctcon ,(
    select to_number(tab_acesso)as agrup
          ,tab_conteudo
     from aa2ctabe 
       where tab_acesso <> '          ' and tab_codigo = 14 and tab_conteudo like'AGRUP%'
       /*order by 1*/)agp
     where tbc_agenda in (122,123,140,141,142,143) 
       and tbc_codigo = 0
       and tbc_tpo_rg_fiscal = agp.agrup
    /*order by 1,2*/)ag
 where to_number(substr(fis_oper,1)) = ag.tbc_agenda
       and fis_dta_agenda between
       to_char('1' ||
               to_char(to_date('&Dt_Inicial', 'dd/mm/yyyy'), 'yymmdd')) and
       to_char('1' ||
               to_char(to_date('&Dt_Final', 'dd/mm/yyyy'), 'yymmdd'))
Union all
select rms7to_date(fis_dta_agenda) as Dt_Pagamento
       --,to_number('0')
       ,ag.tbc_tpo_rg_fiscal as Cod_Agrupamento
       ,ag.dsc as Desc_Agrupamento
       ,fis_val_cont_inf as Valor
       
  from aa1cfisc,
     (  select tbc_tpo_rg_fiscal 
         ,agp.tab_conteudo as dsc
         ,tbc_agenda
         
    from aa1ctcon ,(
    select to_number(tab_acesso)as agrup
          ,tab_conteudo
     from aa2ctabe 
       where tab_acesso <> '          ' and tab_codigo = 14 and tab_conteudo like'AGRUP%'  
       order by 1)agp
     where tbc_agenda in (225,371,382,383,385,386,387,388,444,449,450,451,452,457,460,461,463,464,469,480,481,508,852,853,855,898) 
       and tbc_codigo = 0
       and tbc_tpo_rg_fiscal = agp.agrup
    order by 1,2)ag
 where to_number(substr(fis_oper,1)) = ag.tbc_agenda
       and fis_dta_agenda between
       to_char('1' ||
               to_char(to_date('&Dt_Inicial', 'dd/mm/yyyy'), 'yymmdd')) and
       to_char('1' ||
               to_char(to_date('&Dt_Final', 'dd/mm/yyyy'), 'yymmdd'))
Union all
select  rms7to_date(dup_dt_pag) as Dt_Pagamento 
       ,ag.tbc_tpo_rg_fiscal as Cod_Agrupamento
       ,ag.tab_conteudo as Desc_Agrupamento
       ,dup_valor_pag as Valor
       
  from aa1rtitu,
  (  select tbc_tpo_rg_fiscal --,aa1ctcon.*
         ,agp.tab_conteudo
         ,tbc_agenda
       
    from aa1ctcon ,(
    select to_number(tab_acesso)as agrup
          ,tab_conteudo
     from aa2ctabe 
       where tab_codigo = 14 and tab_conteudo like'AGRUP%'
       order by 1)agp
     where tbc_agenda > 0 
       and tbc_codigo = 0
       and tbc_intg_5 = 'S' 
       and tbc_intg_3 = 'S' 
       and tbc_tpo_rg_fiscal = agp.agrup
    /*order by 1,2*/)ag
     where to_number(dup_dt_pag) between to_char('1'||to_char(to_date('&Dt_Inicial','dd/mm/yyyy'),'yymmdd')) and to_char('1'||to_char(to_date('&Dt_Final','dd/mm/yyyy'),'yymmdd'))
     and dup_agenda = ag.tbc_agenda
     and dup_dt_pag  > 0 
    
 )    
  group by dt_pagamento ,tbc_tpo_rg_fiscal
       ,tab_conteudo
       ,valor
  --order by 1
 )r
  having tbc_tpo_rg_fiscal  not in (609,611,615,728)
  group by tbc_tpo_rg_fiscal
       ,tab_conteudo
  order by 1 
