-- Supermercado São Roque Ltda.
-- Data : 12/08/2013
-- Solicitante : Tony / André
-- Desenvolvedor : Sandro Soares
-- Descrição : Extrair as compras efetuada em um periodo pelo comprador.
-- Manutenção : 01/04/2013

select rms7to_date(fis_dta_agenda) as dta
       ,fis_comprador as Comprador
       ,fis_nro_nota as Nro_nota
       ,fis_val_cont_FF_1+fis_val_cont_FF_3 +fis_val_cont_FF_3+fis_val_cont_FF_4+fis_val_cont_FF_5 as Vlr_Compra
     --  ,fis_usuario_inc
  from aa1cfisc
 where fis_oper in (2, 4)
   -- and fis_comprador = 6
   and fis_loj_dst = 100
   and fis_dta_agenda between 1140301 and 1140331
   order by dta
