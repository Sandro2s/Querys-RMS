select rdv.dt_mvto
       ,rdv.cd_ent_estq
       ,rdv.cd_fil_origem
       ,rdv.cd_prod||dac(rdv.cd_prod) as cod
       ,rdv.cd_fornec_fat
       ,rdv.cd_ord_col
  from ag3ttrdv rdv
 where rdv.dt_mvto = '1'||to_number(to_char(to_date('29/09/10','dd/mm/yy'),'yymmdd'))
   and rdv.cd_ent_estq = 4
   and rdv.cd_fil_origem = 100 
   and rdv.cd_fornec_fat = 3560
   and rdv.sts_atu in (1,100)
   and rdv.cd_ord_col = 58068
   for update
   
  select rdv.dt_mvto
       ,rdv.cd_ent_estq
       ,rdv.cd_fil_origem
       ,rdv.cd_prod||dac(rdv.cd_prod) as cod
       ,rdv.cd_fornec_fat
  from ag3ttrdv rdv
 where rdv.cd_ent_estq = 4
   and rdv.cd_fil_origem = 100 
   and rdv.cd_fornec_fat = 100
   and rdv.sts_atu = 200