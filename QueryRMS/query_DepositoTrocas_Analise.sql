-- Empresa : Supermercado São Roque Ltda. TI
-- Data :21/09/2017
-- Descrição : Analise dos movimento no deposito de trocas.
-- Desenvolvido : Sandro Soares
-- Solicitante : Andersom Grisolle
-- Atualizado em :21/09/217
-----------------------------------------------------------------------------------------------------------------------
select  substr(dt_mvto,2,2) as Ano,
       cd_fil_origem||dac(cd_fil_origem) as Loja,
       tipo.tip_codigo||tipo.tip_digito as Forncedor,
       tip_nome_fantasia as Desc_Fornc,
       git_cod_item||git_digito as cod_prod,
       git_descricao as Descricao,
    --   decode(sts_atu,1,'Notificado',100,'Com Aviso',200,'Faturado',300,'Excluido',400,'Em Processamento',500,'Em Faturamento') as Status,
      sum(qtde_mvto) as Quant,
      round((sum(cd_custo*qtde_mvto)),1) as Custo
       from ag3ttrdv,aa3citem,
          (select tip_codigo,tip_digito , tip_nome_fantasia from aa2ctipo where tip_loj_cli = 'F')tipo
 where cd_prod > 0
  and cd_ent_estq = 100
 and dt_mvto between 1140101 and 1161231 
 and cd_agd_fat in (44,643,918)
 and git_cod_item = cd_prod
 and git_digito = dac(cd_prod)
 and cd_fornec_fat = tipo.tip_codigo
 and cd_custo > 0
 group by cd_fil_origem,
          tip_codigo,
          tip_digito,
          tip_nome_fantasia,
          git_cod_item,
          git_digito,
          git_descricao,
          dt_mvto
 order by 1
