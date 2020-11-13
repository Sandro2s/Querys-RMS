-- Empresa : Supermercado São Roque Ltda.
-- Data : 22/03/2012
-- Desenvolvedor : Sandro Soares
-- Descrição : Consulta programa que esta acessando o banco de dados.
-- Manutenção em : 22/03/2012
-- Obs.: Tem que rodar em cada  AS para ver o processo.

select sid, serial#, machine, osuser, program, module
  from v$session
 where lower(program) in ('wrms.exe', 'rmsinit.exe')
   and (lower(module) like ('%vgccfech%'))
 order by module