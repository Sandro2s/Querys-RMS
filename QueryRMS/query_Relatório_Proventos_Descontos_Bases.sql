-- Empresa : Supermercado São Roque Ltda.
-- Data :24/07/2015 
-- Atualizado em : 24/07/2014
-- Desenvolvedor : Felipe Rodrigues
-- Solicitante : Solange Pinheiro
-- Descrição : Retorna valor por loja e verba do protheus.
--             Rodar no banco do Protheus (protprd@protprd/protheus)  
--             Rodar no banco  replica (protrep@protrep/protrep)


---------------Por tipo de Verba Somente----------------------------
select 
      substr(rd_filial,3,2) as Loja
      ,rd_pd as Cod_Verba
      ,rtrim(od.rv_desc) as Desc_Verba
      ,sum(rd_valor) as Valor 
      ,decode(od.rv_tipocod,1,'1 - Provento',2,'2 - Descontos',3,'3 - Bases')as Tipo_Verba-- as Prov_1_Desc_2_Base_3
      
from srd010,(select rv_cod,rv_desc,rv_tipocod from srv010 ) od
      where  rd_datarq ='&DATAyyyymm'
      and od.rv_cod = rd_pd       
group by rd_filial,rd_pd,od.rv_desc,od.rv_tipocod
order by loja,rd_pd,od.rv_tipocod;

------Por Loja / Centro de Custo ----------------------------
select 
       rd_filial as Loja -- substr(rd_filial,3,2) as Loja  Substr serve para tirar o começo ou o final onde 3 é onde começa e 2 quantas casas aparece
      ,rd_cc as Centro_de_Custo
      ,rtrim(ct.ctt_desc01) as Desc_Centro
      ,rd_pd as Cod_Verba
      ,rtrim(od.rv_desc) as Desc_Verba  
      ,sum(rd_valor) as Valor 
     ,decode(od.rv_tipocod,1,'1 - Proventos',2,'2 - Descontos',3,'3 - Bases') as Tipo_Verba 
 
from srd010,(select rv_cod,rv_desc,rv_tipocod from srv010 ) od, (select ctt_custo,ctt_desc01,D_E_L_E_T_ from ctt010) ct
      where  rd_datarq ='&DATAyyyymm'
      and    od.rv_cod = rd_pd 
      and    ct.ctt_custo = rd_cc
      and    ct.D_E_L_E_T_ <> to_char('*')
group by rd_filial,rd_cc,rd_pd,od.rv_desc,od.rv_tipocod,ct.ctt_desc01
order by rd_filial,rd_pd,od.rv_tipocod,rd_cc,ct.ctt_desc01;

------Completo ----------------------------------------------------------
Select 
      substr(rd.rd_filial,3,2) as Loja -- Substr serve para tirar o começo ou o final onde 3 é onde começa e 2 quantas casas aparece
      ,rd.rd_cc as Centro_de_Custo
      ,rtrim(ctt.ctt_desc01) as Desc_Centro
      ,rd.rd_mat  as Matricula 
      ,rtrim(ra.ra_nome) as Nome  -- Nome está relacionda  com a Tabela SRA010
      ,rd.rd_pd as Cod_Verba
      ,rtrim(rv.rv_desc) as Desc_Verba 
      ,sum(rd.rd_valor) as Valor
      ,decode(rv.rv_tipocod,1,'1 - Proventos',2,'2 - Descontos',3,'3 - Bases') as Tipo_Verba  
 from 
(select * from srd010 where rd_datarq = '&DATAyyyymm'  )rd,
(select ra_filial,ra_mat,ra_nome,D_E_L_E_T_  from sra010 where d_e_l_e_t_ <> to_char('*'))ra, 
(select rv_cod,rv_desc,rv_tipocod,D_E_L_E_T_  from srv010 where d_e_l_e_t_ <> to_char('*'))rv,
(select ctt_custo,ctt_desc01,D_E_L_E_T_  from ctt010 where d_e_l_e_t_ <> to_char('*'))ctt


where rd.rd_mat = ra.ra_mat
 and rd_filial = ra_filial
 and rd.rd_cc = ctt.ctt_custo
 and rd.rd_pd = rv_cod
group by rd.rd_filial,rd.rd_pd,rv.rv_desc,rv.rv_tipocod,rd.rd_cc,rd.rd_mat,ra.ra_nome,ctt.ctt_desc01
order by loja,rd.rd_pd,rv.rv_tipocod,ra.ra_nome,rd.rd_cc,ctt.ctt_desc01;


