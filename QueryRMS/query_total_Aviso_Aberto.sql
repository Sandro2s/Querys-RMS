-- Empresa : Supermercado São Roque Ltda.
-- Data : 13/03/2010
-- Atualizado em : 30/05/2011
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Santino
-- Descrição : Relatório dos avisos aberto no CD.
-- Obs.: Status faturado(200),com aviso(100),notificado(1)

-- Avisos em Aberto
Select a.codigo||dac(a.codigo) as Codigo, 
       ti.tip_razao_social as descricao, 
       a.aviso, 
       sum(a.total) as Soma
  from (select ag.cd_fornec_fat as codigo,
               ag.cd_ord_col as Aviso,
               ag.cd_prod as produto,
               ag.qtde_mvto as quant,
               ag.cd_custo as custo,
               (ag.qtde_mvto * round(ag.cd_custo, 3)) as Total
          from ag3ttrdv ag
         where ag.cd_ent_estq = 100
           and ag.cd_fil_origem >= 1
           and ag.sts_atu = 100
         --  and rms7to_date(ag.dt_mvto) <  to_char(add_months(to_date(sysdate),-1))
         /*and ag.cd_ord_col = 50900*/) a,
       aa2ctipo ti
 where ti.tip_codigo = a.codigo
   and ti.tip_codigo > 0
 Group by a.codigo, ti.tip_razao_social,a.aviso; --,a.dt_mvto
 --============================================================================
 -- Noticados com Custo Ultima Entrada.
 Select  max(to_number(cd_fornec_fat||dac(cd_fornec_fat))) as cod_for
       ,max (tip_nome_fantasia) as Razao
       ,round(sum(qtde_mvto * est.Cus_ult),3) as Valor_Notificado
 from ag3ttrdv,aa2ctipo,
    (select get_cod_produto as Prod
       ,get_cus_med as Cus_Med
       ,get_cus_ult_ent as Cus_ult 
   from aa2cestq 
   where get_cod_local = 1007 )est
  where cd_ent_estq = 100
 and cd_fil_origem >= 1
 and sts_atu = 1
 and tip_codigo = cd_fornec_fat
 and cd_fornec_fat = tip_codigo
 and to_number(cd_prod||dac(cd_prod)) = est.prod
 group by cd_fornec_fat,tip_nome_fantasia
 order by razao