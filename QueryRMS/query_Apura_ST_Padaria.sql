-- Empresa : Supermercado São Roque Ltda. TI
-- Data :05/08/2010
-- Descrição : Procura os produtos da padaria que não foi calculado o valor da ST na 
--             na venda para as lojas "Agrupo"
-- Desenvolvido : Sandro Soares
-- Atualizado em : 17/08/2010

select   rms7to_date (fis.fis_dta_agenda) as "Data Agenda",
         fis.fis_nro_nota as NF,
         fis.fis_figura_1 as Figura ,
         fis.fis_val_cont_FF_1 as "Valor Contabil",
         fis.fis_base_calc_1 as "Base Calculo",
         iva.redu as "Base Redução",
         iva.aliquota as "Aliquota",  --fis.fis_aliq_icm_1 as "Aliquota",
         iva.iva   as "IVA",
         0   as "Fonte",
         fis.fis_situacao as "Situação"
         from aa1cfisc fis,
         (
         select fi.tfis_figura as Figura,
  fi.tfis_icm_fonte as Aliquota,
  fi.tfis_aliq_str as IVA,
  fi.tfis_base_reduz as Redu
  from aa2tfisc fi
 where fi.tfis_origem = 'SP'
   and fi.tfis_destino = 'SP'
   and fi.tfis_codigo = 172
   and fi.tfis_figura in(206,207,208,214,237,346,375,380,392,404)
         )iva
           where fis.fis_oper = 68
           and fis.fis_dta_agenda between 1090301 and 1100731
           and fis.fis_figura_1 in (206,207,208,214,237,346,375,380,392,404)
           and iva.figura = fis.fis_figura_1

           
Union all

select   rms7to_date (fis.fis_dta_agenda) as "Data Agenda",
         fis.fis_nro_nota as NF,
         fis.fis_figura_2 as Figura ,
         fis.fis_val_cont_FF_2 as "Valor Contabil",
         fis.fis_base_calc_2 as "Base Calculo",
         iva.redu as "Base Redução",
         iva.aliquota as "Aliquota",  --fis.fis_aliq_icm_1 as "Aliquota",
         iva.iva   as "IVA",
         0   as "Fonte",
         fis.fis_situacao as "Situação"
         from aa1cfisc fis,
         (
         select fi.tfis_figura as Figura,
  fi.tfis_icm_fonte as Aliquota,
  fi.tfis_aliq_str as IVA,
  fi.tfis_base_reduz as Redu
  from aa2tfisc fi
 where fi.tfis_origem = 'SP'
   and fi.tfis_destino = 'SP'
   and fi.tfis_codigo = 172
   and fi.tfis_figura in(206,207,208,214,237,346,375,380,392,404)
         )iva
           where fis.fis_oper = 68
           and fis.fis_dta_agenda between 1090301 and 1100731
           and fis.fis_figura_2 in (206,207,208,214,237,346,375,380,392,404)
           and iva.figura = fis.fis_figura_2
Union all

select   rms7to_date (fis.fis_dta_agenda) as "Data Agenda",
         fis.fis_nro_nota as NF,
         fis.fis_figura_3 as Figura ,
         fis.fis_val_cont_FF_3 as "Valor Contabil",
         fis.fis_base_calc_3 as "Base Calculo",
         iva.redu as "Base Redução",
         iva.aliquota as "Aliquota",  --fis.fis_aliq_icm_1 as "Aliquota",
         iva.iva   as "IVA",
         0   as "Fonte",
         fis.fis_situacao as "Situação"
         from aa1cfisc fis,
         (
         select fi.tfis_figura as Figura,
  fi.tfis_icm_fonte as Aliquota,
  fi.tfis_aliq_str as IVA,
  fi.tfis_base_reduz as Redu
  from aa2tfisc fi
 where fi.tfis_origem = 'SP'
   and fi.tfis_destino = 'SP'
   and fi.tfis_codigo = 172
   and fi.tfis_figura in(206,207,208,214,237,346,375,380,392,404)
         )iva
           where fis.fis_oper = 68
           and fis.fis_dta_agenda between 1090301 and 1100731
           and fis.fis_figura_3 in (206,207,208,214,237,346,375,380,392,404)
           and iva.figura = fis.fis_figura_3

Union all

select   rms7to_date (fis.fis_dta_agenda) as "Data Agenda",
         fis.fis_nro_nota as NF,
         fis.fis_figura_4 as Figura ,
         fis.fis_val_cont_FF_4 as "Valor Contabil",
         fis.fis_base_calc_4 as "Base Calculo",
         iva.redu as "Base Redução",
         iva.aliquota as "Aliquota",  --fis.fis_aliq_icm_1 as "Aliquota",
         iva.iva   as "IVA",
         0   as "Fonte",
         fis.fis_situacao as "Situação"
         from aa1cfisc fis,
         (
         select fi.tfis_figura as Figura,
  fi.tfis_icm_fonte as Aliquota,
  fi.tfis_aliq_str as IVA,
  fi.tfis_base_reduz as Redu
  from aa2tfisc fi
 where fi.tfis_origem = 'SP'
   and fi.tfis_destino = 'SP'
   and fi.tfis_codigo = 172
   and fi.tfis_figura in(206,207,208,214,237,346,375,380,392,404)
         )iva
           where fis.fis_oper = 68
           and fis.fis_dta_agenda between 1090301 and 1100731
           and fis.fis_figura_4 in (206,207,208,214,237,346,375,380,392,404)
           and iva.figura = fis.fis_figura_4

Union all

select   rms7to_date (fis.fis_dta_agenda) as "Data Agenda",
         fis.fis_nro_nota as NF,
         fis.fis_figura_5 as Figura ,
         fis.fis_val_cont_FF_5 as "Valor Contabil",
         fis.fis_base_calc_5 as "Base Calculo",
         iva.redu as "Base Redução",
         iva.aliquota as "Aliquota",  --fis.fis_aliq_icm_1 as "Aliquota",
         iva.iva   as "IVA",
         0   as "Fonte",
         fis.fis_situacao as "Situação"
         from aa1cfisc fis,
         (
         select fi.tfis_figura as Figura,
  fi.tfis_icm_fonte as Aliquota,
  fi.tfis_aliq_str as IVA,
  fi.tfis_base_reduz as Redu
  from aa2tfisc fi
 where fi.tfis_origem = 'SP'
   and fi.tfis_destino = 'SP'
   and fi.tfis_codigo = 172
   and fi.tfis_figura in(206,207,208,214,237,346,375,380,392,404)
         )iva
           where fis.fis_oper = 68
           and fis.fis_dta_agenda between 1090301 and 1100731
           and fis.fis_figura_5 in (206,207,208,214,237,346,375,380,392,404)
           and iva.figura = fis.fis_figura_5


/*select   rms7to_date (fis.fis_dta_agenda) as "Data Agenda",
         fis.fis_nro_nota as NF,
         fis.fis_figura_1 as Figura ,
         fis.fis_val_cont_FF_1 as "Valor Contabil",
         fis.fis_base_calc_1 as "Base Calculo",
         iva.aliquota as "Aliquota",  --fis.fis_aliq_icm_1 as "Aliquota",
         iva.iva   as "IVA",
         0   as "Fonte"
         from aa1cfisc fis,
         (
         select fi.tfis_figura as Figura,
  fi.tfis_icm_fonte as Aliquota,
  fi.tfis_aliq_str as IVA
  from aa2tfisc fi
 where fi.tfis_origem = 'SP'
   and fi.tfis_destino = 'SP'
   and fi.tfis_codigo = 172
   and fi.tfis_figura in(206,207,208,214,237,346,375,380,392,404)
         )iva
         
         where fis.fis_oper = 68
           and fis.fis_dta_agenda between 1090301 and 1100731
           and fis.fis_figura_1 in (206,207,208,214,237,346,375,380,392,404)
           and iva.figura = fis.fis_figura_1
*/

/*select fi.tfis_figura as "Figura",
  fi.tfis_icm_fonte as "Aliquota",
  fi.tfis_aliq_str as "IVA"
  from aa2tfisc fi
 where fi.tfis_origem = 'SP'
   and fi.tfis_destino = 'SP'
   and fi.tfis_codigo = 172
   and fi.tfis_figura in(206,207,208,214,237,346,375,380,392,404)*/