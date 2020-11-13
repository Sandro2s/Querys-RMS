select fis.fis_nro_nota as NF,
      rms7to_date(fis.fis_dta_agenda) as Dta_Agenda,
       fis.fis_val_cont_ff_1 as Contabil,
       fis.fis_base_calc_1 as Base,
       fis.fis_isento_1 as Isento,
     sum(fis.fis_val_cont_ff_1-fis.fis_base_calc_1-fis.fis_isento_1 ) as outras,
       fis.fis_pvv_ff_1 as PVV,
       fis.fis_val_icm_fonte_ff_1 as Fonte

 from aa1cfisc fis 
    where fis.fis_dta_agenda between &dta_inicio and &dta_fim
    and fis.fis_cod_fiscal = &CFO
    and fis.fis_loj_dst = &Loja
    and fis.fis_situacao <> '9'
    and fis.fis_oper not in ('027','032','092','702','709','725','900','902','916','998')
    Group by fis.fis_nro_nota,fis.fis_dta_agenda,fis.fis_val_cont_ff_1,fis.fis_base_calc_1,
             fis.fis_isento_1,fis.fis_pvv_ff_1,fis.fis_val_icm_fonte_ff_1,fis.fis_oper

Union all
select fis.fis_nro_nota as NF,
      rms7to_date(fis.fis_dta_agenda) as Dta_Agenda,
       fis.fis_val_cont_ff_2 as Contabil,
       fis.fis_base_calc_2 as Base,
       fis.fis_isento_2 as Isento,
     sum(fis.fis_val_cont_ff_2-fis.fis_base_calc_2-fis.fis_isento_2 ) as outras,
       fis.fis_pvv_ff_2 as PVV,
       fis.fis_val_icm_fonte_ff_2 as Fonte

 from aa1cfisc fis 
    where fis.fis_dta_agenda between &dta_inicio and &dta_fim
    and fis.fis_cod_fiscal = &CFO
    and fis.fis_loj_dst = &Loja
    and fis.fis_situacao <> '9'
    and fis.fis_oper not in ('027','032','092','702','709','725','900','902','916','998')
    Group by fis.fis_nro_nota,fis.fis_dta_agenda,fis.fis_val_cont_ff_2,fis.fis_base_calc_2,
             fis.fis_isento_2,fis.fis_pvv_ff_2,fis.fis_val_icm_fonte_ff_2,fis.fis_oper

Union all
select fis.fis_nro_nota as NF,
      rms7to_date(fis.fis_dta_agenda) as Dta_Agenda,
       fis.fis_val_cont_ff_3 as Contabil,
       fis.fis_base_calc_3 as Base,
       fis.fis_isento_3 as Isento,
     sum(fis.fis_val_cont_ff_3-fis.fis_base_calc_3-fis.fis_isento_3 ) as outras,
       fis.fis_pvv_ff_3 as PVV,
       fis.fis_val_icm_fonte_ff_3 as Fonte

 from aa1cfisc fis 
    where fis.fis_dta_agenda between &dta_inicio and &dta_fim
    and fis.fis_cod_fiscal = &CFO
    and fis.fis_loj_dst = &Loja
    and fis.fis_situacao <> '9'
    and fis.fis_oper not in ('027','032','092','702','709','725','900','902','916','998')
    Group by fis.fis_nro_nota,fis.fis_dta_agenda,fis.fis_val_cont_ff_3,fis.fis_base_calc_3,
             fis.fis_isento_3,fis.fis_pvv_ff_3,fis.fis_val_icm_fonte_ff_3,fis.fis_oper

Union all
select fis.fis_nro_nota as NF,
      rms7to_date(fis.fis_dta_agenda) as Dta_Agenda,
       fis.fis_val_cont_ff_4 as Contabil,
       fis.fis_base_calc_4 as Base,
       fis.fis_isento_4 as Isento,
     sum(fis.fis_val_cont_ff_4-fis.fis_base_calc_4-fis.fis_isento_4) as outras,
       fis.fis_pvv_ff_4 as PVV,
       fis.fis_val_icm_fonte_ff_4 as Fonte

 from aa1cfisc fis 
    where fis.fis_dta_agenda between &dta_inicio and &dta_fim
    and fis.fis_cod_fiscal = &CFO
    and fis.fis_loj_dst = &Loja
    and fis.fis_situacao <> '9'
    and fis.fis_oper not in ('027','032','092','702','709','725','900','902','916','998')
    Group by fis.fis_nro_nota,fis.fis_dta_agenda,fis.fis_val_cont_ff_4,fis.fis_base_calc_4,
             fis.fis_isento_4,fis.fis_pvv_ff_4,fis.fis_val_icm_fonte_ff_4,fis_oper
             
Union all
select fis.fis_nro_nota as NF,
      rms7to_date(fis.fis_dta_agenda) as Dta_Agenda,
       fis.fis_val_cont_ff_5 as Contabil,
       fis.fis_base_calc_5 as Base,
       fis.fis_isento_5 as Isento,
     sum(fis.fis_val_cont_ff_5-fis.fis_base_calc_5-fis.fis_isento_5 ) as outras,
       fis.fis_pvv_ff_5 as PVV,
       fis.fis_val_icm_fonte_ff_5 as Fonte

 from aa1cfisc fis 
    where fis.fis_dta_agenda between &dta_inicio and &dta_fim
    and fis.fis_cod_fiscal = &CFO
    and fis.fis_loj_dst = &Loja
    and fis.fis_situacao <> '9'
    and fis.fis_oper not in ('027','032','092','702','709','725','900','902','916','998')
    Group by fis.fis_nro_nota,fis.fis_dta_agenda,fis.fis_val_cont_ff_5,fis.fis_base_calc_5,
             fis.fis_isento_5,fis.fis_pvv_ff_5,fis.fis_val_icm_fonte_ff_5,fis.fis_oper



