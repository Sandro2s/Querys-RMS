-- Supermercado São Roque Ltda.
-- Data : 21/06/2011
-- Solicitante : Tony Godinho
-- Desenvolvedor : Sandro Soares
-- Descrição : Consultar e gerar aquivo texto no layout dos coletores Fenix.
-- Manutenção : 21/06/11


DECLARE
 arquivo_saida                    UTL_File.File_Type;
 linha                            Varchar2(37);
 reg_linha                        Varchar2(37);
Cursor Cur_Linha is
 --Definição do select que traz a linha completa concatenada a ser gravada
select 
       to_char(mult.ean_cod_ean,'fm0000000000000') as ean
       ,rpad(aa.git_desc_reduz,24,' ') as Dsc
   from aa3citem aa,
       (
         select get_cod_produto as cod,
             to_char((get_estoque*1000),'00000000') as qtd_est
              from aa2cestq where get_cod_local = 19
        )est,
        (
           select ean_cod_pro_alt ,ean_cod_ean from aa3ccean
            where ean_flag_princ <> 'D'
         )mult
              
 where aa.git_secao not in  (1,30,600,601,602,603,604,605,606,607,608,500,502,503,504,505,506)
       and aa.git_cod_item||aa.git_digito = est.cod
       and mult.ean_cod_pro_alt = est.cod
       order by ean;
BEGIN
    arquivo_saida := UTL_File.Fopen('/dbx','Inv'||to_char(sysdate,'yyyymmdd')||'.txt', 'w');
    For Reg_Linha in Cur_linha Loop
        UTL_File.put_line(arquivo_saida,reg_linha.ean||reg_linha.Dsc||chr(13));
       End Loop;
    UTL_File.Fclose(arquivo_saida);
    Dbms_Output.Put_Line('Arquivo gerado com sucesso.');
EXCEPTION
      WHEN UTL_FILE.INVALID_OPERATION THEN
               Dbms_Output.Put_Line('Operação inválida no arquivo.');
               UTL_File.Fclose(arquivo_saida);
      WHEN UTL_FILE.WRITE_ERROR THEN
               Dbms_Output.Put_Line('Erro de gravação no arquivo.');
               UTL_File.Fclose(arquivo_saida);
      WHEN UTL_FILE.INVALID_PATH THEN
               Dbms_Output.Put_Line('Diretório inválido.');
               UTL_File.Fclose(arquivo_saida);
      WHEN UTL_FILE.INVALID_MODE THEN
               Dbms_Output.Put_Line('Modo de acesso inválido.');
               UTL_File.Fclose(arquivo_saida);
      WHEN Others THEN
               Dbms_Output.Put_Line('Problemas na geração do arquivo.');
               UTL_File.Fclose(arquivo_saida);
END;
---------------------------------------------------------------------------------------------------------
-- Solicitante : Tony Godinho
-- Desenvolvedor : Fernando Germano
-- Descrição : Gera arquivo sem filtro por loja.
-- Manutenção : 21/06/11
DECLARE
 arquivo_saida                    UTL_File.File_Type;
 linha                            Varchar2(37);
 reg_linha                        Varchar2(37);
Cursor Cur_Linha is
 --Definição do select que traz a linha completa concatenada a ser gravada
select to_char(T2.ean_cod_ean, 'fm0000000000000') as ean,
       rpad(T1.git_desc_reduz, 24, ' ') as Dsc
  from aa3citem T1
 INNER JOIN aa3ccean T2 ON T1.git_cod_item || T1.git_digito =
                           T2.ean_cod_pro_alt
                       AND T2.ean_flag_princ <> 'D'

 where T1.git_secao not in
       (1, 30, 600, 601, 602, 603, 604, 605, 606, 607, 608, 500, 502, 503, 504, 505, 506)
 order by git_codigo_ean13;
 
BEGIN
    arquivo_saida := UTL_File.Fopen('/dbx','Inv'||to_char(sysdate,'yyyymmdd')||'.txt', 'w');
    For Reg_Linha in Cur_linha Loop
        UTL_File.put_line(arquivo_saida,reg_linha.ean||reg_linha.Dsc);
       End Loop;
    UTL_File.Fclose(arquivo_saida);
    Dbms_Output.Put_Line('Arquivo gerado com sucesso.');
EXCEPTION
      WHEN UTL_FILE.INVALID_OPERATION THEN
               Dbms_Output.Put_Line('Operação inválida no arquivo.');
               UTL_File.Fclose(arquivo_saida);
      WHEN UTL_FILE.WRITE_ERROR THEN
               Dbms_Output.Put_Line('Erro de gravação no arquivo.');
               UTL_File.Fclose(arquivo_saida);
      WHEN UTL_FILE.INVALID_PATH THEN
               Dbms_Output.Put_Line('Diretório inválido.');
               UTL_File.Fclose(arquivo_saida);
      WHEN UTL_FILE.INVALID_MODE THEN
               Dbms_Output.Put_Line('Modo de acesso inválido.');
               UTL_File.Fclose(arquivo_saida);
      WHEN Others THEN
               Dbms_Output.Put_Line('Problemas na geração do arquivo.');
               UTL_File.Fclose(arquivo_saida);
END;
