-- Empresa : Supermercado São Roque Ltda. TI
-- Data :12/09/2017
-- Descrição : Verifica as transferencia do almoxarifado para as lojas e as devoluções da loja para o CD.
--             Tambem gera quantidade comprada com estoque real no dia da emissão do relatório.
-- Desenvolvido : Sandro Soares
-- Solicitante : Andersom Grisolle
-- Atualizado em :

Select Loja,
       codigo,
       descricao,
       secao,
       grupo,
       sum (qt_tr) as Qt_Transf,
       sum (cs_tr) as Custo_Transf,
       sum (Qt_De) as Qt_Devol, 
       sum (Cs_De) as Custo_Devol,
       sum(qt_tr - qt_de) as Consumo,
       sum(cs_tr - cs_de) as Custo_Consumo
from 

(
---Transferencia
select --eschljc_codigo3||eschljc_digito3 as Loja_origem,
       to_number(esclc_codigo||esclc_digito)  as Loja, 
       to_number(esitc_codigo||esitc_digito) as Codigo,
       prod.git_descricao as descricao,
       eschc_secao3 as Secao,
       eschc_grupo3 as Grupo,
       (entsaic_quanti_un /git_emb_transf) as Qt_Tr,
       (entsaic_prc_un * entsaic_quanti_un) as Cs_Tr,
       0 as Qt_De,
       0 as Cs_De 
   
 from ag1iensa, (select git_cod_item ,git_descricao,git_emb_transf  from aa3citem where git_secao in (500,501)) prod
 where eschc_data between dateto_rms7(to_date('&Dta_Inicial','dd/mm/yyyy')) and dateto_rms7(to_date('&Dta_Final','dd/mm/yyyy'))--eschc_data  between 1150901 and 1170831
  and eschc_agenda in (47,48,57,669,910)
  and eschc_secao3 in (500,501)
  and eschljc_codigo3 = 100
  and  esitc_codigo = prod.git_cod_item
  
  Union All
  ---Devolução
  select to_number(eschljc_codigo3||eschljc_digito3) as Loja,
       to_number(esitc_codigo||esitc_digito) as Codigo,
       prod.git_descricao as descricao,
       eschc_secao3 as Secao,
       eschc_grupo3 as Grupo,
       0 as Qt_Tr,
       0 as Cs_Tr,
       (entsaic_quanti_un /git_emb_transf) as Qt_De,
       (entsaic_prc_un * entsaic_quanti_un) as Cs_De
   
 from ag1iensa, (select git_cod_item ,git_descricao,git_emb_transf  from aa3citem where git_secao in (500,501)) prod
 where eschc_data between dateto_rms7(to_date('&Dta_Inicial','dd/mm/yyyy')) and dateto_rms7(to_date('&Dta_Final','dd/mm/yyyy')) --eschc_data   between 1150901 and 1170831
  
  and eschc_agenda in (43,741,734,735)
  and eschc_secao3 in (500,501)
  and  esclc_codigo = 100
  and  esitc_codigo = prod.git_cod_item
  )
   --where codigo = 1694820--IN (1916025,2000776)
  Group by Loja,
           codigo,
           descricao,
           grupo,
           secao
  order by 1,2,3,5,6;
--------------------------------------------------------------------------------------------------------------------------------------  
  --Compra e estoque
select to_number(esclc_codigo||esclc_digito)  as Loja, 
       to_number(esitc_codigo||esitc_digito) as Codigo,
       prod.git_descricao as descricao,
       eschc_secao3 as Secao,
       eschc_grupo3 as Grupo,
    --   eschc_nro_nota3,
       (get_estoque /git_emb_for)  as estoque,
      sum(entsaic_quanti_un /git_emb_for) as Qta_Compra,
      sum(entsaic_prc_un * entsaic_quanti_un) as Custo_Compra
         
 from ag1iensa, (select git_cod_item ,git_descricao,git_emb_for  from aa3citem where git_secao in (500,501)) prod, aa2cestq
 where eschc_data between dateto_rms7(to_date('&Dta_Inicial','dd/mm/yyyy')) and dateto_rms7(to_date('&Dta_Final','dd/mm/yyyy')) --between 1150901 and 1170831
  and eschc_agenda in (6,7)
  and eschc_secao3 in (500,501)
  and esclc_codigo = 100 
  and esitc_codigo = prod.git_cod_item
  and esitc_codigo||esitc_digito = get_cod_produto
  and get_cod_local = 1007 
  group by esclc_codigo,
           esclc_digito,
           esitc_codigo,
           esitc_digito,
           prod.git_descricao,
           eschc_secao3,
           eschc_grupo3,
           get_estoque, 
           git_emb_for
