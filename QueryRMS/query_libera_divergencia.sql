-- Supermercado S�o Roque Ltda
-- Data 19/03/10
-- Desenvolvido : Sandro Soares
-- Descri��o : Nao utilizamos a divergencia no recebimento, script para excluir a notas que por algum motivo
--             cairam na divergencia, rodar e excluir a linha toda.Obs.: o codigo do distribuidor � sem digito 
SELECT * FROM AG1DETDV
WHERE DEVI_DESTINO    = 183
AND   DEVI_DTA_AGENDA = 1100317
AND   DEVI_DISTRIB    = 4731
AND   DEVI_TPO_AGENDA = 702
AND   DEVI_NOTA       = 2265
AND   DEVI_SERIE      = '7  '
for update
