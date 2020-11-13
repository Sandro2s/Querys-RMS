-- Supermercado São Roque Ltda.
-- Data : 06/09/09 
-- Desenvolvido : Sandro Soares
-- Descrição : Cadastro de cliente que não estão devendo no crediário e cadastrados no magazine.
-- Manutenção :

select li.lim_codigo ||'-'|| li.lim_digito as codigo,  
       cd.cli_nome as Nome,
       cd.cli_fil_cad as Loja,
       cd.cli_dta_nasc as Dta_Nasc,
       ed.end_rua as Rua,
       ed.end_nro as Nr,   
       ed.end_bairro as Bairro,
       ed.end_cid as Cidade,
       ed.end_cep as CEP,
       cd.cli_dta_cad
             
  from ac1qlimi li, cad_cliente cd, end_cliente ed
 where li.lim_codigo = cd.cli_codigo
   and cd.cli_codigo = ed.cli_codigo
   and li.lim_modalidade = 7
   and li.lim_saldo = 0
   and cd.cli_fil_cad in (50,51,52,53)
   and cd.cli_convenio = 0
   and ed.end_tpo_end = 1
   and cd.cli_nome_empresa not like 'DEMITID%'
   and cd.cli_dta_cad >= '01/01/2007'
  order by loja,nome;

--======================================================================================================================
-- Supermercado São Roque Ltda.
-- Data : 15/09/09 
-- Desenvolvido : Sandro Soares
-- Descrição : Extração dos clientes que não devem no crediario para importar no Alterdata
-- Manutenção :

select cd.cli_nome as Nome,
       ed.end_rua as Endereco,
       ed.end_bairro as Bairro,
       ed.end_cid as Cidade,
       ed.end_cep as CEP,
       cc.cont_numero as Telefone,
       ed.end_uf as Estado,
       cd.cli_cpf_cnpj as CPF_CNPJ,
       cd.cli_rg_insc_est as Insc_RG,
       ed.end_nro as NR,
       cd.cli_dta_nasc as Dta_Nasc,
       li.lim_limite as Limite
    
         
             
  from ac1qlimi li, cad_cliente cd, end_cliente ed,contato_cliente cc
 where li.lim_codigo = cd.cli_codigo
   and cd.cli_codigo = ed.cli_codigo
   and ed.cli_codigo = cc.cli_codigo
   and li.lim_modalidade = 7
   and li.lim_saldo = 0
   and cd.cli_fil_cad in (50,51,52,53)
   and cd.cli_convenio = 0
   and ed.end_tpo_end = 1
   and cd.cli_nome_empresa not like 'DEMITID%'
   and cd.cli_dta_cad >= '01/01/2007'
   and cc.cont_tipo = 1
  order by nome;


-- select count( * )from ac1qlimi li where li.lim_codigo > 0 and  li.lim_modalidade = 7 and li.lim_saldo = 0

--select * from cad_cliente where cli_codigo = 1963
--Select * from end_cliente where cli_codigo = 1963

--select * from ac1qlimi

