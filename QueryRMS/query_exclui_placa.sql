--Exclui a placa do caminh�o no recebimento
SELECT /*SAIN_VEICULO*/* FROM AG1CSAIN
WHERE SAIN_FILIAL_ALT   =  100
AND   SAIN_DATA_ALT     =  1160114
AND   SAIN_AGENDA_ALT   =  002
AND   SAIN_EMITENTE_ALT =  1154
AND   SAIN_NRO_NOTA_ALT =  915108
AND   SAIN_SERIE_ALT    = '20 '
 for update