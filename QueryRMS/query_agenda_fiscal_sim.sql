-- Supermercado São Roque Ltda.
-- Data : 29/02/2012
-- Solicitante : Solange
-- Desenvolvedor : Sandro Soares
-- Descrição : Trazer agenda com situação fiscal "S".
-- Manutenção : 29/02/2012

select * from  (select to_number(tab_acesso)agenda ,tab_conteudo as descricao from aa2ctabe 
                  where tab_codigo = 14
                  and tab_acesso > '          ')tab
            INNER JOIN 
                  (select to_number(tbc_agenda)as agenda
                     from aa1ctcon
                       where tbc_codigo = 0
                        and tbc_intg_4 = 'S'
                        order by tbc_agenda) agd
                        on agd.agenda = tab.agenda