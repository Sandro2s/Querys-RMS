--Cadastro de operadores
select mon_operador,
       mon_nro_os,
       decode(mon_status,0,'Busc.Ativ',1,'Pausado',2,'Logoff')Status 
       
 from AG5MONRF
 order by 1;

--Operadores e linhas
select seq_cod_oper,
       seq_operacao,
       seq_codigo,
       seq_ordem, 
       mon_status --0: buscando atividade; 1: pausado; 2: logoff 

from AG5SEQOP,AG5MONRF
where seq_operacao = 4
and trim(seq_cod_oper) = trim(mon_operador)
order by 3,4;

--Consulta da operação Recolhe
select sep_atividade,
       sep_destino,
       sep_data,
       sep_palete,
       mov_sta_movim,
       mov_cod_oper,
       cos_data_aceite,
       sep_rua 
       
  from ag5sepcd, ag5movdt, ag5movcp,ag5cnvos
 where sep_data >= 1171106
 and mit_cod_ativ = mov_cod_ativ
 and mit_cod_ativ = sep_cod_ativ_re 
 and mit_sta_movim != 'FC'
 and sep_status = 2
 and cos_cod_atividade = mov_cod_ativ
 and cos_cod_operacao = 7
 group by sep_atividade,
       sep_destino,
       sep_data,
       sep_palete,
       mov_sta_movim,
       mov_cod_oper,
       cos_data_aceite,
       sep_rua ; 

---Pendencia Pulmão/Doca
select sep_atividade,
       sep_pedido,
       decode(sep_origem_ped,2,'Reforco',6,'Abast.Autom',7,'Crossdocking') as Origem_Pedi,
       sep_destino,
       sep_carga,
       sep_palete,
       sep_linhasep,
       cos_nro_os,
       cos_status,
       cos_data_aceite as Aceite,
       mon_prox_operacao
       mon_mensagem
       
        
from ag5sepcd,AG5CNVOS, AG5MONRF  
where sep_data >= 1171030
and sep_atividade = cos_cod_atividade (+)
and cos_nro_os = mon_nro_os (+)
and sep_status = 0
and sep_tipo_sep = 1
group by sep_atividade, sep_pedido, sep_destino, sep_carga, sep_palete,
       sep_linhasep, cos_nro_os, cos_status, cos_operador, mon_operador,
       mon_prox_operacao, mon_mensagem,sep_origem_ped,cos_data_aceite;

---Colete Fracionada 
select sep_atividade,
       sep_pedido,
       decode(sep_origem_ped,2,'Reforco',6,'Abast.Autom',7,'Crossdocking') as Origem_Pedi,
       sep_destino,
       sep_carga,
       sep_palete,
       sep_linhasep,
       cos_nro_os,
       decode(cos_status,1,'1-NÃO ALOCADDO',2,'2-EM ANDAMENTO',3,'3-FECHADA')Sts_OS, 
       cos_operador,
       cos_cod_operacao,
       cos_data_aceite as Aceite,
       cos_data_encerra as Termino,
       mon_prox_operacao,
       mon_mensagem 
       
        
from ag5sepcd,AG5CNVOS, AG5MONRF    
where sep_data >=1171030
and sep_atividade = cos_cod_atividade (+)
and cos_nro_os = mon_nro_os (+)
and sep_status = 1
and sep_tipo_sep = 0 
and sep_galpao > 0
and sep_tipo_ativ = 2
group by sep_atividade, sep_pedido, sep_destino, sep_carga, sep_palete,
       sep_linhasep, cos_nro_os, cos_status, cos_operador, mon_prox_operacao, 
       mon_mensagem,sep_origem_ped,cos_data_aceite, cos_data_encerra,cos_cod_operacao;
       
