select  nvl(m00za,0) as Loja, 
           nvl(m01ah,0) as Operadora,
               nome     as Nome,
        Count (nvl(m01aj,0)) as Quant_Venda, 
          Sum (nvl(m01ak,0)) as Valor_Venda
                         
from zan_m01,manager.tab_funcionario 
where  m00af between to_date('01/06/09','dd/mm/yy')and to_date('30/06/09','dd/mm/yy')
and m00za in (1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 14, 15)
and cod_loja not in (13)
and m01ah = cod_funcionario (+)
and m01ak > 0
 and m01ah not in
       (1, 2, 10, 1007, 123456, 20, 10278, 10286, 10294, 10308, 10316, 10324,
        10332, 10340, 10359, 10365, 10367, 10383, 10391, 10405, 10456, 11665,
        18384, 20672, 21822, 21830, 23159, 23191, 23213, 23272, 23337, 23388,
        23523, 23566, 23639, 23671, 23817, 23850, 23868, 23914, 24074, 24864,
        24970)
and cod_loja > 0
group by m00za,m01ah,nome
order by m00za,m01ah;


select nvl(m00za, 0) as Loja,
       nvl(m01ah, 0) as Operadora,
       nome as Nome,
       Count(nvl(m00ad, 0)) as Qtd_Cancel
  from zan_m01, manager.tab_funcionario
 where m00af between to_date('01/06/09','dd/mm/yy')and to_date('30/06/09','dd/mm/yy')
   and m00za in (1, 2, 3, 4, 5, 7, 8, 9, 10, 11, 12, 14, 15)
   and cod_loja not in (13)
   and m01ah = cod_funcionario(+)
   and m01ak < = 0
   and m01ah not in
       (1,2,10,1007, 123456, 20, 10278, 10286, 10294, 10308, 10316, 10324,
        10332, 10340, 10359, 10365, 10367, 10383, 10391, 10405, 10456, 11665,
        18384, 20672, 21822, 21830, 23159, 23191, 23213, 23272, 23337, 23388,
        23523, 23566, 23639, 23671, 23817, 23850, 23868, 23914, 24074, 24864,
        24970)
   and cod_loja > 0
 group by m00za, m01ah, nome
 order by m00za, m01ah;



