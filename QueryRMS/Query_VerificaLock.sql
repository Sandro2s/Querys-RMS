-- Empresa : Supermercado São Roque Ltda.
-- Data :14/11/2014 
-- Atualizado em : 14/11/2014
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Sandro Soares
-- Descrição : 

/*set wrap off
set lines 130
set pages 100
col owner format a12 heading ‘Owner’
col session_id format 9999 heading ‘Sid’
col object_type format a20 heading ‘Type’
col object_name format a30 heading ‘Objeto’
col oracle_username format a15 heading ‘Username’
col os_user_name format a15 heading ‘OS user*/

select l.SESSION_ID,
o.owner,
o.object_type,
o.object_name,
l.oracle_username,
l.os_user_name
FROM gv$locked_object l,
dba_objects o
WHERE l.object_id = o.object_id
ORDER by l.SESSION_ID,o.object_name