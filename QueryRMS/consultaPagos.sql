spool c:\tmp\clientespagos.txt
select pagos.cod_pago, 
	max(pagos.nome) as nome,
       	sum(lanc_valor) as valor, 
       	count(*) as parcelas, 
       	max(pagos.valor_pago) as valor_pago, 
       	max(pagos.parc_paga) as parcelas_pagas
from ac1clanc lanc, 
     (select lanc_codigo as cod_pago, 
     	     max(cli_nome) as nome,
       	     sum(lanc_valor) as valor_pago, 
       	     count(*) as parc_paga
      from ac1clanc lanc, cad_cliente cli
      where lanc_tipo = 2
      and   trunc(lanc.lanc_codigo /10) = cli.cli_codigo 
      group by lanc_codigo) pagos
where lanc_tipo        (+)= 1
and   lanc_codigo (+)= pagos.cod_pago 
group by pagos.cod_pago;
spool off;