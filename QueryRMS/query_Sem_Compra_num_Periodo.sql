-- Empresa : Supermercado São Roque Ltda.
-- Data :27/12/2010 
-- Atualizado em : 27/12/2010
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Regina Rosa ( Compras)
-- Descrição : Verificar produtos de uma secao que não tenha entrada na loja em um periodo.


Select egit.cod as "Codigo RMS",
       egit.git_descricao as "Descrição",
       rmsto_date( eget.get_dt_ult_ent) as "Ult.Entrada"


 from (
      select git_cod_item||git_digito as cod,
             git_descricao
            from aa3citem 
              where git_dat_sai_lin = 0 
              and git_secao = 401
              and  git_dat_ult_fat not like '%__10') egit,
       ( 
       select get_cod_produto,
              get_dt_ult_ent
              from aa2cestq where get_cod_local = 1007)eget

where egit.cod = eget.get_cod_produto
               

        
        