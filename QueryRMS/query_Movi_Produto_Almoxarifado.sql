-- Empresa : Supermercado São Roque Ltda. TI
-- Data : 18/07/2017
-- Descrição : Transferencia de produtos do almoxarifado da loja para cd e do cd para lojas 
-- Desenvolvido : Sandro Soares
-- Solicitante : Anderson / Tersi.
-- Atualizado em : 
---Transferencia CD Lojas

select  to_number(TO_CHAR(rms7to_date(ESCHC_DATA),'MM')) AS MES, 
        to_number(esclc_codigo||esclc_digito) as Loja, 
        to_number(git_cod_item||git_digito) as cod_item,
        git_descricao as descricao,
        git_tpo_emb_transf||git_emb_transf  as Embalagem,
        sum(entsaic_quanti_un / git_emb_transf) as Quant,
        sum(entsaic_prc_emb * (entsaic_quanti_un / entsaic_base_emb)) as Custo 
       

from ag1iensa, aa3citem
WHERE eschc_data between 1170601 and 1170630
and eschc_agenda in(47,48,57,669)
and esitc_codigo = git_cod_item
and git_secao in(500,501)
group by to_number(TO_CHAR(rms7to_date(ESCHC_DATA),'MM')),
         esclc_codigo,esclc_digito,
         git_cod_item,git_digito,
         
         
order by esclc_codigo,git_descricao;

----------------------------------------------------------------------------------------------------------------
--Transferencia Lojas CD
select to_number(TO_CHAR(rms7to_date(ESCHC_DATA),'MM')) AS MES,
       to_number( eschljc_codigo3|| eschljc_digito3) as Loja,
       to_number( git_cod_item||git_digito) as cod_item,
        git_descricao as descricao,
        entsaic_tpo_emb||entsaic_base_emb as Embalagem,
    -- eschc_nro_nota3, 
        (entsaic_quanti_un / entsaic_base_emb) as Quant,
         entsaic_prc_emb as Preco_Emb,
        (entsaic_prc_emb * (entsaic_quanti_un / entsaic_base_emb)) as Custo
       

from ag1iensa, aa3citem
WHERE eschc_data between 1170601 and 1170630
and eschc_agenda in(43,741,734,735)
and esitc_codigo = git_cod_item
and git_secao in(500,501)
and esclc_codigo = 100
order by esclc_codigo,git_descricao
