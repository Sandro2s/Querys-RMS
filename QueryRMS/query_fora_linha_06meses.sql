SELECT  to_number(aa.git_cod_item||aa.git_digito)                         AS codigo,
  aa.git_descricao                                                        AS nome,
  aa.git_secao                                                            AS secao,
  aa.git_grupo                                                            AS grupo,
  aa.git_subgrupo                                                         AS subgrupo,
  rmsto_date(aa.git_dat_sai_lin)                                          AS Dta_Fora_Linha
 
FROM aa3citem aa
WHERE aa.git_depto NOT    IN (6,200) 
AND rmsto_date(aa.git_dat_sai_lin) > add_months(to_date(sysdate,'dd/mm/yy'),-6) 
AND aa.git_envia_pdv     = 'S'
AND aa.git_secao in (100,101,102,103,104,105,106,107,108,109,110,111,112,200,201,300,301,302,303,304,305,306,400,401,402,403,501)
order by secao,grupo,subgrupo,dta_fora_linha

