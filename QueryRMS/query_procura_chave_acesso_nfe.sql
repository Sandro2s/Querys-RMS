--select * from vw03_nfeentrada where nfe_numero_nf = 641589;

--select * from nfe_controle where data_processamento > to_date('01/01/2013','dd/mm/yyyy')
-- Empresa : Supermercado São Roque Ltda.
-- Data :01/13/2013 
-- Atualizado em : 
-- Desenvolvedor : Sandro Soares.
-- Solicitante : 
-- Descrição : Consulta de chave de acesso para encontrar numero de nota fiscal.


select substr(to_char(chave_acesso_nfe),26,9)/*substr(to_number(chave_origem),15,6)*/as nota_fiscal
       ,substr(to_char(chave_acesso_nfe),23,3)/*substr(to_number(chave_origem),15,6)*/as serie
       ,nfe_controle.* 
  from nfe_controle 
    where  chave_acesso_nfe like '35130146025722000100550060006415891000606706%' 