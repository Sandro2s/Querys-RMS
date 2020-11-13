-- Supermercado São Roque Ltda.
-- Data : 13/12/10 
-- Desenvolvedor:Sandro Soares
-- Descrição...: Clientes cadastrados no SMSR que compraram nos ultimos 6 meses.(mala direta)
-- Solicitante.: Zezinho. 
-- Manutenção..: 13/12/10


Select cli_cpf_cnpj as CPF_CNPJ,
       cli_nome as NOME,
       cli_dta_cad as Dta_Cadastro,
       cli_salario as "Salario R$",
       end_rua as RUA,
       end_nro as Nro,
       end_bairro as Bairro,
       end_cid as cidade,
       end_cep as CEP,
nvl(qtd_cred,'0') as "Compra Cred",
nvl(qtd_cheq,'0') as "Compra Cheq"
       
       
 from
  (
  select cli_cpf_cnpj,cli_codigo, cli_nome, cli_dta_cad, cli_salario 
  from cad_cliente
  )cli,
  
  (
  Select cli_codigo, end_rua, end_nro, end_bairro, end_cid, end_cep
    from END_CLIENTE
   where end_cid like 'SAO ROQUE%'
     and end_tpo_end = 1
  )ender,
  
  (       
 Select a.lanc_codigo  as codigo_cred, 
        b.cli_cpf_cnpj as cpfcr,
         count(a.lanc_codigo)as qtd_cred
        -- sum(a.lanc_valor)
    from ac1clanc a,cad_cliente b
   where a.lanc_codigo = b.cli_codigo||b.cli_digito
     and a.lanc_data > 1100601
     and a.lanc_valor > 0
   group by a.lanc_codigo,b.cli_cpf_cnpj
   order by a.lanc_codigo
  )cred ,
   
   (
  Select che_cpf_cnpj_cheque as cpf ,
         count(ch.che_codigo) as qtd_Cheq --rms7to_date( ch.che_emissao )as DT_Emisao,
         --sum(ch.che_valor)
    from ac1ccheq ch
   where ch.che_emissao > 1100601
   group by che_cpf_cnpj_cheque --,rms7to_date( ch.che_emissao )
   order by che_cpf_cnpj_cheque) cheq
   
   where cli.cli_codigo  = ender.cli_codigo
   and  nvl(cli.cli_cpf_cnpj,0)  = cheq.cpf (+)
   and  cli.cli_cpf_cnpj = cred.cpfcr (+)
    
    
 