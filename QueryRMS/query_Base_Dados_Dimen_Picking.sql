select  distinct (aa.git_cod_item||aa.git_digito) as codigo
       ,decode(aa.git_sis_abast,1,'01-Deposito',10,'10-Compra loja Centralizada',11,'11-Crossdockin',20,'20-Compra direto na loja')as Sistematica
       ,decode(aa.git_depto,1,'1-Alimentos',2,'2-Higiene',3,'3-Perecivel',4,'4-Bazar/Magazine') as depto
       ,decode(aa.git_secao,100,'100-Molhos e Codimentos'
                           ,101,'101-Pet Shop'
                           ,102,'102-Bomboniere'
                           ,103,'103-Oleos e Azeites'
                           ,104,'104-Bebidas'
                           ,105,'105-Matinais'
                           ,106,'106-Mercearia Salgada'
                           ,107,'107-Mercearia Doce'
                           ,108,'108-Biscoitos'
                           ,109,'109-Cereais e Empacotados'
                           ,111,'111-Dieteticos e Naturais'
                           ,112,'112-Sazonal'
                           ,200,'200-Perfumaria'
                           ,201,'201-Limpeza'
                           ,300,'300-Hortifruti-Granjeiro'
                           ,301,'301-Congelado'
                           ,302,'302-Frios e Laticinios'
                           ,303,'303-Rotisserie'
                           ,304,'304-Lanchonete'
                           ,305,'305-Açougue'
                           ,306,'306-Padaria'
                           ,400,'400-Utilidades'
                           ,401,'401-Brinquedos'
                           ,402,'402-Escolar'
                           ,403,'403 - Brindes/Degustação' ) as secao
       ,aa.git_tpo_emb_for Tipo_Emb
       ,ean.ean_cod_ean DUN
       ,aa.git_altura_emb as altura
       ,aa.git_largura_emb as Largura
       ,aa.git_comprimento_emb as Comprimento
       ,aa.git_base_pallet as Lastro
       ,aa.git_altura_pallet as Camada_Embal
       ,(aa.git_altura_pallet * aa.git_base_pallet)as Norma_Paletizacao
       ,aa.git_descricao as Descricao
       ,aa.git_emb_for as Emb_Fornec
       ,aa.git_emb_transf as Emb_Tranf
       ,aa.git_peso as Peso
       ,rmsto_date(aa.git_dat_ent_lin) as Periodo_Inicial
       ,rmsto_date(aa.git_dat_sai_lin) as Periodo_Final
       ,aa.git_estq_dp as Estoque
       ,est.qtda_transf_saida
       ,est.vlr_transf_saida

 from aa3citem aa Left outer join (select ean_cod_pro_alt,ean_cod_ean from aa3ccean where ean_tipo_ean = 'D') ean
         on aa.git_cod_item||aa.git_digito  = ean.ean_cod_pro_alt,

         (
           select agg.cd_prod as cod
                  ,sum(agg.qtd_transf_sai) as Qtda_Transf_Saida
                  ,sum(agg.vl_transf_sai)  as Vlr_Transf_Saida
                from agg_mvto_prod agg, dim_per dim
               where cd_fil = 100
               and agg.id_dt = dim.id_dt
               and dim.id_mes between 201409 and 201411
               group by agg.cd_prod

         )est

  where aa.git_sis_abast in (01,11)
    --and aa.git_dat_sai_lin = 0
    and aa.git_depto in (1,2,3,4)
    and aa.git_secao not in (402,500,600,601,602,603,604,605,606,607,608)
    and est.cod = aa.git_cod_item

------------------------------------------------------------------------------------------------------------------------------------------------
select cd_prod || dac(cd_prod) as cod,
       sum(qtd_transf_sai) / 5 as Trans_Saida
  from agg_mvto_prod_mes
 where id_mes between 201401 and 201405
   --and cd_fil = 100
 group by cd_prod
  
  /*select count(*) from aa3citem
   where git_sis_abast = 01 
   and git_dat_sai_lin = 0
   and git_depto in (1,2,3,4) */


------------------------------------------------------------------------------------------------------------------------------------------------
/*select  distinct (aa.git_cod_item||aa.git_digito) as codigo
       ,decode(aa.git_sis_abast,1,'01-Deposito',10,'10-Compra loja Centralizada',11,'11-Crossdockin',20,'20-Compra direto na loja')as Sistematica
       ,decode(aa.git_depto,1,'1-Alimentos',2,'2-Higiene',3,'3-Perecivel',4,'4-Bazar/Magazine') as depto
       ,decode(aa.git_secao,100,'100-Molhos e Codimentos'
                           ,101,'101-Pet Shop'
                           ,102,'102-Bomboniere'
                           ,103,'103-Oleos e Azeites'
                           ,104,'104-Bebidas'
                           ,105,'105-Matinais'
                           ,106,'106-Mercearia Salgada'
                           ,107,'107-Mercearia Doce'
                           ,108,'108-Biscoitos'
                           ,109,'109-Cereais e Empacotados'
                           ,110,'110-Massas'
                           ,111,'111-Dieteticos e Naturais'
                           ,112,'112-Sazonal'
                           ,200,'200-Perfumaria'
                           ,201,'201-Limpeza'
                           ,300,'300-Hortifruti-Granjeiro'
                           ,301,'301-Congelado'
                           ,302,'302-Frios e Laticinios'
                           ,303,'303-Rotisserie'
                           ,304,'304-Lanchonete'
                           ,305,'305-Açougue'
                           ,306,'306-Padaria'
                           ,400,'400-Utilidades'
                           ,401,'401-Brinquedos'
                           ,402,'402-Escolar'
                           ,403,'403 - Brindes/Degustação' ) as secao
       ,aa.git_tpo_emb_for Tipo_Emb
       ,ean.ean_cod_ean DUN
      -- ,aa.git_altura_emb as altura
     --  ,aa.git_largura_emb as Largura
     --  ,aa.git_comprimento_emb as Comprimento
     --  ,aa.git_base_pallet as Lastro
     --  ,aa.git_altura_pallet as Camada_Embal
     --  ,(aa.git_altura_pallet * aa.git_base_pallet)as Norma_Paletizacao
       ,aa.git_descricao as Descricao
     --  ,aa.git_emb_for as Emb_Fornec
       ,aa.git_emb_transf as Emb_Tranf
     --  ,aa.git_peso as Peso
       ,rmsto_date(aa.git_dat_ent_lin) as Periodo_Inicial
       ,rmsto_date(aa.git_dat_sai_lin) as Periodo_Final
      -- ,aa.git_estq_dp as Estoque
       ,est.qtda_transf_saida
       ,est.vlr_transf_saida
       
 from aa3citem aa Left outer join (select ean_cod_pro_alt,ean_cod_ean from aa3ccean where ean_tipo_ean = 'D') ean
         on aa.git_cod_item||aa.git_digito  = ean.ean_cod_pro_alt,
         
         (
           select agg.cd_prod as cod
                  ,sum(nvl(agg.qtd_transf_sai,0)) as Qtda_Transf_Saida
                  ,sum(nvl(agg.vl_transf_sai,0))  as Vlr_Transf_Saida 
                from agg_mvto_prod agg, dim_per dim , aa3citem bb
               where cd_fil = 100
               and agg.id_dt = dim.id_dt
               and dim.id_mes between 201409 and 201411
               and bb.git_cod_item (+) = agg.cd_prod
               group by agg.cd_prod
                       
         )est
      
  where aa.git_sis_abast in (01,11)
    --and aa.git_dat_sai_lin = 0
    and aa.git_depto in (1,2,3,4)
    and aa.git_secao not in (402,500,600,601,602,603,604,605,606,607,608)
    and est.cod = aa.git_cod_item
    --and aa.git_cod_item = 195122
  
--------------------------------------------------------------------------------------------------------------------------------------------  
  
   
   */