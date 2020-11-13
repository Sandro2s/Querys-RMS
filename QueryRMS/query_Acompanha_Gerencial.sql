-- Descrição : Consulta de Procssos rodando no Gerencial.

--select 1
select status_atu, count(*) from log_dta_erro
group by status_atu;

--select 2
select id_dt, cd_proc, count(*) from log_imp_estq 
where sts_atu = 0 group by id_dt, cd_proc;


SELECT DISTINCT DTA_ATU FROM LOG_DTA_ERRO WHERE STATUS_ATU = 'N';

SELECT ID_DT ,CD_PROC, COUNT(*)
FROM LOG_IMP_ESTQ WHERE STS_ATU = 0 
GROUP BY ID_DT ,CD_PROC;

--Verificar o que esta na fila para processar
select * from LOG_IMP_ESTQ 
WHERE ID_DT <= 1090826
and sts_atu = 0
order by id_dt,cd_fil;

select agg.id_dt, per.dt_compl, agg.cd_fil, count(*)
from agg_estq_dia agg, dim_per per
where agg.id_dt = per.id_dt
group by agg.id_dt, per.dt_compl, agg.cd_fil;
