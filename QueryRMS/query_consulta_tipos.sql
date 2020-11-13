-- Supermercado São Roque Ltda.
-- Data : 03/12/2010
-- Solicitante : Solange Pinheiro
-- Desenvolvedor : Sandro Soares
-- Descrição : Consulta de Tipo que não tem cadastrado o numero exterior.
-- Manutenção : 03/12/10

select tpo.tip_codigo||tpo.tip_digito as Codigo,
       tpo.tip_razao_social as "Razão Social",
       tpo.tip_nome_fantasia as "Nome Fantasia",
       tpo.tip_natureza as Tipo,
       Decode(tip_cgc_cpf,NULL,NULL,
           REPLACE(REPLACE(REPLACE(To_Char(LPad(REPLACE(tip_cgc_cpf,' ') ,14 ,'0') ,'00,000,000,0000,00')
                                   ,',','.') ,' ')
                  ,'.'||Trim(To_Char(Trunc(Mod(LPad(tip_cgc_cpf,14,'0')
                                          ,1000000)/100)
                                    ,'0000'))||'.'
                  ,'/'||Trim(To_Char(Trunc(Mod(LPad(tip_cgc_cpf,14,'0')
                                           ,1000000)/100)
                                    ,'0000'))||'-')) CNPJ,
       Decode(forn.for_troca,'N','Não','S','Sim') as Substituido,
       ag.cnf_nr_exterior as "Nr.Exterior" ,
       tpo.tip_fone_ddd as DDD,
       tpo.tip_fone_num as Fone
   
   from aa2ctipo tpo, ag1cdcnf ag,aa2cforn forn
       where tpo.tip_codigo (+) = ag.cnf_codigo
       and tpo.tip_codigo  = forn.for_codigo
     --  and ag.cnf_nr_exterior = '               '
       and tpo.tip_natureza not in ('OC','CL','FT','FS','LS')
       order by tipo
  