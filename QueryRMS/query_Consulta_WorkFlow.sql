SELECT wit_item,
       wit_situacao,
       wit_processo,
       wit_data_item,
       wit_alocado,
       wit_prev_inicio,
       wit_descricao,
      tab_conteudo as descr_depto
       
FROM AA1WORKI, AA2CTABE, AA2STEDI
WHERE WIT_ITEM      > 0
AND   WIT_ITEM    (+)= STE_WORK_ITEM
--AND  ( (WIT_RESPONSAVEL = 'SANDROS   ') OR 
 --     (WIT_DEPARTAMENTO = 4 AND WIT_RESPONSAVEL = rpad('  ',10)))
AND   TAB_CODIGO (+)= 023
AND   TAB_ACESSO (+)= 'DEPTO' || TO_CHAR(WIT_DEPARTAMENTO,'FM000') || '  '
AND   WIT_SITUACAO IN (0,1)
--and wit_item = 121058
order by 4
------------------------------------------------------------------------------------------------------------------------
select * from AA1WORKI 
WHERE WIT_ITEM      > 0
AND   WIT_SITUACAO IN (0,1)
and  dateto_rms7(wit_data_item) = 1161020--and wit_descricao like '%Filial nao cadastrada para importacao de notas XML%'
------------------------------------------------------------------------------------------------------------------------

update AA1WORKI
   set WIT_SITUACAO = 2
 where WIT_ITEM      > 0
AND   WIT_SITUACAO IN (0,1)
and dateto_rms7(wit_data_item)  = 1161020
--and wit_descricao like '%Filial nao cadastrada para importacao de notas XML%'
------------------------------------------------------------------------------------------------------------------------
SELECT AA1WORKI.*,
TAB_CONTEUDO AS DESCR_DEPTO
FROM AA1WORKI, AA2CTABE, AA2STEDI
WHERE WIT_ITEM      > 0
AND   WIT_ITEM    (+)= STE_WORK_ITEM
/*AND  ( (WIT_RESPONSAVEL = 'SANDROS   ') OR 
       (WIT_DEPARTAMENTO = 4 AND WIT_RESPONSAVEL = rpad('  ',10)))*/
AND   TAB_CODIGO (+)= 023
AND   TAB_ACESSO (+)= 'DEPTO' || TO_CHAR(WIT_DEPARTAMENTO,'FM000') || '  '
AND   WIT_SITUACAO IN (0,1)
