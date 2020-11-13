-- Empresa : Supermercado São Roque Ltda. TI
-- Data :15/02/2011
-- Descrição :Traz todos os cheques em aberto de um portador.
-- Desenvolvido : Sandro Soares
-- Solicitante : Solange.
-- Data manutenção : 15/02/11.


select che.che_codigo  as Codigo,
       a.cli_nome      as Cliente,
       che.che_valor   as Valor , 
      rms7to_date( che.che_emissao) as Dta_Emissao, 
       che.che_banco   as Banco 
  from ac1ccheq che , (select cli_codigo||cli_digito as cod,cli_nome  from cad_cliente)A
  where che.che_vencimento > 0 
  and che.che_codigo (+) = a.cod
  and che.che_status = 1
  and che.che_portador = 1000
  order by cliente