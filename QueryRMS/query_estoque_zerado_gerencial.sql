-- Supermercado São Roque Ltda
-- Data 15/06/08
-- Desenvolvido : Sandro Soares
-- Verificar no Gerencial quais lojas estão com o estoque zerado para serem reprocessados.

select g.cd_fil,d.dt_compl,g.qtd_estq,g.vl_estq from AGG_COML_FIL g,dim_per d where d.id_dt between  6657 and  7078
and g.id_dt = d.id_dt
and g.qtd_estq = 0
and g.cd_fil  not in ('50','51','52','53')
order by d.dt_compl,g.cd_fil;
--=============================================================================================================================
-- Soma por loja os dia que estão com estoque zerado

select g.cd_fil,count(d.dt_compl),g.qtd_estq,g.vl_estq from AGG_COML_FIL g,dim_per d where d.id_dt between  6657 and  7078
and g.id_dt = d.id_dt
and g.qtd_estq = 0
and g.cd_fil  not in ('50','51','52','53')
Group by g.cd_fil,g.qtd_estq,g.vl_estq;

--==============================================================================================================================
-- Soma quantos dias tem que ser reprocessado por cada mes e mostra isso por loja.

select g.cd_fil,count(d.dt_compl),d.id_mes from AGG_COML_FIL g,dim_per d where d.id_dt between  6657 and  6939
and g.id_dt = d.id_dt
and g.qtd_estq = 0
and g.cd_fil  not in ('50','51','52','53')
Group by g.cd_fil,g.qtd_estq,g.vl_estq,d.id_mes;

--Select * from dim_per where ano=2009 --dt_aamd = 20050425

