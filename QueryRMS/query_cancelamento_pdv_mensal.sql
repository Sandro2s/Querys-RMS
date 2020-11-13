-- Empresa : Supermercado São Roque Ltda.
-- Data :02/09/2011 
-- Atualizado em : 02/09/2011
-- Desenvolvedor : Sandro Soares.
-- Solicitante : Zezinho
-- Descrição : Consulta por mês os cancelamentos de PDV por loja.
 select  a.loja as loja 
        ,sum(a.a) as Janeiro
        ,sum(a.b) as Fevereiro
        ,sum(a.c) as Marco
        ,sum(a.d) as Abril
        ,sum(a.e) as Maio
        ,sum(a.f) as Junho
        ,sum(a.g) as Julho
        ,sum(a.h) as Agosto
        ,sum(a.i) as Setembro
        ,sum(a.j) as Outubro
        ,sum(a.l) as Novembro
        ,sum(a.m) as Dezembro
        from  
  ( select  canc.loja,sum(canc.soma) as soma,
   case mes  when '01' then soma end A,
   case mes  when '02' then soma end B,
   case mes  when '03' then soma end C,
   case mes  when '04' then soma end D,
   case mes  when '05' then soma end E,
   case mes  when '06' then soma end F,
   case mes  when '07' then soma end G,
   case mes  when '08' then soma end H,
   case mes  when '09' then soma end I,
   case mes  when '10' then soma end J,
   case mes  when '11' then soma end L,
   case mes  when '12' then soma end M       
    from 
 (
 select  to_char(rms7to_date(rl_data),'mm')as mes
        ,(rl_loja) as loja
        ,sum (rl_cancelado_1)as soma
    from ag2vrlcx 
 where  rms7to_date(rl_data) between to_date('&Dta_Inicial','dd/mm/yyyy') and to_date('&Dta_Final','dd/mm/yyyy')
group by rl_data,rl_loja
order by loja
) canc
  group by canc.mes,canc.loja,soma )a group by a.loja order by loja;
   
-----------------------------------------------------------------------------------------------
--Cancelamento que são lançados na agenda 21. Por Mes e por Loja
       select mov.loja as Loja
              ,sum(mov.a) as Janeiro
              ,sum(mov.b) as Fevereiro
              ,sum(mov.c) as Março
              ,sum(mov.d) as Abril
              ,sum(mov.e) as Maio 
              ,sum(mov.f) as Junho
              ,sum(mov.g) as Julho
              ,sum(mov.h) as Agosto
              ,sum(mov.i) as Setembro
              ,sum(mov.j) as Outubro
              ,sum(mov.l) as Novembro
              ,sum(mov.m) as Dezembro
       
                from  
         
         (
          Select  Loja
                 ,case mes when '01' then nvl(sum(valor),0) end A  
                 ,case mes when '02' then nvl(sum(valor),0) end B 
                 ,case mes when '03' then nvl(sum(valor),0) end C
                 ,case mes when '04' then nvl(sum(valor),0) end D
                 ,case mes when '05' then nvl(sum(valor),0) end E
                 ,case mes when '06' then nvl(sum(valor),0) end F
                 ,case mes when '07' then nvl(sum(valor),0) end G
                 ,case mes when '08' then nvl(sum(valor),0) end H
                 ,case mes when '09' then nvl(sum(valor),0) end I
                 ,case mes when '10' then nvl(sum(valor),0) end J
                 ,case mes when '11' then nvl(sum(valor),0) end L
                 ,case mes when '12' then nvl(sum(valor),0) end M
                 from  
              (  
                Select to_number(LJ) as Loja
                       ,MES
                       ,sum(Vl) as Valor
                       
                       from 
                          (
                          select  fis_loj_org||fis_dig_org as LJ
                                 ,to_char(rms7to_date(fis_dta_agenda),'MM') as Mes
                                 ,sum(fis_val_cont_ff_1+fis_val_cont_ff_2+fis_val_cont_ff_3+fis_val_cont_ff_4+fis_val_cont_ff_5)as vl
                          
                            from aa1cfisc
                           where rms7to_date(FIS_DTA_AGENDA) between to_date('&Dta_Inicial','dd/mm/yyyy') and to_date('&Dta_Final','dd/mm/yyyy')
                             and fis_oper = 21
                             and fis_situacao <> '9'
                             and fis_loj_org  not in (1007)
                             group by fis_loj_org,fis_dig_org,fis_oper,fis_dta_agenda,fis_nro_nota,fis_situacao
                          )  group by LJ,Mes
             order by loja,Mes)  
                 group by Loja,mes )mov
                 group by Loja
                 order by loja ;
                 
-------------------------------------------------------------------------------------------------- 
-- Cancelamento PDV por loja, por data e por PDV.
 select  rl_loja as Loja
         ,rms7to_date (rl_data) as Dta
         ,rl_caixa as PDV
         ,rl_cancelado_1 as cancelamento
         
    from ag2vrlcx 
 where  rms7to_date(rl_data) between to_date('&Dta_Inicial','dd/mm/yyyy') and to_date('&Dta_Final','dd/mm/yyyy')
 and rl_cancelado_1 > 0
 order by Loja,dta,pdv;

  
/*-----------------------------------------------------------------------------------------------
-- Relatória de operadora por PDV
select distinct te_loja as Loja
       ,rms7to_date(te_data) as Dta
       ,te_caixa as caixa
       ,te_nro_operacao||dac(te_nro_operacao) as Cod_operador
       ,operador
        from AG2VTENT, 
        (
          select tip_codigo
              ,tip_razao_social as Operador 
           from aa2ctipo 
            where tip_loj_cli = 'R' 
             and tip_natureza = 'OC'
        )oper
        
        where te_loja = 191 
        and rms7to_date(te_data) between  to_date('01/11/2011','dd/mm/yyyy') and to_date('30/11/2011','dd/mm/yyyy')
        and oper.tip_codigo = te_nro_operacao
        order by dta,caixa*/
        
        