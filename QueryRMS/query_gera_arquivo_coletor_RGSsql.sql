-- Supermercado São Roque Ltda.
-- Data : 18/04/2011
-- Solicitante : Tony Goginho
-- Desenvolvedor : Sandro Soares
-- Descrição : Consultar e gerar aquivo texto no layout dos coletores da RGS.
-- Manutenção : 18/04/11

DECLARE
 arquivo_saida                    UTL_File.File_Type;
 linha                            Varchar2(100);
 reg_linha                        Varchar2(120);
Cursor Cur_Linha is
 --Definição do select que traz a linha completa concatenada a ser gravada
select '000051' as loja,
       to_char (sysdate,'mmddyy')as  Data,
       '          'as branco,
       rpad(aa.git_cod_item||aa.git_digito,12,' ')as cod_int,
       '0000000000000'as fixo,
       to_char(mult.ean_cod_ean,'fm0000000000000') as ean,
       '000000000000'as prc_venda,
       to_char(est.qtd_est,'fm00000000') as Estoque,
       rpad(aa.git_desc_reduz,40,' ') as Dsc
       
  from aa3citem aa,
       (
         select get_cod_produto as cod,
             to_char((get_estoque*1000),'00000000') as qtd_est
              from aa2cestq where get_cod_local = 51
        )est,
        (
           select ean_cod_pro_alt ,ean_cod_ean from aa3ccean
            where ean_flag_princ <> 'D'
         )mult
              
 where aa.git_secao in (100,101,102,103,104,105,106,107,108,109,110,111,112,200,201,300,301,302,303,304,305,306,400)
       and aa.git_cod_item||aa.git_digito = est.cod
       and mult.ean_cod_pro_alt = est.cod
       --and aa.git_codigo_ean13 > 40000000
       order by git_codigo_ean13;
BEGIN
    arquivo_saida := UTL_File.Fopen('/dbx','I'||'05'||to_char(sysdate,'yyyymmdd')||'.txt', 'w');
    For Reg_Linha in Cur_linha Loop
        UTL_File.put_line(arquivo_saida,reg_linha.loja||reg_linha.data||reg_linha.branco||reg_linha.cod_int||reg_linha.fixo||reg_linha.ean||reg_linha.prc_venda||reg_linha.estoque||reg_linha.Dsc||chr(13));
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
