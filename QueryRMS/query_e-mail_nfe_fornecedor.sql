-- Empresa : Supermercado São Roque Ltda.
-- Data : 16/03/11
-- Atualizado em :16/03/11 
-- Desenvolvedor : Sandro Soares.
-- Descrição :Retorna os cadastro do fornecedores sem e-mail para envio
--            envio da nota fiscal eletronica.

select ti.tip_codigo||'-'||ti.tip_digito as codigo,
       ti.tip_razao_social as Razao_Social,
       ti.tip_nome_fantasia as "Nome Fantasia",
       '( '||ti.tip_fone_ddd||' )'| |ti.tip_fone_num as fone,
       '( '||ti.tip_fax_ddd||' )'| |ti.tip_fax_num as fax,
       rmsto_date(ti.tip_data_cad) as "Data Cadastro"
   from aa2ctipo ti,(select tipc_codigo from aa1ctipc where tipc_nome <> 'NFE')nfe
 where ti.tip_codigo = nfe.tipc_codigo
 order by razao_social


