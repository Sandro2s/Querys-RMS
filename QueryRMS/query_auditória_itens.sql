-- Supermercado São Roque Ltda.
-- Data : 07/03/2011
-- Solicitante : Solange Pinheiro
-- Desenvolvedor : Sandro Soares
-- Descrição : Consulta de itens para auditória de cadastro fiscal.
-- Manutenção : 07/03/2011

select aa.git_cod_item||'-'||aa.git_digito as Codigo,
       aa.git_descricao as "Descrição",
       aa.git_secao as secao,
       aa.git_grupo as grupo,
       di.det_class_fis as "NBM",
       rmsto_date( aa.git_dat_sai_lin) as "Data Saida Linha",
       to_char(aa.git_nat_fiscal,'000') ||'  -  '||tb.tab_conteudo as "Figura Fiscal",
       aa.git_cod_pauta as "Cod_Pauta",
       to_char(pauta.conteudo) as "Pauta_Valor",
       aa.git_perc_ipi as "IPI %",
       aa.git_valor_ipi as " IPI Valor",
       to_char(aa.git_categoria_ant,'000') ||
       decode ( aa.git_categoria_ant ,0, ' - NORMAL', 1,' - ANTECIPADO',2,' - ISENTO')as "Pis/Cofins"


from aa3citem aa, aa1ditem di,
     (Select tab_acesso,tab_conteudo  
    from aa2ctabe 
      where tab_codigo = 3 
      and tab_acesso > = '001')tb,
    
    /*(Select 999 as flag, trunc((to_number(tab_acesso))/10) as acesso,
    to_char(substr( tab_conteudo,7,7),'999,9999') as conteudo  
    from aa2ctabe 
      where tab_codigo = 201 
      and tab_acesso > = '001' 
      and tab_acesso < 'A         ')pauta*/
       ( Select 999 as flag, trunc((to_char(tab_acesso,'99999999'))/10) as acesso, 
         to_number(to_char(substr( tab_conteudo,7,7),'000,0000')) as conteudo 
    from aa2ctabe 
      where tab_codigo = 201 
      and tab_acesso > = '001' 
      and tab_acesso < 'A         ')pauta
      
  where aa.git_cod_item = di.det_cod_item 
  and tb.tab_acesso = aa.git_nat_fiscal
  and aa.git_secao in (210,211,212,213,214,215,216,400,401)
  and aa.git_cod_item  = pauta.acesso (+)
  and aa.git_cod_pauta = pauta.flag(+)
  order by aa.git_descricao




/*Select tab_acesso,tab_conteudo  
    from aa2ctabe 
      where tab_codigo = 201 
      and tab_acesso > = '001'*/
      
     -- Select count(aa.git_secao)from aa3citem aa where aa.git_secao in (100,101,102)