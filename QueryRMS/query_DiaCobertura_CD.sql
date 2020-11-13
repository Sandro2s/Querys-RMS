-- Empresa : Supermercado São Roque Ltda. TI
-- Data :28/09/2017
-- Descrição : Dias de cobertura de estoque CD
-- Desenvolvido : Sandro Soares
-- Solicitante : Andersom Grisolle
-- Atualizado em :
-----------------------------------------------------------------------------------------------
--Limpa as duas tabelas temporarias
truncate table tmp_pedi;
truncate table tmp_diac;

--Inserte para usar data da digitação do pedido
insert into tmp_pedi
(select itm_det||dig_det as prod,
       nroped_car||dac(nroped_car)as nrped,
       rmsto_date (Min(dtaemi_car))as dta,
       qtdped_det,
       qtdent_det   
     
 from ag1lpedi, ag1dpedi
 where nroped_car = nroped_det
    and cloj_car = codloj_det
    and cloj_car = 100 
    and form_car = '1'
    and st1_car = 3
    and st2_car in (1,2)
   group by nroped_car, 
             dloj_car, 
             itm_det,
             dig_det,
             qtdped_det,
             qtdent_det 
      having qtdped_det != qtdent_det);

--Insert para criar os dados de analise      
insert into tmp_diac 
 (select git_cod_item||git_digito as codigo,
 
       git_descricao as descricao,
       git_sis_abast as Sist_Abast,
       rmsto_date(get_dt_ult_ent) as Dt_Ult_Ent, 
       round((get_ult_qtd_ent/git_emb_transf),1) as Qtd_Ult_Ent,
       rmsto_date(get_dt_ult_fat) as Dt_Ult_Fat,
       round((get_ult_qtd_fat/git_emb_transf),1) as Qtd_Ult_Fat,
       round((get_estoque/git_emb_transf),1) as Esq_Emb_Transf,
       round((get_qtd_pend/git_emb_transf),1) as Pend_Compra,
        F_CALCOBER(NVL(GET_ESTOQUE, 0),
                          NVL(GET_QTD_PEND, 0),
                          NVL(GET_VEND_ACUM_ANO, 0),
                          NVL(GIT_EMB_FOR, 0)) AS COB,
        round((get_vend_acum_ano/git_emb_transf),1) as Saida_media,
        git_emb_transf as Emb_Transf,
        git_cod_for||dac(git_cod_for) as Cod_For,
        RTRIM(TCMP.TAB_CONTEUDO) AS DESC_COMP,
        git_secao as Secao,
        git_linha as Linha,
        git_frq_visit as Frz_Vis,
        git_prz_entrg  as Prz_Ent
             
       
  from aa3citem,aa2cestq, aa2ctipo,AA2CTABE TCMP
   where git_cod_item||git_digito = get_cod_produto
   and  git_tipo_pro = 1
   and git_cod_for = tip_codigo
   and git_dat_sai_lin = 0
   and git_secao in (100,101,102,103,104,105,106,107,108,109,110,111,112,200,201,300,301,302,306,400,401,504)
   and git_sis_abast in (1,10,11,20)
   and get_cod_local = 1007
   and  TCMP.TAB_CODIGO(+) = 001
   and TCMP.TAB_ACESSO(+) = TO_CHAR(GIT_COMPRADOR, 'FM000') || '       ');

--Retorno da consulta das duas tabelas.   
 select distinct(to_number(codigo)) as codigo,
        descricao,
        dt_ult_ent, 
        qtd_ult_ent,
        dt_ult_fat,
        qtd_ult_fat, 
        est_emb_transf,
       Min(dta) as Dta_Ant_Pedi,
        pend_compra, 
        cob,
        saida_media,
        emb_transf,
        cod_for,
        desc_comp,
        sist_abast,
        secao,
       to_number(linha) as linha,
        frz_vis,
        prz_ent,
        ees.endereco as endereco
  
 from tmp_diac, tmp_pedi, (select ees_prod_rese, 
         ees_galpao||'.'||
         Lpad(ees_rua,3,0)||'.'||
         Lpad(ees_nro,3,0)||'.'||
         Lpad(substr(ees_apt,1,1),2,0)||'.'||
         substr(ees_apt,2) as endereco, 
         ees_tipo_endereco_1
           from AG3CEEST
           where ees_tipo_endereco_1 = 1)ees
  where codigo  = prod(+)    
  and codigo = ees.ees_prod_rese(+)
  group by codigo,
        descricao,
        dt_ult_ent, 
        qtd_ult_ent,
        dt_ult_fat,
        qtd_ult_fat, 
        est_emb_transf,
        pend_compra, 
        cob,
        saida_media,
        emb_transf,
        cod_for,
        desc_comp,
        sist_abast,
        secao,
        linha,
        frz_vis,
        prz_ent,
        ees.endereco 
   
   
 
  
   
/*  
  select git_cod_item||git_digito as codigo,
       git_descricao as descricao,
       git_sis_abast as Sist_Abast,
       rmsto_date(get_dt_ult_ent) as Dt_Ult_Ent, 
       (get_ult_qtd_ent/git_emb_transf) as Qtd_Ult_Ent,
       rmsto_date(get_dt_ult_fat) as Dt_Ult_Fat,
       round((get_ult_qtd_fat/git_emb_transf),1) as Qtd_Ult_Fat,
       (get_estoque/git_emb_transf) as Esq_Emb_Transf,
        get_qtd_pend as Pend_Compra,
        F_CALCOBER(NVL(GET_ESTOQUE, 0),
                          NVL(GET_QTD_PEND, 0),
                          NVL(GET_VEND_ACUM_ANO, 0),
                          NVL(GIT_EMB_FOR, 0)) AS COB,
        round((get_vend_acum_ano/git_emb_transf),1) as Saida_media,
        git_emb_transf as Emb_Transf,
        git_cod_for as Cod_For,
        RTRIM(TCMP.TAB_CONTEUDO) AS DESC_COMP,
        git_secao as Secao,
        git_linha as Linha,
        git_frq_visit as Frz_Vis,
        git_prz_entrg  as Prz_Ent
             
       
  from aa3citem,aa2cestq, aa2ctipo,AA2CTABE TCMP
   where git_cod_item||git_digito = get_cod_produto
   and git_cod_for = tip_codigo
   and git_dat_sai_lin = 0
   and git_secao in (100,101,102,103,104,105,106,107,108,109,110,111,112,200,201,302,306,400,504)
   and git_sis_abast in (1,10,11)
   and get_cod_local = 1007
   and  TCMP.TAB_CODIGO(+) = 001
   and TCMP.TAB_ACESSO(+) = TO_CHAR(GIT_COMPRADOR, 'FM000') || '       '*/
   

  
  
