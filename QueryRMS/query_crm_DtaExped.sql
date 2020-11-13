SELECT distinct cli_cpf_cnpj,cli_dta_exp,cli_nome,end_rua,end_bairro,end_cid,end_cep
FROM  cad_cliente A,end_cliente B
where A.cli_codigo = B.cli_codigo
and cli_fil_cad >= 50
and cli_dta_exp is null
and cli_categ = 2

--select * from end_cliente
