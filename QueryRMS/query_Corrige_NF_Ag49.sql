--Corrige as notas de venda para as lojas de fora emitidas pelo modulo de logistica.
--Esssas notas s�o emitdas pela agenda 49.
--Rodas o scripe e fazer reemiss�o das notas (administrativo financeiro\livro fiscais\manuten��o\Registro Fiscais.)

select *
  from aa1cfisc
 where FIS_DTA_AGENDA > 1140311
   and fis_oper = 49
   and fis_tipo_agenda = 'T'

update aa1cfisc
   set fis_tipo_agenda = 'V'
 where fis_dta_agenda > 1140311
  and fis_oper = 49
  and fis_tipo_agenda = 'T'