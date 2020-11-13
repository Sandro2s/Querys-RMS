-- Empresa : Supermercado São Roque Ltda. TI
-- Data :24/05/2012
-- Descrição : Consulta que retorna valores digitados e importados da tesourária somarizados. 
-- Desenvolvido : Sandro Soares
-- Atualizado em : 24/05/2012

select dta,
       loja,
       Case when op = 0 then 'PARTIME'
        else to_char(op||dac(op)) end operador,
       nome,
       sum(VD)as " Digitado",
       sum(IG)as "Importado",
       sum(sb)as Sobra,
       sum(qb)as Quebra
              
    from

(
      Select Dta
             ,max(ope_loja) as Loja
             ,max(ope_operador) as Op
             ,Nome
             ,max(ope_caixa )as Caixa
             ,sum(vl_dig) as VD
             ,sum(vl_integrado) as IG
             ,Case  when (sum(to_number(nvl(vl_dig,0))) - sum(to_number(nvl(vl_integrado,0)))) <=  0 then  sum(nvl(vl,0)) end Qb
             ,Case  when (sum(to_number(nvl(vl_dig,0))) - sum(to_number(nvl(vl_integrado,0))))   > 0 then  sum(nvl(vl,0)) end Sb
      
       from
            (
              select ope_loja, 
       rms7to_date(ope_data) as Dta,
       ope_operador,
       tp.tip_razao_social as Nome,
       ope_caixa,
       sum(nvl(ope_vlr_digitado,0))  as VL_Dig,
       sum(nvl(ope_vlr_integrado,0)) as VL_Integrado,
       (ope_vlr_digitado - ope_vlr_integrado) as vl
  
  from ag2voper inner join (select tip_codigo, tip_razao_social from aa2ctipo where tip_natureza = 'OC' order by tip_codigo)tp on ope_operador = tp.tip_codigo
 where rms7to_date(ope_data) between to_date('&Dta_Ini_DDMMYYYY','dd/mm/yyyy') and to_date('&Dta_Final_DDMMYYYY','dd/mm/yyyy')
  -- and ope_loja = '&Loja'
  -- and ope_caixa = 8
  -- and ope_operador = 4526--2810
   group by ope_loja,ope_data,ope_operador,ope_caixa,ope_vlr_digitado ,ope_vlr_integrado,tp.tip_razao_social
               ) 
                 group by ope_loja,ope_operador,ope_caixa,vl_dig,vl_integrado,vl,dta,nome
                 order by op,caixa
)group by loja,op,dta,nome
 order by dta,operador;
 
 
----------------------------------------------------------------------------------------------
-- Aberto por caixa e operador
Select  Dta as Mes
       ,Loja
       ,to_Number(Operador) as Operador
       ,Nome
       ,sum(digitado) as "Digitado"
       ,sum(integrado) as "Integrado"
       ,sum(divergencia)as "Divergencia"
    from  
      (
      select to_number(ope_loja) as Loja,
             to_char(rms7to_date(ope_data),'month') as Dta,
             Case when ope_operador = 0 then 'PARTIME'
               else to_char(ope_operador||dac(ope_operador)) end Operador,
             tip_razao_social as Nome,
             ope_caixa,
             sum(nvl(ope_vlr_digitado,0))  as Digitado,
             sum(nvl(ope_vlr_integrado,0)) as Integrado,
             (ope_vlr_digitado - ope_vlr_integrado) as Divergencia
                  
        from ag2voper inner join (select tip_codigo, tip_razao_social from aa2ctipo where tip_natureza = 'OC' order by tip_codigo)tp on ope_operador = tp.tip_codigo
       where rms7to_date(ope_data) between to_date('&Dta_Ini_DDMMYYYY','dd/mm/yyyy') and to_date('&Dta_Final_DDMMYYYY','dd/mm/yyyy')
        -- and ope_loja = '&Loja'
        -- and ope_caixa = 8
        -- and ope_operador = 4526--2810
         group by ope_loja,ope_data,ope_operador,ope_caixa,ope_vlr_digitado ,
          ope_vlr_integrado,tip_razao_social
      )   
        group by Loja,dta,Operador,nome
        order by Loja,Operador
   