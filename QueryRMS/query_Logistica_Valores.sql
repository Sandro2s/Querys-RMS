-- Empresa : Supermercado São Roque Ltda. TI
-- Data :14/01/2016
-- Descrição : Tras os valores para calculo da logistica
-- Solicitante : Solange Pinheiro
-- Desenvolvedor : Sandro Soares
-- Atualizado em : 14/01/2016

 Select       dt_compl               as Dta
             ,cd_fil                 as Filial 
             ,Decode(M,1,'Jan',2,'Fev',3,'Mar',4,'Abr',5,'Maio',6,'Jun',7,'Jul',8,'Ago',9,'Set',10,'Out',11,'Nov',12,'Dez') as Mes            
             ,sum(qtd_cmp)                as Qtd_Compra
             ,sum(vl_cmp)                 as Vl_compra
             ,sum(qtd_vda)                as Qtd_Venda                  
             ,sum(vl_vda)                 as Vl_Venda
             ,sum(qtd_dvol_vda)           as Qtd_Devol_vda
             ,sum(vl_dvol_vda)            as Vl_Devol_vda
             ,sum(qtd_dvol_cmp)           as Qtd_Devol_Compra
             ,sum(vl_dvol_cmp)            as Vl_Devol_Compra
             ,sum(qtd_transf_entr)        as Qtd_Transf_entr
             ,sum(vl_transf_entr)         as Vl_Transf_entr
             ,sum(qtd_bnf)                as Qtd_Bonificacao
             ,sum(vl_bnf)                 as Vl_Bonificacao
             ,sum(qtd_sobra)              as Qtd_Sobra
             ,sum(vl_sobra)               as Vl_Sobra
             ,sum(qtd_outr_entr)          as Qtd_Outras_Entradas
             ,sum(vl_outr_entr)           as Vl_Outras_Entradas
             ,sum(qtd_transf_sai)         as Qtd_Transf_Saida
             ,sum(vl_transf_sai)          as Vl_Transf_Saida
             ,sum(qtd_qbra_conh)          as Qtd_Quebra_Conhecida
             ,sum(vl_qbra_conh)           as Vl_Quebra_Conhecida
             ,sum(qtd_qbra_inv)           as Qtd_Quebra_Inventario
             ,sum(vl_qbra_inv)            as Vl_Quebra_Inventario
             ,sum(qtd_outr_sai)           as Qtd_Outras_Saida
             ,sum(vl_outr_sai)            as Vl_Outras_Saida
    from         
              
  ( Select   id_dt           
             ,dt_compl
             ,to_number(substr(id_mes,5,6)) as M
             ,cd_fil             
             ,qtd_transf_entr  
             ,vl_transf_entr   
             ,qtd_bnf          
             ,vl_bnf           
             ,qtd_dvol_vda     
             ,vl_dvol_vda                
             ,qtd_sobra        
             ,vl_sobra         
             ,qtd_outr_entr    
             ,vl_outr_entr     
             ,qtd_transf_sai   
             ,vl_transf_sai    
             ,qtd_dvol_cmp     
             ,vl_dvol_cmp      
             ,qtd_qbra_conh    
             ,vl_qbra_conh     
             ,qtd_qbra_inv     
             ,vl_qbra_inv      
             ,qtd_outr_sai     
             ,vl_outr_sai
             ,qtd_vda 
             ,vl_vda
             ,qtd_cmp
             ,vl_cmp
                       
       from agg_coml_sgrp ,
       (select id_dt as dt,dt_compl,id_mes from dim_per dim where dt_compl between to_date('&Dta_Inicial','dd/mm/yyyy') and to_date('&Dta_Final','dd/mm/yyyy'))dt,
       (select ncc_secao,ncc_grupo,ncc_descricao from aa3cnvcc where ncc_grupo   > 0 
         and ncc_subgrupo  = 0 
         and ncc_categoria = 0 and ncc_secao in (100,101,102,103,104,105,106,107,108,109,110,111,112,200,201,300,301,302,303,304,305,306,400,401,402,403,500,501,504,505,506)/*='&secao'*/ order by ncc_grupo) descgrp
        where id_dt   = dt.dt
          and cd_set = descgrp.ncc_secao
          and cd_grp = descgrp.ncc_grupo )
          
          where cd_fil  = 100
          group by cd_fil,dt_compl,m 
          order by 1,2,3




