select cos_operador,
       --decode(sep_origem_ped,2,'Reforco',6,'Abast.Autom',7,'Crossdocking') as Origem_Pedi,
       decode(sep_tipo_sep,0,'Coleta Francionada',2,'Crossdoking')Tipo,
       sum(sep_qtd_fat) caixas,
       --decode(cos_status,1,'1-NÃO ALOCADDO',2,'2-EM ANDAMENTO',3,'3-FECHADA')Sts_OS, 
      cos_data_aceite  as Aceite,
      cos_data_encerra as Termino
       
        
from ag5sepcd,AG5CNVOS, AG5MONRF    
where sep_data >=1171030
and sep_atividade = cos_cod_atividade (+)
and cos_nro_os = mon_nro_os (+)
and sep_status = 6
and sep_tipo_sep in(0,2)
--and cos_data_aceite is not null
group by sep_origem_ped,cos_nro_os,cos_status,cos_operador,cos_data_aceite,cos_data_encerra,sep_tipo_sep 
order by cos_data_aceite,cos_operador

select * from ag5sepcd where sep_tipo_sep = 2 and sep_status = 6

select * from ag5cnvos where cos_cod_atividade = 1415269