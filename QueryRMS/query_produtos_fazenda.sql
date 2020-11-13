Select * from
(
select fe.esch_nro_nota as "Nr.Nota Fiscal",
       rms7to_date(fe.esch_data)as Dta_Entrada,
       ti.tip_razao_social as "Razão Social",
       fe.eschlj_codigo||'-'|| fe.eschlj_digito as "Fornecedor",
       fe.escl_codigo||'-'||fe.escl_digito as "Loja",
       fe.esch_secao3 as "Seção",
       fe.esch_grupo3 as "Grupo"

  from  ag1fensa fe ,aa2ctipo ti
 where fe.esch_agenda1 = 2 
 and fe.esch_data between 1110101 and 1110331
 and fe.eschlj_codigo = ti.tip_codigo
 and fe.escl_codigo = 11)a  where a.esch_secao3 = 104 and a.esch_grupo3 in (7,10,11,12,13,14,15)