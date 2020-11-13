select lim_codigo||lim_digito as Codigo
       ,Nome
       ,lim_limite as Limite
       ,lim_saldo as Utilizado
       ,lim_disponivel as Saldo
     --  ,lim_status
   from ac1qlimi ,(select cli_codigo||cli_digito as cod
                       ,cli_nome as nome
                       from cad_cliente
                       order by cod ) cad
    
   where lim_codigo||lim_digito = cad.cod 
   and lim_modalidade = 1 
   and lim_disponivel < 0
   and lim_status = 0
   order by nome

