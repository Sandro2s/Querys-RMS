-- Empresa : Supermercado São Roque Ltda.
-- Data :09/10/2010 
-- Atualizado em : 30/10/2010
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Solange Pinheiro
-- Descrição : Retorna de venda de uma seção com embalagem de compra
                     
select  r.filial
       ,r.descricao
       ,r.codigo
       ,r.grupo
       ,r.emb
       ,nvl(sum(r.a),0)  as "01",nvl(sum(r.b),0) as "02",nvl(sum(r.c),0)  as "03",nvl(sum(r.d),0)  as "04",nvl(sum(r.e),0)  as "05",nvl(sum(r.f),0)  as "06",nvl(sum(r.g),0)  as "07",nvl(sum(r.h),0) as "08",nvl(sum(r.i),0)  as "09",nvl(sum(r.j),0) as "10"
       ,nvl(sum(r.l),0)  as "11",nvl(sum(r.m),0) as "12",nvl(sum(r.n),0)  as "13",nvl(sum(r.p),0)  as "14",nvl(sum(r.q),0)  as "15",nvl(sum(r.r),0)  as "16",nvl(sum(r.s),0)  as "17",nvl(sum(r.t),0) as "18",nvl(sum(r.u),0)  as "19",nvl(sum(r.v),0) as "20"
       ,nvl(sum(r.x),0)  as "21",nvl(sum(r.z),0) as "22",nvl(sum(r.aa),0) as "23",nvl(sum(r.ab),0) as "24",nvl(sum(r.ac),0) as "25",nvl(sum(r.ad),0) as "26",nvl(sum(r.ae),0) as "27",nvl(sum(r.af),0) as "28",nvl(sum(r.ag),0) as "29",nvl(sum(r.ah),0) as "30"
       ,nvl(sum(r.ai),0) as "31"
from

(
Select 
             
     to_number(cd_fil||dac(cd_fil)) as Filial                
     ,git_descricao as descricao
     ,to_number(cd_prod||dac(cd_prod)) as Codigo              
     ,ncc_descricao as Grupo
     ,git_emb_for||git_tpo_emb_for as Emb
     
     ,case  when to_char(dt_compl,'dd') = '01' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as A 
     ,case  when to_char(dt_compl,'dd') = '02' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as B
     ,case  when to_char(dt_compl,'dd') = '03' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as C
     ,case  when to_char(dt_compl,'dd') = '04' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as D
     ,case  when to_char(dt_compl,'dd') = '05' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as E
     ,case  when to_char(dt_compl,'dd') = '06' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as F
     ,case  when to_char(dt_compl,'dd') = '07' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as G
     ,case  when to_char(dt_compl,'dd') = '08' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as H
     ,case  when to_char(dt_compl,'dd') = '09' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as I
     ,case  when to_char(dt_compl,'dd') = '10' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as J
     ,case  when to_char(dt_compl,'dd') = '11' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as L
     ,case  when to_char(dt_compl,'dd') = '12' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as M
     ,case  when to_char(dt_compl,'dd') = '13' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as N
     ,case  when to_char(dt_compl,'dd') = '14' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as P
     ,case  when to_char(dt_compl,'dd') = '15' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as Q
     ,case  when to_char(dt_compl,'dd') = '16' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as R
     ,case  when to_char(dt_compl,'dd') = '17' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as S
     ,case  when to_char(dt_compl,'dd') = '18' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as T
     ,case  when to_char(dt_compl,'dd') = '19' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as U
     ,case  when to_char(dt_compl,'dd') = '20' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as V
     ,case  when to_char(dt_compl,'dd') = '21' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as X
     ,case  when to_char(dt_compl,'dd') = '22' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as Z
     ,case  when to_char(dt_compl,'dd') = '23' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as AA
     ,case  when to_char(dt_compl,'dd') = '24' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as AB
     ,case  when to_char(dt_compl,'dd') = '25' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as AC
     ,case  when to_char(dt_compl,'dd') = '26' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as AD
     ,case  when to_char(dt_compl,'dd') = '27' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as AE
     ,case  when to_char(dt_compl,'dd') = '28' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as AF
     ,case  when to_char(dt_compl,'dd') = '29' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as AG
     ,case  when to_char(dt_compl,'dd') = '30' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as AH
     ,case  when to_char(dt_compl,'dd') = '31' then to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))end as AI
     
     
  from agg_vda_prod,
  (select id_dt as dt,dt_compl from dim_per dim where dt_compl between to_date('&Dta_Inicial','dd/mm/yyyy') and to_date('&Dta_Final','dd/mm/yyyy')),
  (select git_cod_item ,git_digito,git_descricao,git_grupo,git_emb_for,git_tpo_emb_for from aa3citem item where git_secao = '&SECAO')aa,
  (select ncc_secao,ncc_grupo,ncc_descricao from aa3cnvcc where ncc_secao = 300 and ncc_grupo > 0 and ncc_subgrupo = 0 and ncc_categoria = 0)gg
    where id_dt = dt
   and cd_prod = aa.git_cod_item 
   and git_grupo = gg.ncc_grupo
   order by filial, dt_compl,descricao )r
   group by r.filial,r.descricao,r.codigo,r.grupo,r.emb
   order by filial,descricao ;                   
                          
-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Transferencia Loja. Todas as movimentações por transf(agenda 43) ou venda (agenda 74)saida do CD para loja.
Select  r.filial
       ,r.descricao
       ,r.codigo
       ,r.grupo
       ,r.emb 
       ,nvl(sum(r.a),0)  as "01",nvl(sum(r.b),0) as "02",nvl(sum(r.c),0)  as "03",nvl(sum(r.d),0)  as "04",nvl(sum(r.e),0)  as "05",nvl(sum(r.f),0)  as "06",nvl(sum(r.g),0)  as "07",nvl(sum(r.h),0) as "08",nvl(sum(r.i),0)  as "09",nvl(sum(r.j),0) as "10"
       ,nvl(sum(r.l),0)  as "11",nvl(sum(r.m),0) as "12",nvl(sum(r.n),0)  as "13",nvl(sum(r.p),0)  as "14",nvl(sum(r.q),0)  as "15",nvl(sum(r.r),0)  as "16",nvl(sum(r.s),0)  as "17",nvl(sum(r.t),0) as "18",nvl(sum(r.u),0)  as "19",nvl(sum(r.v),0) as "20"
       ,nvl(sum(r.x),0)  as "21",nvl(sum(r.z),0) as "22",nvl(sum(r.aa),0) as "23",nvl(sum(r.ab),0) as "24",nvl(sum(r.ac),0) as "25",nvl(sum(r.ad),0) as "26",nvl(sum(r.ae),0) as "27",nvl(sum(r.af),0) as "28",nvl(sum(r.ag),0) as "29",nvl(sum(r.ah),0) as "30"
       ,nvl(sum(r.ai),0) as "31" 

 from 

(
select 
       Lja as Filial,
       Descr as Descricao,
       Cod as Codigo,
       Grupo,
       entsaic_base_emb||entsaic_tpo_emb as Emb,
--     sum(Quant) as Quantidade
      case  when to_char(data,'dd') = '01' then to_number(Quant/ entsaic_base_emb) end as A 
     ,case  when to_char(data,'dd') = '02' then to_number(Quant/ entsaic_base_emb)end as B
     ,case  when to_char(data,'dd') = '03' then to_number(Quant/ entsaic_base_emb)end as C
     ,case  when to_char(data,'dd') = '04' then to_number(Quant/ entsaic_base_emb)end as D
     ,case  when to_char(data,'dd') = '05' then to_number(Quant/ entsaic_base_emb)end as E
     ,case  when to_char(data,'dd') = '06' then to_number(Quant/ entsaic_base_emb)end as F
     ,case  when to_char(data,'dd') = '07' then to_number(Quant/ entsaic_base_emb)end as G
     ,case  when to_char(data,'dd') = '08' then to_number(Quant/ entsaic_base_emb)end as H
     ,case  when to_char(data,'dd') = '09' then to_number(Quant/ entsaic_base_emb)end as I
     ,case  when to_char(data,'dd') = '10' then to_number(Quant/ entsaic_base_emb)end as J
     ,case  when to_char(data,'dd') = '11' then to_number(Quant/ entsaic_base_emb)end as L
     ,case  when to_char(data,'dd') = '12' then to_number(Quant/ entsaic_base_emb)end as M
     ,case  when to_char(data,'dd') = '13' then to_number(Quant/ entsaic_base_emb)end as N
     ,case  when to_char(data,'dd') = '14' then to_number(Quant/ entsaic_base_emb)end as P
     ,case  when to_char(data,'dd') = '15' then to_number(Quant/ entsaic_base_emb)end as Q
     ,case  when to_char(data,'dd') = '16' then to_number(Quant/ entsaic_base_emb)end as R
     ,case  when to_char(data,'dd') = '17' then to_number(Quant/ entsaic_base_emb)end as S
     ,case  when to_char(data,'dd') = '18' then to_number(Quant/ entsaic_base_emb)end as T
     ,case  when to_char(data,'dd') = '19' then to_number(Quant/ entsaic_base_emb)end as U
     ,case  when to_char(data,'dd') = '20' then to_number(Quant/ entsaic_base_emb)end as V
     ,case  when to_char(data,'dd') = '21' then to_number(Quant/ entsaic_base_emb)end as X
     ,case  when to_char(data,'dd') = '22' then to_number(Quant/ entsaic_base_emb)end as Z
     ,case  when to_char(data,'dd') = '23' then to_number(Quant/ entsaic_base_emb)end as AA
     ,case  when to_char(data,'dd') = '24' then to_number(Quant/ entsaic_base_emb)end as AB
     ,case  when to_char(data,'dd') = '25' then to_number(Quant/ entsaic_base_emb)end as AC
     ,case  when to_char(data,'dd') = '26' then to_number(Quant/ entsaic_base_emb)end as AD
     ,case  when to_char(data,'dd') = '27' then to_number(Quant/ entsaic_base_emb)end as AE
     ,case  when to_char(data,'dd') = '28' then to_number(Quant/ entsaic_base_emb)end as AF
     ,case  when to_char(data,'dd') = '29' then to_number(Quant/ entsaic_base_emb)end as AG
     ,case  when to_char(data,'dd') = '30' then to_number(Quant/ entsaic_base_emb)end as AH
     ,case  when to_char(data,'dd') = '31' then to_number(Quant/ entsaic_base_emb)end as AI
    

  from (select rms7to_date(ag.eschc_data) as data,
               to_number(ag.esclc_codigo || ag.esclc_digito, '9999') as Lja,
               aa.git_descricao as Descr,
               to_number(ag.esitc_codigo || ag.esitc_digito, '9999999') as Cod,
               gg.ncc_descricao as Grupo,
               ag.entsaic_base_emb, 
               ag.entsaic_tpo_emb,
               ag.entsaic_quanti_un as Quant
           from ag1iensa ag, aa3citem aa,
           (select ncc_secao,ncc_grupo,ncc_descricao from aa3cnvcc where ncc_secao = '&secao' and ncc_grupo > 0 and ncc_subgrupo = 0 and ncc_categoria = 0)gg
         where ag.eschc_data between to_char('1'||to_char(to_date('&Dta_Inicial','dd/mm/yyyy'),'yymmdd')) and to_char('1'||to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd')) --1100501 and 1100531
           and ag.eschc_agenda in (43,74)
           and ag.esitc_codigo = aa.git_cod_item
           and ag.eschljc_codigo3 = 100 --in (1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 14, 15, 18, 19,20,21)
           and eschc_grupo3 = gg.ncc_grupo
         Group by ag.esclc_codigo || ag.esclc_digito,
                  ag.esitc_codigo || ag.esitc_digito,
                  aa.git_descricao,
                  ag.entsaic_quanti_un,
                  ag.entsaic_prc_emb,
                  ag.entsaic_base_emb,
                  ag.eschc_data,
                  ag.eschc_nro_nota,
                  gg.ncc_descricao,
                  ag.entsaic_tpo_emb)
 Group by Lja, Cod, Descr,data,grupo,quant,entsaic_base_emb ,entsaic_tpo_emb
 order by Lja, Cod
 )r
  Group by r.filial
           ,r.descricao
           ,r.codigo
           ,r.grupo
           ,r.emb
   Order by filial, descricao
/*Select 
      dt_compl               
     ,to_char(dt_compl,'DAY') as Dia
     ,to_number(cd_fil||dac(cd_fil)) as Filial                
     ,to_number(cd_prod||dac(cd_prod)) as Codigo              
     ,git_descricao as descricao
     ,ncc_descricao as Desc_Grupo
     ,qtd_vda 
     ,git_emb_for as Emb
     ,git_tpo_emb_for as Tipo
     ,to_number(to_char((qtd_vda / git_emb_for)*10000,'000,0000'))Venda_Emb    
     ,case
       when qtd_vda_oft > 0 then 'OFERTA'
       when qtd_vda_oft = 0 then To_char('0.00')
       end as oferta        
     
  from agg_vda_prod,
  (select id_dt as dt,dt_compl from dim_per dim where dt_compl between to_date('&Dta_Inicial','dd/mm/yyyy') and to_date('&Dta_Final','dd/mm/yyyy')),
  (select git_cod_item ,git_digito,git_descricao,git_grupo,git_emb_for,git_tpo_emb_for from aa3citem item where git_secao = '&SECAO')aa,
  (select ncc_secao,ncc_grupo,ncc_descricao from aa3cnvcc where ncc_secao = 300 and ncc_grupo > 0 and ncc_subgrupo = 0 and ncc_categoria = 0)gg
    where id_dt = dt
   and cd_prod = aa.git_cod_item 
   and git_grupo = gg.ncc_grupo
   order by filial, dt_compl,descricao */
          