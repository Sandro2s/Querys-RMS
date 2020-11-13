-- Empresa : Supermercado São Roque Ltda.
-- Data : 18/11/11 
-- Desenvolvedor : Sandro Soares
-- Descrição : Traz o pis/cofins das carnes.
-- Manutenção em : 20/03/2012

--Movimento de compra dividida por Carne branca e vermelha utilizando como base o NCM do produto e o CFOP da operação.
--As datas devem ser digitadas no padrão invertido da RMS.
select pisi_org as Loja
       ,sum(base_cv)as Carne_Vermelha
       ,sum(base_cb)as Carne_Branca
     from
(
select  pisi_org
        ,case when  cv > 0 then nvl(sum(pisi_pis_bas),0)end Base_CV
        ,case when  cb > 0 then nvl(sum(pisi_pis_bas),0) end Base_CB
       

         from 
(
   (
select to_number(det_cod_item) as cod,
             git_descricao,
             Case
             when det_class_fis in ( 2013000,2031900,2062910,2069000,2101100,2101200,2101900,2103000,2109900) then det_class_fis end CV,
            Case
            when det_class_fis in (2012010,2032200,2012090,2019000,2022020,2022090,2023000,2031100,2061000,2062100,2062200,2062900,2062990,2071400,2102000,2103000,2102000) then det_class_fis end CB
        from aa1ditem
       inner join aa3citem on git_cod_item = det_cod_item
       where git_secao in (302,305)
        and det_class_fis in (2013000,2031900,2062910,2069000,2101100,2101200,2101900,2102000,2103000,2109900,2012010,2032200,2012090,2019000,2022020,2022090,2023000,2031100,2061000,2062100,2062200,2062900,2062990,2071400,2103000)
      group by det_class_fis,det_cod_item,git_descricao
      )item inner join
         (select *
                from aa2cpisi 
                  where pisi_dta between '&Dta_Inicial' and '&Dta_Final' --    where pisi_dta between ''1110601 and ''1110630 
                  and pisi_agd > 0
                  and pisi_org > 0
                  and pisi_cfo in (5101,5102,5403,6101,6102)
                  and pisi_pis_val > 0
                  and pisi_cof_val > 0 
          )piscof  on cod = pisi_ite ) group by pisi_org,cv,cb,pisi_pis_bas ) group by pisi_org


--Movimento de Venda dividida por Carne branca e vermelha utilizando como base o NCM do produto e o CFOP da Operação.
--As datas devem ser digitadas no padrão invertido da RMS.
select pisi_dst as Loja
       ,sum(base_cv)as Carne_Vermelha
       ,sum(base_cb)as Carne_Branca
     from
(
select  pisi_dst
        ,case when  cv > 0 then nvl(sum(pisi_pis_bas),0)end Base_CV
        ,case when  cb > 0 then nvl(sum(pisi_pis_bas),0) end Base_CB
       

         from 
(
   (
select to_number(det_cod_item) as cod,
             git_descricao,
             Case
             when det_class_fis in ( 2013000,2031900,2062910,2069000,2101100,2101200,2101900,2103000,2109900) then det_class_fis end CV,
            Case
            when det_class_fis in (2012010,2032200,2012090,2019000,2022020,2022090,2023000,2031100,2061000,2062100,2062200,2062900,2062990,2071400,2102000,2103000,2102000) then det_class_fis end CB
        from aa1ditem
       inner join aa3citem on git_cod_item = det_cod_item
       where git_secao in (302,305)
        and det_class_fis in (2013000,2031900,2062910,2069000,2101100,2101200,2101900,2102000,2103000,2109900,2012010,2032200,2012090,2019000,2022020,2022090,2023000,2031100,2061000,2062100,2062200,2062900,2062990,2071400,2103000)
      group by det_class_fis,det_cod_item,git_descricao
      )item inner join
         (select *
                from aa2cpisi 
                  where pisi_dta between '&Dta_Inicial' and '&Dta_Final' --    where pisi_dta between ''1110601 and ''1110630 
                  and pisi_agd > 0
                  and pisi_dst > 0
                  and pisi_cfo in (1102,1101,1403,2101,2403)
                  and pisi_pis_val > 0
                  and pisi_cof_val > 0 
          )piscof  on cod = pisi_ite ) group by pisi_dst,cv,cb,pisi_pis_bas ) group by pisi_dst




-- Movimento de compras. As data devem ser digitada no padrão invertido da RMS
select  max(mes) as "Mês"
       ,loja as "Loja"
       ,sum (base_cal)  as "Base Calculo"
       ,sum (al_pis)    as "Pis Aliq 1,65%"
       ,sum (al_cofins) as "Cofins Aliq 7,60%"
 from 
(
Select   dta                as Mes 
        ,pisi_dst           as Loja
       -- ,cod                as Codigo
       -- ,git_descricao      as Descricao
        ,sum(qtd)           as Quant
        ,sum(v_base_pis)    as Base_Cal
        ,sum(v_total_pis)   as al_pis 
       -- ,sum(v_base_cofins) as "Base Cal.Cofins"
        ,sum(v_total_cofins)as al_cofins 
        
          
 from
    (

    select to_number(det_cod_item||dac(det_cod_item))as cod
           ,git_descricao
           ,det_class_fis
           ,git_secao
           from aa1ditem inner join aa3citem on  git_cod_item = det_cod_item
           where --det_cod_item > 0 
              det_class_fis like '203%' or det_class_fis like'2063%' 
                             or det_class_fis like'2064%' or det_class_fis like'207%'
                             or det_class_fis like'2101%' or det_class_fis like'21099%'
           
      )item inner join
 (
 select (pisi_ite||dac(pisi_ite)) as item
       ,(pisi_dst)
      -- ,pisi_age
       , to_char(rms7to_date(pisi_dta),'Month') as dta
      -- ,pisi_sec
      -- ,pisi_nta
       ,nvl(sum(pisi_qtd),0) as qtd
       --,pisi_cfo
       ,nvl(sum(pisi_pis_bas),0) as v_base_pis
       ,nvl(sum(pisi_pis_val),0) as v_total_pis
       --,nvl(sum(pisi_cof_bas),0) as v_base_cofins
       ,nvl(sum(pisi_cof_val),0) as v_total_cofins
  from aa2cpisi 
    where pisi_dta between '&Dta_Inicial' and '&Dta_Final' --    where pisi_dta between ''1110601 and ''1110630 
    and pisi_agd > 0
    and pisi_org > 0
    and pisi_cfo in (1102,1101,1403,2101,2403)
    and pisi_sec in (112,301,302,303,305,504)
    and pisi_pis_val > 0
    and pisi_cof_val > 0
    group by pisi_ite,pisi_dta,pisi_dst )piscof on cod = item 
      group by dta,pisi_dst,cod,git_descricao
      order by Loja--,Descricao;
  )
 group by loja
 
 
 -------------------------------------------------------------------------------------------------------------------------------------   
 -- Movimento de Vendas. As data devem ser digitada no padrão invertido da RMS
select  max(mes) as "Mês"
       ,loja as "Loja"
       ,sum (base_cal)  as "Base Calculo"
       ,sum (al_pis)    as "Pis Aliq 1,65%"
       ,sum (al_cofins) as "Cofins Aliq 7,60%"
from
(
Select   dta                as Mes 
        ,pisi_org           as Loja
       -- ,cod                as Codigo
       -- ,git_descricao      as Descricao
        ,sum(qtd)           as Quant
        ,sum(v_base_pis)    as base_cal
        ,sum(v_total_pis)   as al_pis 
       -- ,sum(v_base_cofins) as "Base Cal.Cofins"
        ,sum(v_total_cofins)as al_cofins 
        
          
 from
    (

    select to_number(det_cod_item||dac(det_cod_item))as cod
           ,git_descricao
           ,det_class_fis
           ,git_secao
           from aa1ditem inner join aa3citem on  git_cod_item = det_cod_item
           where --det_cod_item > 0 
              det_class_fis like '203%' or det_class_fis like'2063%' 
                             or det_class_fis like'2064%' or det_class_fis like'207%'
                             or det_class_fis like'2101%' or det_class_fis like'21099%'
           
      )item inner join
 (
 select (pisi_ite||dac(pisi_ite)) as item
       , pisi_org
      -- ,pisi_age
       , to_char(rms7to_date(pisi_dta),'Month') as dta
      -- ,pisi_sec
      -- ,pisi_nta
       ,nvl(sum(pisi_qtd),0) as qtd
       --,pisi_cfo
       ,nvl(sum(pisi_pis_bas),0) as v_base_pis
       ,nvl(sum(pisi_pis_val),0) as v_total_pis
       --,nvl(sum(pisi_cof_bas),0) as v_base_cofins
       ,nvl(sum(pisi_cof_val),0) as v_total_cofins
  from aa2cpisi 
    where pisi_dta between '&Dta_Inicial' and '&Dta_Final' --    where pisi_dta between ''1110601 and ''1110630 
    and pisi_agd > 0
    and pisi_org > 0
    and pisi_cfo in (5101,5102,5403,6101,6102)
    and pisi_sec in (112,301,302,303,305,504)
    and pisi_pis_val > 0
    and pisi_cof_val > 0
    group by pisi_ite,pisi_dta,pisi_org) piscof on cod = item 
      group by dta,pisi_org,cod,git_descricao
      order by Loja
 )
 group by loja