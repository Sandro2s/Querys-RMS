-- Supermercado São Roque Ltda.
-- Data : 10/06/2009
-- Solicitante : 
-- Desenvolvedor : Sandro Soares
-- Descrição : Gera os dados do arquivo de entrega de estoque para receita.
-- Manutenção : 01/04/2015

DECLARE
 arquivo_saida                    UTL_File.File_Type;
 linha                            Varchar2(60);
 reg_linha                        Varchar2(60);
 loja                             number(4):= 159; --codigo da loja com digito
 inv                              number(6):= 190025; --Nr.do Inventário
Cursor Cur_Linha is
 --Definição do select que traz a linha completa concatenada a ser gravada
select  '2' as Registro
        ,rcicm_produto as Cod_Produto
        ,ltrim(to_char(((to_char(inv_est_tot,'00000'))*1000),'999,999')) as Quant
        ,round(inv_cst_ult,2)   as Vlr_Unitario
        ,round((inv_est_tot * inv_cst_ult),2) as Vlr_Total
        ,ltrim(to_char(((to_char(tfi_aliq_icm,'0000'))*100),'99,99')) as Aliquota
        ,tfi_aliq_str_dst as IVA_ST
        ,to_char('0,00') as PFC  --Preco_Final_Consumidor 
        ,Round(((inv_est_tot * inv_cst_ult)* (tfi_aliq_icm/100))+(((inv_est_tot * inv_cst_ult)* (tfi_aliq_str_dst/100))*(tfi_aliq_icm/100)),2)as Devido             --,'0' as Imposto_Devido
        ,decode(inv_fig,116,557) as Tip_Mercadoria -- Procura a figura no inventáro e troca pelo tipo de mercadoria no txt
        ,rtrim(inv_dcr) as Descricao
        ,inv_emb_tpo as Unid_Medida
  from ag2invct
  inner join aw4rcicm on inv_pro || dac(inv_pro) = rcicm_produto
  inner join ( select tfi_figura
          ,tfi_aliq_icm
          ,tfi_aliq_str_dst
     from aa3tfisc
    where tfi_origem = 'SP'
      and tfi_destino = 'SP'
      and tfi_cfop = 1102
      and tfi_automacao = 'S'
      and tfi_figura in (116))fig -- Filtro das figura que tiveram alteração.
      on tfi_figura = inv_fig 
 where inv_num = inv
 and inv_fil = loja --19
 and inv_est_tot > 00;

BEGIN
    arquivo_saida := UTL_File.Fopen('/dbx','Ent'||loja||to_char(sysdate,'yyyymmdd')||'.txt', 'w');
      For Reg_Linha in Cur_linha Loop
        UTL_File.put_line(arquivo_saida,reg_linha.Registro||'|'||reg_linha.cod_produto||'|'||reg_linha.Quant||'|'||reg_linha.Vlr_Unitario||'|'||reg_linha.Vlr_Total ||'|'||reg_linha.Aliquota||'|'||reg_linha.IVA_ST||'|'||reg_linha.PFC||'|'||reg_linha.Devido||'|'||reg_linha.Tip_Mercadoria||'|'||reg_linha.Descricao||'|'||reg_linha.Unid_Medida||chr(13));
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
