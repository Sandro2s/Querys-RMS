-- Supermercado São Roque Ltda.
-- Data : 19/04/2013
-- Solicitante : Solange
-- Desenvolvedor : Sandro Soares
-- Descrição : Consulta de limite de credito dos funcionário 
-- Manutenção : 19/04/2013
select to_number(lim_codigo||lim_digito) as codigo
       ,cli.cli_nome as Nome
       ,lim_limite as Limite
       ,ciclo.conv_descricao as Convenio
       ,decode(lim_status,0,'Liberado',1,'Bloqueado') status
 from ac1qlimi, (select cli_codigo,cli_digito as cod,cli_nome,cli_convenio from cad_cliente)cli,
      (select conv_codigo,conv_descricao from ac1cconv where conv_codigo in (1,2,3,4,5,6,7,8,9,10,11,12,50,51,56,57,58,63,64,65,66,67,85,86,91,99,100))ciclo

 where lim_modalidade = 3
  and Lim_limite > 0
  and lim_codigo = cli.cli_codigo
  and cli.cli_convenio = ciclo.conv_codigo 
  order by 2


