       
SELECT
        tip_razao_social  as "Razão Social "
       ,tip_nome_fantasia as "Nome Fantasia"                    
       ,Decode(tip_cgc_cpf,NULL,NULL,
           REPLACE(REPLACE(REPLACE(To_Char(LPad(REPLACE(tip_cgc_cpf,' ') ,14 ,'0') ,'00,000,000,0000,00')
                                   ,',','.') ,' ')
                  ,'.'||Trim(To_Char(Trunc(Mod(LPad(tip_cgc_cpf,14,'0')
                                          ,1000000)/100)
                                    ,'0000'))||'.'
                  ,'/'||Trim(To_Char(Trunc(Mod(LPad(tip_cgc_cpf,14,'0')
                                           ,1000000)/100)
                                    ,'0000'))||'-')) CNPJ  
    FROM aa2ctipo 
    where tip_loj_cli = 'F' 
    and tip_natureza in ('FF','FD')
        
