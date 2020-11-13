-- Empresa : Supermercado São Roque Ltda.
-- Data :27/06/2013
-- Atualizado em : 27/06/2013
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Solange Pinheiro
-- Descrição : Retornar as notas fiscais que a bonificação foi lançada junsto com a compra.

select * from
(select fis_oper as agenda,
      to_number(fis_loj_org||fis_dig_org) as Fornecedor,
       fis_loj_dst as Loja,
       fis_nro_nota as nota,
       rms7to_date(fis_dta_agenda) as Dta_Agenda,
       sum(fis_val_cont_ff_1 + fis_val_cont_FF_2 + fis_val_cont_FF_3 + fis_val_cont_FF_4 + fis_val_cont_FF_5) as vl_contabil

 from aa1cfisc
  where fis_oper = 2
  and fis_situacao not in '9'
  and fis_dta_agenda between 1130501 and 1130905 group by fis_oper,fis_loj_org,fis_dig_org,fis_loj_dst,fis_nro_nota,fis_dta_agenda)A,

(select fis_oper as agenda,
       to_number(fis_loj_org||fis_dig_org) as Fornecedor,
       fis_loj_dst as Loja,
       fis_nro_nota as nota,
      rms7to_date( fis_dta_agenda) as Dta_Agenda,
      sum(fis_val_cont_ff_1 + fis_val_cont_FF_2 + fis_val_cont_FF_3 + fis_val_cont_FF_4 + fis_val_cont_FF_5) as vl_contabil

 from aa1cfisc
  where fis_oper = 9
  and fis_situacao not in  '9'
  and fis_dta_agenda between 1130501 and 1130905  group by fis_oper,fis_loj_org,fis_dig_org,fis_loj_dst,fis_nro_nota,fis_dta_agenda)B,

  (select to_number(tip_codigo||tip_digito) as codigo,
          tip_razao_social
            from aa2ctipo
              where tip_loj_cli = 'F')tip

  where a.nota = b.nota
   and a.fornecedor = b.fornecedor
   and a.fornecedor = tip.codigo
  order by 2,3
