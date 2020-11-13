-- Empresa : Supermercado São Roque Ltda.
-- Data : 20/05/10 
-- Desenvolvedor : Sandro Soares
-- Descrição : Busca movimentações na agenda de quebra e sobra em um determinado
--             Periodo, loja a loja.

Select         --Lj        as Lj,
               Loja      as Loja,
               Codigo    as Codigo,
               Descricao as Descricao,
               Secao     as Secao,
               Grupo     as Grupo,
               max(Agenda_1)       as Agenda_1,
               sum(nvl(Qtd_1,0))   as Qtd_1,
               sum(nvl(Valor_1,0)) as Valor_1,
               max(Agenda_2)       as Agenda_2,
               max(nvl(Qtd_2,0))   as Qtd_2,
               max(nvl(valor_2,0)) as Valor_2


from
(
select ie.eschljc_codigo as Lj,
               ie.eschljc_codigo||'-'||ie.eschljc_digito as Loja,
               ie.esitc_codigo1||'-'||ie.esitc_digito1 as Codigo,
               aa.git_descricao as Descricao,
               ie.eschc_secao3 as Secao,
               ie.eschc_grupo3 as Grupo,
               ie.eschc_agenda as Agenda_1,
               sum(ie.entsaic_quanti_un) as Qtd_1,
               sum(round(ie.entsaic_quanti_un * ie.entsaic_cus_un,2)) as Valor_1,
               24                               as Agenda_2,
               0                                as Qtd_2,
               0                                as Valor_2
          from AG1IENSA ie,aa3citem aa
         where ie.ESCHC_DATA between &dta_inicial and &dta_final
           and ie.ESCHC_AGENDA = 23
           and ie.eschljc_codigo not in (100,103)
           and ie.eschc_secao3 = 305 --in (302,305)
           and ie.esitc_codigo = aa.git_cod_item
         --  and aa.git_dat_sai_lin = 0
           and aa.git_secao = ie.eschc_secao3
           Group by ie.eschljc_codigo,ie.eschljc_digito,ie.esitc_codigo1,ie.esitc_digito1,
                     aa.git_descricao,ie.eschc_secao3,ie.eschc_grupo3, ie.eschc_agenda 
                     
Union

select ie.eschljc_codigo as Lj,
               ie.eschljc_codigo||'-'||ie.eschljc_digito as Loja,
               ie.esitc_codigo1||'-'||ie.esitc_digito1 as Codigo,
               aa.git_descricao as Descricao,
               ie.eschc_secao3  as Secao,
               ie.eschc_grupo3  as Grupo,
               23               as Agenda_1,
               0                as Qtd_1,
               0                as Valor_1,
               ie.eschc_agenda                  as Agenda_2,
               sum(ie.entsaic_quanti_un)        as Qtd_2,
               sum(round(ie.entsaic_quanti_un * ie.entsaic_cus_un,2)) as Valor_2
          from AG1IENSA ie,aa3citem aa
         where ie.ESCHC_DATA between &dta_inicial and &dta_final
           and ie.ESCHC_AGENDA = 24
           and ie.eschljc_codigo not in (100,103)
           and ie.eschc_secao3 = 305 --in (302,305)
           and ie.esitc_codigo = aa.git_cod_item
           --and aa.git_dat_sai_lin = 0
           and aa.git_secao = ie.eschc_secao3
           Group by ie.eschljc_codigo,ie.eschljc_digito,ie.esitc_codigo1,ie.esitc_digito1,
                     aa.git_descricao,ie.eschc_secao3,ie.eschc_grupo3, ie.eschc_agenda 

)
Group by Lj,Loja,codigo,descricao,secao,grupo
Order by Lj,secao,grupo,descricao



 