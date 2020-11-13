select sexo, uf, sum(valor)
from t_vendas
group by sexo,uf
order by 1,2;

select sexo, uf, sum(valor)
from t_vendas
Group by cube(sexo,uf)
order by 1,2;

select idade,sexo,uf,sum(valor)
from t_vendas
Group by cube (idade,sexo,uf)
order by 1,2,3;

select grouping(uf),sexo,uf,sum(valor)
from t_vendas
group by cube (sexo,uf)
order by 2,3;

select grouping(sexo),grouping(uf),sexo,uf,sum(valor)
from t_vendas
group by cube(sexo,uf)
order by 3,4

select sexo,uf,sum(valor)
from t_vendas
group by rollup(sexo,uf)
order by 1,2

select idade,sexo,uf,sum(valor)
from t_vendas
group by idade,rollup (sexo,uf)
order by 1,2,3

select sexo,uf,round(avg(valor),2)
from t_vendas
group by rollup (sexo, uf)
order by 1,2