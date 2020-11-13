select to_number(eschljc_codigo3 || eschljc_digito3) as Loja,
       to_number(esitc_codigo || esitc_digito) as codigo,
       git_descricao as Descricao,
       --,eschc_nro_nota3 as NF
       round(sum(entsaic_quanti_un), 3) as Qtd,
       round(sum(entsaic_quanti_un * entsaic_prc_un), 2) as valor
   -- ,entsaic_situacao
  from ag1iensa, aa3citem
 where eschc_data between to_number(1||(to_char(to_date('&Dta_Inicial','dd/mm/yyyy'),'yymmdd'))) and To_number(1||(to_char(to_date('&Dta_Final','dd/mm/yyyy'),'yymmdd'))) 
   and esitc_codigo = git_cod_item
   and eschc_agenda = 21
   and eschc_secao3 = git_secao
   and eschljc_codigo3 in(1,2,3,4,5,7,8,9,10,11,12,14,15,18,19,20,21)
   and entsaic_situacao = ' '
 group by eschljc_codigo3,
          eschljc_digito3,
          entsaic_situacao,
          esitc_codigo,
          esitc_digito,
          git_descricao
  order by loja,descricao
------------------------






/*       select mov.loja as Loja
              ,sum(mov.a) as Janeiro
              ,sum(mov.b) as Fevereiro
              ,sum(mov.c) as Março
              ,sum(mov.d) as Abril
              ,sum(mov.e) as Maio
              ,sum(mov.f) as Junho
              ,sum(mov.g) as Julho
              ,sum(mov.h) as Agosto
              ,sum(mov.i) as Setembro
              ,sum(mov.j) as Outubro
              ,sum(mov.l) as Novembro
              ,sum(mov.m) as Dezembro
       
                from  
         
         (
          Select  Loja
                 ,case mes when '01' then nvl(sum(valor),0) end A  
                 ,case mes when '02' then nvl(sum(valor),0) end B 
                 ,case mes when '03' then nvl(sum(valor),0) end C
                 ,case mes when '04' then nvl(sum(valor),0) end D
                 ,case mes when '05' then nvl(sum(valor),0) end E
                 ,case mes when '06' then nvl(sum(valor),0) end F
                 ,case mes when '07' then nvl(sum(valor),0) end G
                 ,case mes when '08' then nvl(sum(valor),0) end H
                 ,case mes when '09' then nvl(sum(valor),0) end I
                 ,case mes when '10' then nvl(sum(valor),0) end J
                 ,case mes when '11' then nvl(sum(valor),0) end L
                 ,case mes when '12' then nvl(sum(valor),0) end M
                 from  
              (  
                Select to_number(LJ) as Loja
                       ,MES
                       ,sum(Vl) as Valor
                       
                       from 
                          (
                          select  fis_loj_org||fis_dig_org as LJ
                                 ,to_char(rms7to_date(fis_dta_agenda),'MM') as Mes
                                 ,sum(fis_val_cont_ff_1+fis_val_cont_ff_2+fis_val_cont_ff_3+fis_val_cont_ff_4+fis_val_cont_ff_5)as vl
                          
                            from aa1cfisc
                           where FIS_DTA_AGENDA between 1120101 and 1120531
                             and fis_oper = 21
                             and fis_situacao <> '9'
                             group by fis_loj_org,fis_dig_org,fis_oper,fis_dta_agenda,fis_nro_nota,fis_situacao
                          )  group by LJ,Mes
             order by loja,Mes) 
                 group by Loja,mes )mov
                 group by Loja*/