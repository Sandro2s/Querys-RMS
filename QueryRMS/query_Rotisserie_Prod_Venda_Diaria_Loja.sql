-- Empresa : Supermercado São Roque Ltda.
-- Data :16/01/2018 
-- Atualizado em : 
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Solange Pinheiro
-- Descrição : Movimento diario da Rotisserie dos produtos indicado.Traz o produto vendido e entrada por produção
--             da loja.




Select loja,codigo, descricao
       ,nvl(sum(v1),0) as "1_Venda" ,nvl(sum(p1),0) as "1_Producao"
       ,nvl(sum(v2),0) as "2_Venda" ,nvl(sum(p2),0) as "2_Producao"
       ,nvl(sum(v3),0) as "3_Venda" ,nvl(sum(p3),0) as "3_Producao"
       ,nvl(sum(v4),0) as "4_Venda" ,nvl(sum(p4),0) as "4_Producao"
       ,nvl(sum(v5),0) as "5_Venda" ,nvl(sum(p5),0) as "5_Producao"
       ,nvl(sum(v6),0) as "6_Venda" ,nvl(sum(p6),0) as "6_Producao"
       ,nvl(sum(v7),0) as "7_Venda" ,nvl(sum(p7),0) as "7_Producao"
       ,nvl(sum(v8),0) as "8_Venda" ,nvl(sum(p8),0) as "8_Producao"
       ,nvl(sum(v9),0) as "9_Venda" ,nvl(sum(p9),0) as "9_Producao"
       ,nvl(sum(v10),0) as "10_Venda" ,nvl(sum(p10),0) as "10_Producao"
       ,nvl(sum(v11),0) as "11_Venda" ,nvl(sum(p11),0) as "11_Producao"
       ,nvl(sum(v12),0) as "12_Venda" ,nvl(sum(p12),0) as "12_Producao"
       ,nvl(sum(v13),0) as "13_Venda" ,nvl(sum(p13),0) as "13_Producao"
       ,nvl(sum(v14),0) as "14_Venda" ,nvl(sum(p14),0) as "14_Producao"
       ,nvl(sum(v15),0) as "15_Venda" ,nvl(sum(p15),0) as "15_Producao"
       ,nvl(sum(v16),0) as "16_Venda" ,nvl(sum(p16),0) as "16_Producao"
       ,nvl(sum(v17),0) as "17_Venda" ,nvl(sum(p17),0) as "17_Producao"
       ,nvl(sum(v18),0) as "18_Venda" ,nvl(sum(p18),0) as "18_Producao"
       ,nvl(sum(v19),0) as "19_Venda" ,nvl(sum(p19),0) as "19_Producao"
       ,nvl(sum(v20),0) as "20_Venda" ,nvl(sum(p20),0) as "20_Producao"
       ,nvl(sum(v21),0) as "21_Venda" ,nvl(sum(p21),0) as "21_Producao"
       ,nvl(sum(v22),0) as "22_Venda" ,nvl(sum(p22),0) as "22_Producao"
       ,nvl(sum(v23),0) as "23_Venda" ,nvl(sum(p23),0) as "23_Producao"
       ,nvl(sum(v24),0) as "24_Venda" ,nvl(sum(p24),0) as "24_Producao"
       ,nvl(sum(v25),0) as "25_Venda" ,nvl(sum(p25),0) as "25_Producao"
       ,nvl(sum(v26),0) as "26_Venda" ,nvl(sum(p26),0) as "26_Producao"
       ,nvl(sum(v27),0) as "27_Venda" ,nvl(sum(p27),0) as "27_Producao"
       ,nvl(sum(v28),0) as "28_Venda" ,nvl(sum(p28),0) as "28_Producao"
       ,nvl(sum(v29),0) as "29_Venda" ,nvl(sum(p29),0) as "29_Producao"
       ,nvl(sum(v30),0) as "30_Venda" ,nvl(sum(p30),0) as "30_Producao"
       ,nvl(sum(v31),0) as "31_Venda" ,nvl(sum(p31),0) as "31_Producao"



 from

(
Select r.loja, r.codigo, r.descricao
       ,case when agenda = 53   then A end as  v1  ,case when agenda = 916  then A end as  p1
       ,case when agenda = 53   then B end as  v2  ,case when agenda = 916  then B end as  p2
       ,case when agenda = 53   then C end as  v3  ,case when agenda = 916  then C end as  p3
       ,case when agenda = 53   then D end as  v4  ,case when agenda = 916  then D end as  p4
       ,case when agenda = 53   then E end as  v5  ,case when agenda = 916  then E end as  p5
       ,case when agenda = 53   then F end as  v6  ,case when agenda = 916  then F end as  p6
       ,case when agenda = 53   then G end as  v7  ,case when agenda = 916  then G end as  p7
       ,case when agenda = 53   then H end as  v8  ,case when agenda = 916  then H end as  p8
       ,case when agenda = 53   then I end as  v9  ,case when agenda = 916  then I end as  p9
       ,case when agenda = 53   then J end as  v10 ,case when agenda = 916  then J end as  p10
       ,case when agenda = 53   then L end as  v11 ,case when agenda = 916  then L end as  p11
       ,case when agenda = 53   then M end as  v12 ,case when agenda = 916  then M end as  p12
       ,case when agenda = 53   then N end as  v13 ,case when agenda = 916  then N end as  p13
       ,case when agenda = 53   then O end as  v14 ,case when agenda = 916  then O end as  p14
       ,case when agenda = 53   then P end as  v15 ,case when agenda = 916  then P end as  p15
       ,case when agenda = 53   then Q end as  v16 ,case when agenda = 916  then Q end as  p16
       ,case when agenda = 53   then R end as  v17 ,case when agenda = 916  then R end as  p17
       ,case when agenda = 53   then S end as  v18 ,case when agenda = 916  then S end as  p18
       ,case when agenda = 53   then T end as  v19 ,case when agenda = 916  then T end as  p19
       ,case when agenda = 53   then U end as  v20 ,case when agenda = 916  then U end as  p20
       ,case when agenda = 53   then V end as  v21 ,case when agenda = 916  then V end as  p21
       ,case when agenda = 53   then X end as  v22 ,case when agenda = 916  then X end as  p22
       ,case when agenda = 53   then Z end as  v23 ,case when agenda = 916  then Z end as  p23
       ,case when agenda = 53   then AA end as v24 ,case when agenda = 916  then AA end as  p24
       ,case when agenda = 53   then AB end as v25 ,case when agenda = 916  then AB end as  p25
       ,case when agenda = 53   then AC end as v26 ,case when agenda = 916  then AC end as  p26
       ,case when agenda = 53   then AD end as v27 ,case when agenda = 916  then AD end as  p27
       ,case when agenda = 53   then AE end as v28 ,case when agenda = 916  then AE end as  p28
       ,case when agenda = 53   then AF end as v29 ,case when agenda = 916  then AF end as  p29
       ,case when agenda = 53   then AG end as v30 ,case when agenda = 916  then AG end as  p30
       ,case when agenda = 53   then AH end as v31 ,case when agenda = 916  then AH end as  p31
        
        from 
(
select 

       to_number(ag.eschljc_codigo || ag.eschljc_digito, '9999') as Loja,
       to_char(ag.esitc_codigo ||'-'|| ag.esitc_digito) as Codigo,
       aa.descricao as Descricao
       ,ag.eschc_agenda as agenda
       ,case when to_char (substr(ag.eschc_data,6)) = '01' then sum(ag.entsaic_quanti_un)  end as A 
       ,case when to_char (substr(ag.eschc_data,6)) = '02' then sum(ag.entsaic_quanti_un)  end as B
       ,case when to_char (substr(ag.eschc_data,6)) = '03' then sum(ag.entsaic_quanti_un)  end as C
       ,case when to_char (substr(ag.eschc_data,6)) = '04' then sum(ag.entsaic_quanti_un)  end as D
       ,case when to_char (substr(ag.eschc_data,6)) = '05' then sum(ag.entsaic_quanti_un)  end as E
       ,case when to_char (substr(ag.eschc_data,6)) = '06' then sum(ag.entsaic_quanti_un)  end as F
       ,case when to_char (substr(ag.eschc_data,6)) = '07' then sum(ag.entsaic_quanti_un)  end as G
       ,case when to_char (substr(ag.eschc_data,6)) = '08' then sum(ag.entsaic_quanti_un)  end as H
       ,case when to_char (substr(ag.eschc_data,6)) = '09' then sum(ag.entsaic_quanti_un)  end as I
       ,case when to_char (substr(ag.eschc_data,6)) = '10' then sum(ag.entsaic_quanti_un)  end as J
       ,case when to_char (substr(ag.eschc_data,6)) = '11' then sum(ag.entsaic_quanti_un)  end as L
       ,case when to_char (substr(ag.eschc_data,6)) = '12' then sum(ag.entsaic_quanti_un)  end as M
       ,case when to_char (substr(ag.eschc_data,6)) = '13' then sum(ag.entsaic_quanti_un)  end as N
       ,case when to_char (substr(ag.eschc_data,6)) = '14' then sum(ag.entsaic_quanti_un)  end as O
       ,case when to_char (substr(ag.eschc_data,6)) = '15' then sum(ag.entsaic_quanti_un)  end as P
       ,case when to_char (substr(ag.eschc_data,6)) = '16' then sum(ag.entsaic_quanti_un)  end as Q
       ,case when to_char (substr(ag.eschc_data,6)) = '17' then sum(ag.entsaic_quanti_un)  end as R
       ,case when to_char (substr(ag.eschc_data,6)) = '18' then sum(ag.entsaic_quanti_un)  end as S
       ,case when to_char (substr(ag.eschc_data,6)) = '19' then sum(ag.entsaic_quanti_un)  end as T
       ,case when to_char (substr(ag.eschc_data,6)) = '20' then sum(ag.entsaic_quanti_un)  end as U
       ,case when to_char (substr(ag.eschc_data,6)) = '21' then sum(ag.entsaic_quanti_un)  end as V
       ,case when to_char (substr(ag.eschc_data,6)) = '22' then sum(ag.entsaic_quanti_un)  end as X
       ,case when to_char (substr(ag.eschc_data,6)) = '23' then sum(ag.entsaic_quanti_un)  end as Z
       ,case when to_char (substr(ag.eschc_data,6)) = '24' then sum(ag.entsaic_quanti_un)  end as AA
       ,case when to_char (substr(ag.eschc_data,6)) = '25' then sum(ag.entsaic_quanti_un)  end as AB
       ,case when to_char (substr(ag.eschc_data,6)) = '26' then sum(ag.entsaic_quanti_un)  end as AC
       ,case when to_char (substr(ag.eschc_data,6)) = '27' then sum(ag.entsaic_quanti_un)  end as AD
       ,case when to_char (substr(ag.eschc_data,6)) = '28' then sum(ag.entsaic_quanti_un)  end as AE
       ,case when to_char (substr(ag.eschc_data,6)) = '29' then sum(ag.entsaic_quanti_un)  end as AF
       ,case when to_char (substr(ag.eschc_data,6)) = '30' then sum(ag.entsaic_quanti_un)  end as AG
       ,case when to_char (substr(ag.eschc_data,6)) = '31' then sum(ag.entsaic_quanti_un)  end as AH
   
  from ag1iensa ag inner join
  (select git_cod_item||git_digito as cod,
        git_descricao as descricao
  from aa3citem  
     where git_secao = 303 
       -- and git_grupo = 8
   )aa
   on ag.esitc_codigo1 || ag.esitc_digito1 = aa.cod 
  
 where ag.eschc_data between 1||to_char(to_date('&Dta_Inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd')--&Dta_Ini and &Dta_Fin --1100501 and 1100531
   and ag.eschc_agenda = 53
  
   and ag.eschljc_codigo in (select tip_codigo from aa2ctipo,aa2cloja where tip_codigo = loj_codigo and tip_loj_cli = 'L'and tip_natureza = 'LS'and loj_data_fecha = 0)
      
       
  group by  ag.eschljc_codigo, ag.eschljc_digito,
            ag.esitc_codigo, ag.esitc_digito,
            aa.descricao,
            ag.eschc_agenda,
            ag.eschc_data 
      

Union all
select to_number(ag.esclc_codigo || ag.esclc_digito, '9999') as Loja,
       to_char(ag.esitc_codigo ||'-'|| ag.esitc_digito) as Codigo,
       aa.descricao as Descricao
       ,ag.eschc_agenda as agenda
       ,case when to_char (substr(ag.eschc_data,6)) = '01' then sum(ag.entsaic_quanti_un)  end as A
       ,case when to_char (substr(ag.eschc_data,6)) = '02' then sum(ag.entsaic_quanti_un)  end as B
       ,case when to_char (substr(ag.eschc_data,6)) = '03' then sum(ag.entsaic_quanti_un)  end as C
       ,case when to_char (substr(ag.eschc_data,6)) = '04' then sum(ag.entsaic_quanti_un)  end as D
       ,case when to_char (substr(ag.eschc_data,6)) = '05' then sum(ag.entsaic_quanti_un)  end as E
       ,case when to_char (substr(ag.eschc_data,6)) = '06' then sum(ag.entsaic_quanti_un)  end as F
       ,case when to_char (substr(ag.eschc_data,6)) = '07' then sum(ag.entsaic_quanti_un)  end as G
       ,case when to_char (substr(ag.eschc_data,6)) = '08' then sum(ag.entsaic_quanti_un)  end as H
       ,case when to_char (substr(ag.eschc_data,6)) = '09' then sum(ag.entsaic_quanti_un)  end as I
       ,case when to_char (substr(ag.eschc_data,6)) = '10' then sum(ag.entsaic_quanti_un)  end as J
       ,case when to_char (substr(ag.eschc_data,6)) = '11' then sum(ag.entsaic_quanti_un)  end as L
       ,case when to_char (substr(ag.eschc_data,6)) = '12' then sum(ag.entsaic_quanti_un)  end as M
       ,case when to_char (substr(ag.eschc_data,6)) = '13' then sum(ag.entsaic_quanti_un)  end as N
       ,case when to_char (substr(ag.eschc_data,6)) = '14' then sum(ag.entsaic_quanti_un)  end as O
       ,case when to_char (substr(ag.eschc_data,6)) = '15' then sum(ag.entsaic_quanti_un)  end as P
       ,case when to_char (substr(ag.eschc_data,6)) = '16' then sum(ag.entsaic_quanti_un)  end as Q
       ,case when to_char (substr(ag.eschc_data,6)) = '17' then sum(ag.entsaic_quanti_un)  end as R
       ,case when to_char (substr(ag.eschc_data,6)) = '18' then sum(ag.entsaic_quanti_un)  end as S
       ,case when to_char (substr(ag.eschc_data,6)) = '19' then sum(ag.entsaic_quanti_un)  end as T
       ,case when to_char (substr(ag.eschc_data,6)) = '20' then sum(ag.entsaic_quanti_un)  end as U
       ,case when to_char (substr(ag.eschc_data,6)) = '21' then sum(ag.entsaic_quanti_un)  end as V
       ,case when to_char (substr(ag.eschc_data,6)) = '22' then sum(ag.entsaic_quanti_un)  end as X
       ,case when to_char (substr(ag.eschc_data,6)) = '23' then sum(ag.entsaic_quanti_un)  end as Z
       ,case when to_char (substr(ag.eschc_data,6)) = '24' then sum(ag.entsaic_quanti_un)  end as AA
       ,case when to_char (substr(ag.eschc_data,6)) = '25' then sum(ag.entsaic_quanti_un)  end as AB
       ,case when to_char (substr(ag.eschc_data,6)) = '26' then sum(ag.entsaic_quanti_un)  end as AC
       ,case when to_char (substr(ag.eschc_data,6)) = '27' then sum(ag.entsaic_quanti_un)  end as AD
       ,case when to_char (substr(ag.eschc_data,6)) = '28' then sum(ag.entsaic_quanti_un)  end as AE
       ,case when to_char (substr(ag.eschc_data,6)) = '29' then sum(ag.entsaic_quanti_un)  end as AF
       ,case when to_char (substr(ag.eschc_data,6)) = '30' then sum(ag.entsaic_quanti_un)  end as AG
       ,case when to_char (substr(ag.eschc_data,6)) = '31' then sum(ag.entsaic_quanti_un)  end as AH
   
  from ag1iensa ag inner join
  (select git_cod_item||git_digito as cod,
        git_descricao as descricao
  from aa3citem  
     where git_secao = 303 
      -- and git_grupo = 8
   )aa
   on ag.esitc_codigo1 || ag.esitc_digito1 = aa.cod 
  
 where ag.eschc_data between 1||to_char(to_date('&Dta_Inicial','dd/mm/yyyy'),'yymmdd') and 1||to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd')--&Dta_Ini and &Dta_Fin --1100501 and 1100531
   and ag.eschc_agenda in (916,2)
  
   and ag.esclc_codigo in (select tip_codigo from aa2ctipo,aa2cloja where tip_codigo = loj_codigo and tip_loj_cli = 'L'and tip_natureza = 'LS'and loj_data_fecha = 0)
       
       
      
 group by  ag.esclc_codigo, ag.esclc_digito,
           ag.esitc_codigo, ag.esitc_digito,
            aa.descricao,
            ag.eschc_agenda,
            ag.eschc_data 
)r
 )
 
 group by loja,codigo, descricao
order by 1,2
