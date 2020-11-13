-- Supermercado São Roque Ltda.
-- Data : 12/02/10 
-- Sandro Soares
-- Descrição : Uma nota fiscal que foi para agenda lixo, fica grava nas 7 tabelas abaixo.
--             para excluir tem que dar manutenção em todas elas nesta ordem. (Muita calma nesta hora...)
-- Manutenção : 05/01/11

select * from aa1cfisc where FIS_NRO_NOTA = '&Nota' and fis_oper = '&Agenda' for update;

select * from ag1fensa where ESCH_NRO_NOTA2 = '&Nota' and esch_agenda1 = '&Agenda' for update;

select * from ag1iensa where ESCHC_AGENDA3 = '&Agenda' and eschc_nro_nota3 = '&Nota' for update;

select * from ag2csfis where SEC_FIS_OPER = '&Agenda' and sec_fis_nro_nota = '&Nota' for update;

select * from aa1adfis where ADFIS_AGENDA_P = '&Agenda' and adfis_nota_fiscal_p = '&Nota' for update;

select * from aa1dobra where DBR_COD_AGENDA = '&Agenda' and dbr_nro_nota = '&Nota' for update;

select * from aa1crfis where ref_pri_nro_nota = '&Nota' for update;

select * from aa2cpisi where pisi_agd = '&Agenda' and pisi_nta = '&Nota' for update;

select * from aa2cpisf where pisf_agd = '&Agenda' and pisf_nta = '&Nota' for update;

select * from aa2cpiss where piss_agd = '&Agenda' and piss_nta = '&Nota' for update;