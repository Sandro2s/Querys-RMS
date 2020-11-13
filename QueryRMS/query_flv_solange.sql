-- Empresa : Supermercado São Roque Ltda.
-- Data : 29/07/2009
-- Atualizado em : 24/08/2009
-- Desenvolvedor : Sandro Soares.
-- Descrição : Gerar duas planilhas de acompanhamento da sugestão do programa FLV.
--             Gera uma extrasão por loja e uma apenes para loja da Grill pegando o estoque
--             do RMS no dia, antes da atualização da nota fiscal.

select ch_pri_loja as Loja,
       git_cod_item || '-' || git_digito as Codigo,
       desc_grupo as Grupo,
       git_descricao as Descricao,
       sugestao,
       qtd_comprada as Compras,
       estoque,
      (venda_media),
       
       sum(qtd_comprada - sugestao) as Diferenca
  from tb_spc_sugestao_pedido_ceasa
 where data_pedido = to_date('28/07/2009', 'dd/mm/yy')
 and ch_pri_loja not in ( 132,175,388 )
 and git_cod_item || git_digito = 10707 
 group by ch_pri_loja,
          git_cod_item || '-' || git_digito,
          sugestao,
          qtd_comprada,
          git_descricao,
          desc_grupo,
          estoque,
          venda_media
 order by ch_pri_loja, desc_grupo, git_descricao;
 
-- Acompanhamento do FLV da loja Grill.Esta query deve ser rodada antes da 11:00hs da manhã para pegar 
-- o estoque do dia antes da entrada da nota fiscal. 

 select max(Loja)      as Loja,
       max(codigo)    as Codigo,
       max(grupo)     as Grupo,
       max(descricao) as Descricao,
       max(sugestao)  as Sugestao,
       sum(Compras)   as Compras,
       sum(Estq_RMS)  as Est_RMS,
       sum(Diferenca) as Diferenca, 
       sum(Est_Trans) as Est_Trans 

from


(select ch_pri_loja as Loja,
       git_cod_item || '-' || git_digito as Codigo,
       desc_grupo as Grupo,
       git_descricao as Descricao,
       sugestao,
       qtd_comprada as Compras,
       sum (es.get_estoque/und_compra) as Estq_RMS,
       sum (qtd_comprada - sugestao) as Diferenca,
       0 as Est_Trans
         
  from tb_spc_sugestao_pedido_ceasa, aa2cestq es 
 where data_pedido =  to_date('&Data_Atual', 'dd/mm/yy')
 and ch_pri_loja = 27 --not in ( 132,175,388 )
 and git_cod_item||git_digito  = es.get_cod_produto
 and ch_pri_loja = get_cod_local 
 group by ch_pri_loja,
          git_cod_item || '-' || git_digito,
          sugestao,
          qtd_comprada,
          git_descricao,
          desc_grupo,
          estoque
 
 Union
 
select ch_pri_loja as Loja,
       git_cod_item || '-' || git_digito as Codigo,
       desc_grupo as Grupo,
       git_descricao as Descricao,
        0,
        0 as Compras,
        0 as Estq_RMS,
        0 as Diferenca,
       qtd_comprada as Est_Trans
       
  from tb_spc_sugestao_pedido_ceasa, aa2cestq es 
 where data_pedido =  to_date('&Data_Estoque_Transito', 'dd/mm/yy')
 and ch_pri_loja = 27 --not in ( 132,175,388 )
 and git_cod_item||git_digito  = es.get_cod_produto
 and ch_pri_loja = get_cod_local 
 
 group by ch_pri_loja,
          git_cod_item || '-' || git_digito,
          sugestao,
          qtd_comprada,
          git_descricao,
          desc_grupo,
          estoque,
          es.get_estoque )
          
         group by codigo,Loja,grupo,descricao
         order by grupo,descricao,codigo
 
-- Original.
 /*select ch_pri_loja as Loja,
       git_cod_item || '-' || git_digito as Codigo,
       desc_grupo as Grupo,
       git_descricao as Descricao,
       sugestao,
       qtd_comprada as Compras,
       sum (es.get_estoque/und_compra) as Estq_RMS,
       sum(qtd_comprada - sugestao) as Diferenca
  from tb_spc_sugestao_pedido_ceasa, aa2cestq es 
 where data_pedido = to_date('21/08/2009', 'dd/mm/yy')
 and ch_pri_loja = 27 --not in ( 132,175,388 )
 and git_cod_item||git_digito  = es.get_cod_produto
 and ch_pri_loja = get_cod_local 
 group by ch_pri_loja,
          git_cod_item || '-' || git_digito,
          sugestao,
          qtd_comprada,
          git_descricao,
          desc_grupo,
          estoque,
          es.get_estoque
 order by ch_pri_loja, desc_grupo, git_descricao
*/
 