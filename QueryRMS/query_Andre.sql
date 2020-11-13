select      *
          
  from movecaixa mv where mv.tabpreco = 'P'
 and mv.tipo = 'P' 
 and mv.codbarra = '       7891150001411' --> '       3000000000000' 
 --Group by mv.codbarra
 order by mv.codbarra desc