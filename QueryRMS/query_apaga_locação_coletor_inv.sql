-- Supermercado São Roque Ltda.
-- Data : 25/01/2015
-- Solicitante : Sandro
-- Desenvolvedor : Sandro Soares
-- Descrição : Apagar alocação indevida de recontagem de inventário do CD. 
-- Manutenção : 25/01/2015

       
       SELECT *
   FROM AG2WCINV where inv_numero = 184242 
   --and inv_ean = 7896098900727
    and inv_nlote = 24 
    and inv_tp_contagem = 0
    and inv_conferido = 0
    for update