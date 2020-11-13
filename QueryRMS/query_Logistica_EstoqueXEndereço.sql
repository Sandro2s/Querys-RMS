-- Empresa : Supermercado São Roque Ltda. TI
-- Data :23/08/2017
-- Descrição : Comparar Estoque com o  endereço.
-- Desenvolvido : Sandro Soares
-- Solicitante : Andersom Grisolle
-- Atualizado em : 

select ende.endereco,
git_cod_item||git_digito as Produto,
git_sis_abast as Sistematica,
git_descricao as Descricao,
git_emb_for as Emb_Forn,
(nvl(sum(rec.Recebimento),0))/git_emb_for as recebimento,
(nvl(sum(les.les_qtd_estq_un ),0))/git_emb_for as qtd_estq_un,
(nvl(get_estoque, 0))/git_emb_for as estoque,
(nvl(sum(carga.qtd_carga),0))/git_emb_for as qtd_carga,
(nvl(sum(catex.qtd_atendido),0))/git_emb_for as qtd_atendido,
((nvl(sum(rec.Recebimento),0)/git_emb_for) + (nvl(sum(les.les_qtd_estq_un),0))/git_emb_for)-((get_estoque/git_emb_for) + nvl(sum(catex.qtd_atendido),0)) as dif

from aa3citem, aa2cestq,
       (select les_produto, sum(les_qtd_estq_un) as les_qtd_estq_un
          From ag3clest
         where les_deposito (+) = 1007
         and   les_cod_entidade (+) = 1007
         and les_produto > 0
         and les_status <> 3
        group by les_produto) les,
       (select dix_cod_item, nvl(sum(dix_qtd_fat * dix_qtd_emb),0)  as qtd_carga
          From ag4cdfat, ag4cgfat, ag1pickl, ag1cpall
         where dix_loja = 1007
           and dix_cod_item  > 0
           and GFX_ROMANEIO = dix_romaneio
           and GFX_LOJA     = dix_loja
           and GFX_LOJA_VDA = dix_loja_vda
           and GFX_CLIENTE = dix_cliente
           and GFX_PEDIDO = dix_pedido
           and PLN_NUMERO_1 = gfx_romaneio
           and PALL_ROMANEIO = dix_romaneio
           and PALL_DEPOSITO = dix_loja
           and PALL_CLIENTE = dix_cliente
           and PALL_PEDIDO = dix_pedido
           and PALL_PALLET = dix_pallet
      group by dix_cod_item) carga,
         (select  ces_cod_item, nvl(sum(ces_qtd_und * ces_emb),0) as Recebimento
               From ag2wcest, aa1agedt
         Where ces_deposito  = 1007
              and det_loja    = ces_deposito
              and det_data    = ces_data_agenda
              and det_tipo    = ces_tpo_agenda
              and ces_alocado =  '0'
              and det_nota    = ces_nro_nota
              and det_serie   = ces_serie
              and ces_cod_item > 0
              and det_flag    = 2
         group by ces_cod_item) Rec,
       (select aten_item, nvl(sum(aten_qtd_fat * aten_qtd_emb),0)  as qtd_atendido
          From ag1catex
         where aten_loja (+) = 1007
           and aten_item  > 0
                   and aten_origem != 7
         group by aten_item) catex ,
       (select  ees_prod_rese,
       ees_galpao||'.'||Lpad(ees_rua,3,0)||'.'||Lpad(ees_nro,3,0)||'.'||Lpad(substr(ees_apt,1,1),2,0)||'.'||substr(ees_apt,2) as endereco
          from AG3CEEST
          --where ees_deposito >1
          where ees_tipo_endereco_1 = 1
          and ees_prod_rese > 0) Ende

where  git_cod_item > 0
and    git_sis_abast in (01,10,11)
and    get_cod_local = 1007
and    rec.ces_cod_item   (+)= git_cod_item
and    les.les_produto    (+)= git_cod_item||git_digito
and    carga.dix_cod_item (+)= git_cod_item
and    catex.aten_item    (+)= git_cod_item||git_digito
and    ende.ees_prod_rese (+)= git_cod_item||git_digito
and    get_cod_produto    = git_cod_item||git_digito 
and nvl(get_estoque,0) <>  nvl(les_qtd_estq_un,0)
group by git_cod_item,git_digito, git_descricao, git_emb_for, git_tpo_emb_for, get_estoque,
         git_tipo_pro,rec.recebimento,les_qtd_estq_un,catex.qtd_atendido,ende.endereco,git_sis_abast
         Having  git_sis_abast not in (10,11)
