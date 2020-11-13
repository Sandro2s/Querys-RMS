
---Produtos que NCM são de aliquota Zero (0).
Select * from
(
select  git_cod_item||git_digito as Codigo
       ,git_descricao as descricao
       ,git_secao as Secao
       ,det_class_fis as Classif_Fiscal
       ,rmsto_date( git_dat_sai_lin)as Dta_Fora_linha 
       ,decode (git_class_fis,0,'Normal',1,'Antecipado',2,'Zero',3,'Isento',4,'Presumido',5,'Aliq.Diferenciada') as PisCofins
  from aa1ditem
     inner join aa3citem on git_cod_item = det_cod_item
     where git_cod_item > 0
     and det_class_fis in ('08119000','07039090','11022000','11062000','07061000','08132010'
                            ,'10062010','10063021','07133399','07362000','08045020','07020000'
                            ,'07133900','19021100','11031300','10083090','10059090')
         order by secao,classif_fiscal,descricao )
         
           where dta_fora_linha > to_date('01/02/2012','dd/mm/yyyy')  or dta_fora_linha is null ;

--==========================================================================================================
-- Produtos com Suspensão da Contribuição  Social.
Select * from
(
select  git_cod_item||git_digito as Codigo
       ,git_descricao as descricao
       ,git_secao as Secao
       ,det_class_fis as Classif_Fiscal
       ,rmsto_date( git_dat_sai_lin)as Dta_Fora_linha 
       ,decode (git_class_fis,0,'Normal',1,'Antecipado',2,'Zero',3,'Isento',4,'Presumido',5,'Aliq.Diferenciada') as PisCofins
  from aa1ditem
     inner join aa3citem on git_cod_item = det_cod_item
     where git_cod_item > 0
     and det_class_fis in ('10083090','10059090','10082090','12010090','02109900')
         order by secao,classif_fiscal,descricao )
         
           where dta_fora_linha > to_date('01/02/2012','dd/mm/yyyy')  or dta_fora_linha is null ;

--===============================================================================================================
-- Produtos aquiridos de bens para revenda sujeitos à incidência Monofásica da contribuição Social.
Select * from
(
select  git_cod_item||git_digito as Codigo
       ,git_descricao as descricao
       ,git_secao as Secao
       ,det_class_fis as Classif_Fiscal
       ,rmsto_date( git_dat_sai_lin)as Dta_Fora_linha 
       ,decode (git_class_fis,0,'Normal',1,'Antecipado',2,'Zero',3,'Isento',4,'Presumido',5,'Aliq.Diferenciada') as PisCofins
  from aa1ditem
     inner join aa3citem on git_cod_item = det_cod_item
     where git_cod_item > 0
     and det_class_fis in ('22089000','33072090','22071000','33049910','33043000','34011190','33049990'
                          ,'33059000','33051090','33074900')
         order by secao,classif_fiscal,descricao )
         
           where dta_fora_linha > to_date('01/02/2012','dd/mm/yyyy')  or dta_fora_linha is null 
