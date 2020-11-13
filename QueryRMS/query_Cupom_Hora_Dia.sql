-- Empresa : Supermercado São Roque Ltda. TI
-- Data :24/09/2012
-- Solicitante : Tony Godinho
-- Desenvolvido : Sandro Soares
-- Descrição : Conta quantidade de cupom por periodo horário. Esta dever ser rodada
--             conectado no banco vm_log.

Select data
       ,nvl(sum(Cup_4),0) as"04:00horas" 
       ,nvl(sum(Cup_5),0) as"05:00horas" 
       ,nvl(sum(Cup_6),0) as"06:00horas" 
       ,nvl(sum(Cup_7),0) as"07:00horas" 
       ,nvl(sum(Cup_8),0) as"08:00horas" 
       ,nvl(sum(Cup_9),0) as"09:00horas" 
       ,nvl(sum(Cup_10),0)as"10:00horas" 
       ,nvl(sum(Cup_11),0)as"11:00horas"
       ,nvl(sum(Cup_12),0)as"12:00horas" 
       ,nvl(sum(Cup_13),0)as"13:00horas"
       ,nvl(sum(Cup_14),0)as"14:00horas"
       ,nvl(sum(Cup_15),0)as"15:00horas"    
       ,nvl(sum(Cup_16),0)as"16:00horas"    
       ,nvl(sum(Cup_17),0)as"17:00horas"    
       ,nvl(sum(Cup_18),0)as"18:00horas"    
       ,nvl(sum(Cup_19),0)as"19:00horas"    
       ,nvl(sum(Cup_20),0)as"20:00horas"
       ,nvl(sum(Cup_21),0)as"21:00horas"    
       ,nvl(sum(Cup_22),0)as"22:00horas"    
       ,nvl(sum(Cup_23),0)as"23:00horas"        
           
from(
Select data,
    Case 
      when hora between to_date('01/01/1900 04:00', 'dd/mm/yyyy hh24:mi:ss') and
            to_date('01/01/1900 04:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_4,  
    Case 
  when hora between to_date('01/01/1900 05:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 05:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_5,  
    Case 
  when hora between to_date('01/01/1900 06:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 06:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_6,
    Case 
  when hora between to_date('01/01/1900 07:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 07:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_7,
    Case 
  when hora between to_date('01/01/1900 08:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 08:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_8,
    Case 
  when hora between to_date('01/01/1900 09:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 09:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_9,
    Case 
  when hora between to_date('01/01/1900 10:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 10:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_10,  
  Case 
  when hora between to_date('01/01/1900 11:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 11:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_11,
  Case 
  when hora between to_date('01/01/1900 12:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 12:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_12,
  Case 
  when hora between to_date('01/01/1900 13:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 13:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_13,
  Case 
  when hora between to_date('01/01/1900 14:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 14:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_14,
  Case 
  when hora between to_date('01/01/1900 15:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 15:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_15,
  Case 
  when hora between to_date('01/01/1900 16:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 16:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_16,
  Case 
  when hora between to_date('01/01/1900 17:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 17:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_17,
  Case 
  when hora between to_date('01/01/1900 18:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 18:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_18,
  Case 
  when hora between to_date('01/01/1900 19:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 19:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_19,
  Case 
  when hora between to_date('01/01/1900 20:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 20:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_20,
  Case 
  when hora between to_date('01/01/1900 21:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 21:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_21,
  Case 
  when hora between to_date('01/01/1900 22:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 22:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_22,
  Case 
  when hora between to_date('01/01/1900 23:00', 'dd/mm/yyyy hh24:mi:ss') and
        to_date('01/01/1900 23:59:59', 'dd/mm/yyyy hh24:mi:ss')then count(num_cupom)end Cup_23
        
    
  from total_cupom
 where data between to_date('&Data_Inicial', 'dd/mm/yyyy') and
       to_date('&Data_Final', 'dd/mm/yyyy')
       and loja = '&Loja' -- codigo da loja sem digito
       /*and hora between to_date('01/01/1900 21:00', 'dd/mm/yyyy hh24:mi:ss') and
       to_date('01/01/1900 21:59:59', 'dd/mm/yyyy hh24:mi:ss')
 */   
     group by data,hora) 
     group by data
     order by data
     