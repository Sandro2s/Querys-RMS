-- Empresa : Supermercado São Roque Ltda.
-- Data :06/08/2017
-- Desenvolvedor : Joaquim.
-- Solicitante : Francine
-- Descrição : Totais de icms por loja data agenda cfop (Francine comparar com contabilidade) 

---------- ICMS             --- alterar tabela

select decode(fisc_t03_ens, 'E', fisc_dst, fisc_org) Loja, fisc_dta DTA_nota, fisc_nta nro_nota, 
       decode(fisc_cfo,1403, 1102, 2403, 2102, 1411, 1202, fisc_cfo) cfop,  
       fisc_age agenda, fisc_ctb_val vlr_contabil, fisc_icm_bas Base_calculo, fisc_icm_val vlr_icms 
from aa1ffisc_201703
where fisc_t04_fis = 'S' and fisc_icm_val > 0 and fisc_sit <> '9' --and decode(fisc_t03_ens, 'E', fisc_dst, fisc_org) = 1
order by decode(fisc_t03_ens, 'E', fisc_dst, fisc_org), fisc_cfo, fisc_dta, fisc_nta, fisc_age;



----------  PIS/COFINS

select filial, substr(data,6,2)||'/'||substr(data,4,2)||'/20'||substr(data,2,2) data,
       nota, serie, cfop, agenda, valcont, bascal, valpis, valcof 
  from ( select fisc_emp                                        empresa,
                max(emp_razao_social)                           razemp,
                fisc_fil_pri                                    codfil,
                max(fisc_fil_pri || '-' || dac(fisc_fil_pri))   filial,
                max(tip_razao_social)                           razfil,
                fisc_nta                                        nota,
                fisc_dta                                        data,
                fisc_ser                                        serie,
                fisi_cfo                                        cfop,
                fisc_org || '-' || dac(fisc_org)                origem ,
                fisc_dst || '-' || dac(fisc_dst)                destino ,
                fisi_age                                        agenda,
                max( fisc_t03_ens )                             entsai,
                sum( fisi_ctb_val )                             valcont,
                sum( decode(fisi_pis_sit,1,fisi_pis_ctb,0) )    antecip,
                sum( decode(fisi_pis_sit,4,fisi_pis_ctb,0) )    rural,
                sum( decode(fisi_pis_sit,3,fisi_pis_ctb,0) )    alq_zero,
                sum( decode(fisi_pis_sit,2,fisi_pis_ctb,0) )    isento,
                sum( fisi_ctb_val
                   - decode(fisi_pis_sit,1,fisi_pis_ctb,0)
                   - decode(fisi_pis_sit,4,fisi_pis_ctb,0)
                   - decode(fisi_pis_sit,3,fisi_pis_ctb,0)
                   - decode(fisi_pis_sit,2,fisi_pis_ctb,0)
                   - decode(fisi_pis_sit,0,fisi_pis_bas,0)
                   - decode(fisi_pis_sit,5,fisi_pis_bas,0)
                   - decode(fisi_pis_sit,9,fisi_pis_bas,0) )             outras,
                sum( decode(fisi_pis_sit,0,fisi_pis_bas,0) )             bascal,
                sum( decode(fisi_pis_sit,5,fisi_pis_bas,0) )             bc_presum,
                sum( decode(fisi_pis_sit,5,trunc(fisi_pis_val,2),0)
                   + decode(fisi_cof_sit,5,trunc(fisi_cof_val,2),0) )    vl_presum,
                sum( decode(fisi_pis_sit,9,fisi_pis_bas,0) )             bascum,
                sum( decode(fisi_pis_sit,9,trunc(fisi_pis_val,2),0)
                   + decode(fisi_cof_sit,9,trunc(fisi_cof_val,2),0) )    valcum,
                sum( decode(fisi_pis_sit,0,trunc(fisi_pis_val,2),0) )    valpis,
                sum( decode(fisi_cof_sit,0,trunc(fisi_cof_val,2),0) )    valcof,
                sum( decode(fisi_pis_sit,0,trunc(fisi_pis_val,2),0)
                   + decode(fisi_pis_sit,5,trunc(fisi_pis_val,2),0)
                   + decode(fisi_pis_sit,9,trunc(fisi_pis_val,2),0)
                   + decode(fisi_cof_sit,0,trunc(fisi_cof_val,2),0)
                   + decode(fisi_cof_sit,5,trunc(fisi_cof_val,2),0)
                   + decode(fisi_cof_sit,9,trunc(fisi_cof_val,2),0) )    debcred
           from AA1FFISC_201702,           --- alterar tabela
                AA1FFISI_201702,           --- alterar tabela
                AA2CTIPO,
                AA2CEMPR
          where tip_digito      = dac(fisc_fil_pri)
            and tip_codigo      = fisc_fil_pri
            and emp_codigo      = fisc_emp
            and ( fisi_t25_pis  = 'S'
             or   fisi_pis_bas  > 0
             or   fisi_cof_bas  > 0 )
            and fisi_id         = fisc_id
            and fisc_age   not in (46,0,151)
            and fisc_t11_tpo   <> 'T'
            and fisc_t04_fis    = 'S'
            and fisc_t03_ens    = 'E'
            and fisc_sit       <> '9'
            and fisc_dta  between 1170201 and 1170228           --- alterar data
            and fisc_emp        in (1,2,12)
          group by fisc_emp,
                   fisc_fil_pri,
                   fisc_nta,
                   fisc_dta,
                   fisc_ser,
                   fisi_cfo,
                   fisc_org || '-' || dac(fisc_org),
                   fisc_dst || '-' || dac(fisc_dst),
                   fisi_age
     union  
         select pisf_emp                             empresa,
                emp_razao_social                     razemp,
                pisf_fil                             codfil,
                pisf_fil  || '-' || dac(pisf_fil)    filial,
                tip_razao_social                     razfil,
                pisf_nta                             nota,
                pisf_dta                             data,
                pisf_ser                             serie,
                pisf_cfo                             cfop,
                fis_loj_org || '-' || fis_dig_org    origem ,
                fis_loj_dst || '-' || fis_dig_dst    destino ,
                pisf_age                             agenda,
                pisf_ent_sai                         entsai,
                pisf_pis_ctb                         valcont,
                pisf_pis_ant                         antecip,
                pisf_pis_rur                         rural,
                pisf_pis_zer                         alq_zero,
                pisf_pis_ise                         isento,
                ( pisf_pis_div
                + pisf_pis_ctb
                - pisf_pis_bas
                - pisf_pis_bcp
                - pisf_pis_ant
                - pisf_pis_ise
                - pisf_pis_zer
                - pisf_pis_bcm )                     outras,
                pisf_pis_bas                         bascal,
                pisf_pis_bcp                         bc_presum,
                ( pisf_pis_pre + pisf_cof_pre )      vl_presum,
                pisf_pis_bcm                         bascum,
                ( pisf_pis_cum + pisf_cof_cum )      valcum,
                pisf_pis_val                         valpis,
                pisf_cof_val                         valcof,
                ( pisf_pis_tot + pisf_cof_tot )      debcred
           from AA2CPISF,
                AA1CFISC,
                AA2CTIPO,
                AA2CEMPR,
                AA1CTCON 
          where tip_digito      = dac(pisf_fil)
            and tip_codigo      = pisf_fil
            and emp_codigo      = pisf_emp
            and tbc_intg_11    <> 'T'
            and tbc_intg_4      = 'S'
            and tbc_codigo      = pisf_crf
            and tbc_agenda      = pisf_age
            and fis_situacao   <> '9'
            and fis_dta_agenda  = pisf_dta
            and fis_serie       = pisf_ser
            and fis_nro_nota    = pisf_nta
            and fis_dig_org     = dac(pisf_org)
            and fis_loj_org     = pisf_org
            and fis_oper        = pisf_agd
            and pisf_age       in (46,0,151)
            and pisf_ent_sai    = 'E'
            and pisf_dta  between 1170201 and 1170228           --- alterar data
            and pisf_mes        = 02                            --- alterar mes
            and pisf_emp        in (1,2,12)
     union
         select fisc_emp                                        empresa,
                max(emp_razao_social)                           razemp,
                fisc_fil_pri                                    codfil,
                max(fisc_fil_pri || '-' || dac(fisc_fil_pri))   filial,
                max(tip_razao_social)                           razfil,
                fisc_nta                                        nota,
                fisc_dta                                        data,
                fisc_ser                                        serie,
                fisi_cfo                                        cfop,
                fisc_org || '-' || dac(fisc_org)                origem ,
                fisc_dst || '-' || dac(fisc_dst)                destino ,
                fisi_age                                        agenda,
                max( fisc_t03_ens )                             entsai,
                sum( fisi_ctb_val )                             valcont,
                sum( decode(fisi_pis_sit,1,fisi_pis_ctb,0) )             antecip,
                sum( decode(fisi_pis_sit,4,fisi_pis_ctb,0) )             rural,
                sum( decode(fisi_pis_sit,3,fisi_pis_ctb,0) )             alq_zero,
                sum( decode(fisi_pis_sit,2,fisi_pis_ctb,0) )             isento,
                sum( fisi_ctb_val
                   - decode(fisi_pis_sit,1,fisi_pis_ctb,0)
                   - decode(fisi_pis_sit,4,fisi_pis_ctb,0)
                   - decode(fisi_pis_sit,3,fisi_pis_ctb,0)
                   - decode(fisi_pis_sit,2,fisi_pis_ctb,0)
                   - decode(fisi_pis_sit,0,fisi_pis_bas,0)
                   - decode(fisi_pis_sit,5,fisi_pis_bas,0)
                   - decode(fisi_pis_sit,9,fisi_pis_bas,0) )             outras,
                sum( decode(fisi_pis_sit,0,fisi_pis_bas,0) )             bascal,
                sum( decode(fisi_pis_sit,5,fisi_pis_bas,0) )             bc_presum,
                sum( decode(fisi_pis_sit,5,trunc(fisi_pis_val,2),0)
                   + decode(fisi_cof_sit,5,trunc(fisi_cof_val,2),0) )    vl_presum,
                sum( decode(fisi_pis_sit,9,fisi_pis_bas,0) )             bascum,
                sum( decode(fisi_pis_sit,9,trunc(fisi_pis_val,2),0)
                   + decode(fisi_cof_sit,9,trunc(fisi_cof_val,2),0) )    valcum,
                sum( decode(fisi_pis_sit,0,trunc(fisi_pis_val,2),0) )    valpis,
                sum( decode(fisi_cof_sit,0,trunc(fisi_cof_val,2),0) )    valcof,
                sum( decode(fisi_pis_sit,0,trunc(fisi_pis_val,2),0)
                   + decode(fisi_pis_sit,5,trunc(fisi_pis_val,2),0)
                   + decode(fisi_pis_sit,9,trunc(fisi_pis_val,2),0)
                   + decode(fisi_cof_sit,0,trunc(fisi_cof_val,2),0)
                   + decode(fisi_cof_sit,5,trunc(fisi_cof_val,2),0)
                   + decode(fisi_cof_sit,9,trunc(fisi_cof_val,2),0) )    debcred
           from AA1FFISC_201702,           --- alterar tabela
                AA1FFISI_201702,           --- alterar tabela
                AA2CTIPO,
                AA2CEMPR
          where tip_digito      = dac(fisc_fil_pri)
            and tip_codigo      = fisc_fil_pri
            and emp_codigo      = fisc_emp
            and ( fisi_t25_pis  = 'S'
             or   fisi_pis_bas  > 0
             or   fisi_cof_bas  > 0 )
            and fisi_id         = fisc_id
            and fisc_age   not in (46,0,151)
            and fisc_t11_tpo   <> 'T'
            and fisc_t04_fis    = 'S'
            and fisc_t03_ens    = 'S'
            and fisc_sit       <> '9'
            and fisc_dta  between 1170201 and 1170228           --- alterar data
            and fisc_emp        in (1,2,12)
          group by fisc_emp,
                   fisc_fil_pri,
                   fisc_nta,
                   fisc_dta,
                   fisc_ser,
                   fisi_cfo,
                   fisc_org || '-' || dac(fisc_org),
                   fisc_dst || '-' || dac(fisc_dst),
                   fisi_age
     union  
         select pisf_emp                             empresa,
                emp_razao_social                     razemp,
                pisf_fil                             codfil,
                pisf_fil  || '-' || dac(pisf_fil)    filial,
                tip_razao_social                     razfil,
                pisf_nta                             nota,
                pisf_dta                             data,
                pisf_ser                             serie,
                pisf_cfo                             cfop,
                fis_loj_org || '-' || fis_dig_org    origem ,
                fis_loj_dst || '-' || fis_dig_dst    destino ,
                pisf_age                             agenda,
                pisf_ent_sai                         entsai,
                pisf_pis_ctb                         valcont,
                pisf_pis_ant                         antecip,
                pisf_pis_rur                         rural,
                pisf_pis_zer                         alq_zero,
                pisf_pis_ise                         isento,
                ( pisf_pis_div
                + pisf_pis_ctb
                - pisf_pis_bas
                - pisf_pis_bcp
                - pisf_pis_ant
                - pisf_pis_ise
                - pisf_pis_zer
                - pisf_pis_bcm )                     outras,
                pisf_pis_bas                         bascal,
                pisf_pis_bcp                         bc_presum,
                ( pisf_pis_pre + pisf_cof_pre )      vl_presum,
                pisf_pis_bcm                         bascum,
                ( pisf_pis_cum + pisf_cof_cum )      valcum,
                pisf_pis_val                         valpis,
                pisf_cof_val                         valcof,
                ( pisf_pis_tot + pisf_cof_tot )      debcred
           from AA2CPISF,
                AA1CFISC,
                AA2CTIPO,
                AA2CEMPR,
                AA1CTCON 
          where tip_digito      = dac(pisf_fil)
            and tip_codigo      = pisf_fil
            and emp_codigo      = pisf_emp
            and tbc_intg_11    <> 'T'
            and tbc_intg_4      = 'S'
            and tbc_codigo      = pisf_crf
            and tbc_agenda      = pisf_age
            and fis_situacao   <> '9'
            and fis_dta_agenda  = pisf_dta
            and fis_serie       = pisf_ser
            and fis_nro_nota    = pisf_nta
            and fis_dig_org     = dac(pisf_org)
            and fis_loj_org     = pisf_org
            and fis_oper        = pisf_agd
            and pisf_age       in (46,0,151)
            and pisf_ent_sai    = 'S'
            and pisf_dta  between 1170201 and 1170228           --- alterar data
            and pisf_mes        = 02                            --- alterar mes
            and pisf_ano        = 117                           --- alterar ano
            and pisf_emp        in (1,2,12)
       )            
 order by codfil,
          data,
          nota