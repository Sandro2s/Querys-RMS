select decode(ctaw_usu, 1,'Super',
                        2,'Igomic',
                        3,'GMSR',
                        4,'CPSR',
                        9,'TPSR',
                       12,'IBiunaSR') as Empresa,
    substr(to_char(Ctaw_conta),1,12)          as Conta,
       ctaw_reduzido                  as Reduzida,
       ctaw_descricao                 as Descricao,
       rmsrsv_001                     as Conta_Referente
       
  from aa1cctbp
 where trim(rmsrsv_001) is not null
   and ctaw_usu in (1,2,3,4,9,12)

--select * from aa1cctbu