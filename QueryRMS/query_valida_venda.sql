select * from ac1clanc where lanc_modalidade = 3 and lanc_parcela = 1 and lanc_data_pagto = 0

select * from ac1clanc where lanc_codigo = 70688 for update

select * from ac1qlimi where lim_codigo = 7068 for update

select sum(m03ap)from movdb.zan_m03 where m03ah = 47102 and m00af = '19/12/06'
select sum(m03ao),sum(m03ap) from movdb.zan_m03 where m03ah = 47102 and m00af = '19/12/06'

select git_cod_item||git_digito,git_codigo_ean13,git_descricao from aa3citem where git_codigo_ean13 < 3000000000000 
order by git_cod_item||git_digito
