-- Empresa : Supermercado São Roque Ltda.
-- Data :19/12/2012 
-- Atualizado em : 19/12/2012
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Solange Pinheiro
-- Descrição : As situações que o usuário coloca pagamento antecipado. Excluindo estes campos o 
--             titulo volta ao status de aberto.Ideal é excluir e lançar novamente.

select cpd_cgc_cpf,
       cpd_forne,
       cpm_venc,
       cpd_ntfis,
       cpm_dtpg,-- alterar para zero
       cpd_vlr_pago_cheque,--alterar para zero
       cpd_dta_baixa,--alterar para zero
       cpd_portador, -- alterar para zero
       cpd_motivo_baixa --alterar para zero

from ag1pagcp where cpd_forne = 20232
and cpm_venc = 1121218
and cpd_ntfis in(402453) for update