
-- Supermercado São Roque Ltda.
-- Data : 16/07/2012
-- Solicitante : Tony Goginho
-- Desenvolvedor : Sandro Soares
-- Descrição : Consultar e gerar aquivo texto no layout do Dagno (importar para excell)
-- Manutenção : 16/07/12

select rpad(aa.git_cod_item||aa.git_digito,12,' ')as cod_int,
       to_char(mult.ean_cod_ean,'fm0000000000000') as ean,
       to_char(est.qtd_est,'fm00000,000') as Estoque,
       rpad(aa.git_desc_reduz,40,' ') as Dsc
       
  from aa3citem aa,
       (
         select get_cod_produto as cod,
             to_char((get_estoque*1000),'00000000') as qtd_est
              from aa2cestq where get_cod_local = 108
        )est,
        (
           select ean_cod_pro_alt ,ean_cod_ean from aa3ccean
            where ean_flag_princ <> 'D'
         )mult
              
 where aa.git_secao in (100,101,102,103,104,105,106,107,108,109,110,111,112,200,201,300,301,302,303,304,305,306,400,401)
       and aa.git_cod_item||aa.git_digito = est.cod
       and mult.ean_cod_pro_alt = est.cod
       --and aa.git_codigo_ean13 > 40000000
       order by git_codigo_ean13;
