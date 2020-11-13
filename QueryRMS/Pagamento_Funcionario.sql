set serveroutput on size 1000000
set feed off;
set echo off;
set veri off;
clear screen;
prompt "Atualizando pagamento Funcionário";
prompt
accept cli      prompt "Codigo cliente sem digito: ";
accept dtpagto  prompt "Data Pagamento no formato dd/mm/yy: ";
accept vlpago   prompt "Valor Pago: ";
--accept vljuro   prompt "Valor juros: ";
--accept carne    prompt "Carne: ";
--accept parcela  prompt "Parcela: ";
prompt
declare 
  i          number;
  j          number;
  v_dt_pagto number;
  gh_file  utl_file.file_type;
  gs_file  varchar2(30);
begin
  j:=0;
  i:=0;
  gs_file := 'clientesAtualizados.txt';
  gh_file := utl_file.fopen(get_dir_rms(),gs_file,'a'); 
  v_dt_pagto := dateto_rms7(to_date('&&dtpagto', 'dd/mm/yy'));
  update ac1clanc 
     set lanc_data_pagto = v_dt_pagto,
         lanc_vlr_pago   = &&vlpago,
--         lanc_vlr_multa  = 0,
--         lanc_vlr_juros  = &&vljuro
  where lanc_codigo      = &&cli
-- and   lanc_nro_carne   = &&carne
--  and   lanc_parcela     = &&parcela;

  ---> Atualiza Limite
  UPDATE AC1QLIMI 
  SET LIM_SALDO      = LIM_SALDO      - &&vlpago,
      LIM_DISPONIVEL = LIM_DISPONIVEL + &&vlpago
  WHERE LIM_CODIGO     = &&cli
  AND   LIM_DIGITO     = dac(&&cli)
  AND   LIM_MODALIDADE = 7;  

  UPDATE AC1QLIMI SET LIM_DISPONIVEL = LIM_LIMITE 
  WHERE LIM_DISPONIVEL > LIM_LIMITE 
  AND   LIM_CODIGO     = &&cli
  AND   LIM_DIGITO     = dac(&&cli)
  AND   LIM_MODALIDADE = 7;
  commit;
  utl_file.put_line(gh_file, 'Cliente ' ||&&cli||
                             ' Data Pagto: '|| &&dtpagto || 
                             ' Valor Pagto: '|| &&vlpago || 
--                           ' Valor Juros: '|| &&vljuro || 
--                           ' Carne/Parcela: '|| &&Carne || '/' || &&parcela );
  utl_file.fclose_all;     
  DBMS_OUTPUT.PUT_LINE(' ');
end;
/
