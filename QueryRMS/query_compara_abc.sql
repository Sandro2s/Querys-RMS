select cli_cpf_cnpj, cod_cli_old, cod_cli_atu, b.cli_digito, b.cli_fil_cad
from importa_abc, cad_cliente b
where cod_cli_atu = b.cli_codigo
order by b.cli_cpf_cnpj
