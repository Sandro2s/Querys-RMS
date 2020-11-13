-- Empresa : Supermercado São Roque Ltda.
-- Data :01/06/2015 
-- Atualizado em : 01/06/2015
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Tony Godinho
-- Descrição : consulta a movimentação de envio para loja por sistemática de 
--             abastecimento.

SELECT q.get_cod_produto AS RMS,
       i.git_descricao   AS Descricao,
       --i.git_deposito         AS CD,
       q.get_cod_local1 As lojas,
       rmsto_date( q.get_dt_ult_ent) AS Dt_Ult_Ent,
       q.get_ult_qtd_ent as Qtde_Ult_Ent,
       rmsto_date( q.get_dt_ult_fat) AS Dt_Ult_Sai,
       q.get_estoque AS Saldo_Fiscal,
       q. GET_VEND_ACUM_ANO as Saida_Media,
       q.get_cus_ult_ent As Cus_Ult_Ent,
       i.git_secao as secao,
       i.git_tpo_emb_transf as Tpo_Emb_Transf,
       i.git_emb_transf as Emb_Transf,
       (SELECT SUM(l.les_qtd_estq_un)
          FROM rms.AG3CLEST l
         WHERE l.les_deposito = q.get_cod_local
           AND l.les_cod_entidade = q.get_cod_local
           AND l.les_produto = q.get_cod_produto
         GROUP BY l.les_produto) AS Saldo_Fisico,
       i.git_dat_sai_lin AS Data_Sai_Lin,
       (SELECT e.ncc_descricao
          FROM rms.AA3cNVCC e
         WHERE e.ncc_secao = i.git_secao
           AND e.ncc_grupo = 0
           AND e.ncc_subgrupo = 0) AS Secao,
       (SELECT e.ncc_descricao
          FROM rms.AA3cNVCC e
         WHERE e.ncc_secao = i.git_secao
           AND e.ncc_grupo = i.git_grupo
           AND e.ncc_subgrupo = 0) AS Grupo,
       (SELECT e.ncc_descricao
          FROM rms.AA3cNVCC e
         WHERE e.ncc_secao = i.git_secao
           AND e.ncc_grupo = i.git_grupo
           AND e.ncc_subgrupo = i.git_subgrupo
           AND e.ncc_categoria = 0) As subgrupo,
       q.get_bloqueio AS Bloqueio,
       i.git_sis_abast AS Sistematica,
       to_number(i.git_linha) As linha
  FROM rms.aa2cestq q
  LEFT JOIN rms.aa3citem i
    ON i.git_cod_item || i.git_digito = q.get_cod_produto
 WHERE q.GET_ESTOQUE > 0
     and rmsto_date(q.get_dt_ult_ent) between  to_date('01/03/15','dd/mm/yy') and to_date('31/05/15','dd/mm/yy')
 --  and q.get_cod_local in (1007)
--and i.git_dat_sai_lin = 0
--and q.get_cod_local1 = 9016
--and git_linha not in (77,88)
--and q.get_cod_produto in ()
and i.git_sis_abast in (11)
--and i.git_secao in (412)
--and  q.get_cod_local1 = 35
--and q.get_cod_produto in ()
 order by 3,4,10,2
