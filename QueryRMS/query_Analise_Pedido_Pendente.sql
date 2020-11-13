SELECT CAR.NROPED_CAR                      AS NROPED_CAR,
       TIP.TIP_NOME_FANTASIA                        AS DESCLOJA,
       CAR.CODFOR_CAR||DAC(CAR.CODFOR_CAR) AS FORNEC,
       CAR.TIP_LOJ_CLI,
       CAR.CODFOR_CAR                      AS CODFOR_CAR ,
       CAR.CODLOJ_CAR                      AS CODLOJ_CAR ,
       CAR.CODLOJ_CAR||DAC(CAR.CODLOJ_CAR) AS LOJA,
       CAR.DIGPED_CAR                      AS DIGPED_CAR,
       CAR.NROPED_CAR||CAR.DIGPED_CAR      AS PEDIDO,
       CAR.COND_PAG_CAR                    AS COND_PAG_CAR,
       CAR.TRANSP_CAR                      AS TRANSP_CAR,
       CAR.FRETE_CAR                       AS FRETE_CAR,
       CAR.PAGMTO_CAR                      AS PAGMTO_CAR,
       CAR.OBS_CAR                         AS OBS_CAR,
       SUBSTR(TO_CHAR(CAR.DTAEMI_CAR,'fm000000'),1,2)||'/'||SUBSTR(TO_CHAR(CAR.DTAEMI_CAR,'fm000000'),3,2)||'/'||SUBSTR(TO_CHAR(CAR.DTAEMI_CAR,'fm000000'),5,2) as DataEmissao,
       SUBSTR(TO_CHAR(CAR.DTAINI_CAR,'fm000000'),1,2)||'/'||SUBSTR(TO_CHAR(CAR.DTAINI_CAR,'fm000000'),3,2)||'/'||SUBSTR(TO_CHAR(CAR.DTAINI_CAR,'fm000000'),5,2) as DataInicial,
       SUBSTR(TO_CHAR(CAR.DTAFIM_CAR,'fm000000'),1,2)||'/'||SUBSTR(TO_CHAR(CAR.DTAFIM_CAR,'fm000000'),3,2)||'/'||SUBSTR(TO_CHAR(CAR.DTAFIM_CAR,'fm000000'),5,2) as DataFinal,
       CAR.DTAEMI_CAR                      AS DTAEMI_CAR,
       CAR.DTAINI_CAR                      AS DTAINI_CAR,
       CAR.DTAFIM_CAR                      AS DTAFIM_CAR,
       CAR.COMPR_CAR                       AS COMPR_CAR,
       CAR.SLD_LIQ_CAR                     AS SLD_LIQ_CAR,
       CAR.TIP_NOME_FANTASIA               AS DESCFORNEC,
       CAR.TIP_RAZAO_SOCIAL                AS DESCFORNECRAZAO,
       ST1_CAR, ST2_CAR, NVL(PVA_PED_CMP,0) AS PVA_PED_CMP, NVL(PVA_FLAG,0) AS PVA_FLAG,
       NVL(FOR_ENTREGA,0)                  AS FOR_ENTREGA,
       CAR.MOE_INDICE_CMP                  AS INDICE,
       CAR.SLD_LIQ_CAR  / DECODE(NVL(CAR.MOE_INDICE_CMP,0),0,1,NVL(CAR.MOE_INDICE_CMP,0)) AS SLD_CONVERT,
       (SELECT COUNT(*)
        FROM AG2CCADD
        WHERE CDT_PEDIDO = CAR.NROPED_CAR
        AND   CDT_DIGITO = CAR.DIGPED_CAR) AS GRADE
FROM AA2CTIPO TIP, AG1VAPED, AA2CFORN,

     (SELECT DISTINCT TIP_NOME_FANTASIA,
             TIP_RAZAO_SOCIAL,
             TIP_LOJ_CLI,
             CODFOR_CAR,
             CODLOJ_CAR,
             NROPED_CAR,
             DIGPED_CAR,
             COND_PAG_CAR,
             PAGMTO_CAR,
             TRANSP_CAR,
             FRETE_CAR,
             DTAEMI_CAR,
             DTAINI_CAR,
             DTAFIM_CAR,
             OBS_CAR,
             COMPR_CAR,
             SLD_LIQ_CAR,
             ST1_CAR, ST2_CAR,
             MOE_INDICE_CMP
      FROM AG1LPEDI, AA2CTIPO, AG1MPEDI
      WHERE TIP_CODIGO = CODFOR_CAR
      AND   TIP_DIGITO = DAC(CODFOR_CAR)
      AND   NROPED_CAR = NROPED_MOE (+)
      AND   CODLOJ_CAR = CODLOJ_MOE (+)) CAR
WHERE TIP.TIP_CODIGO  = CAR.CODLOJ_CAR
AND   TIP_DIGITO      = DAC(CAR.CODLOJ_CAR)
AND   TIP_CODIGO      > 0
AND   CODFOR_CAR      = 100
--AND   CODLOJ_CAR     IN(1)
AND   SLD_LIQ_CAR     > .10
AND   PVA_LOJA     (+)= CAR.CODLOJ_CAR
AND   PVA_PED_CMP  (+)= CAR.NROPED_CAR
AND   FOR_CODIGO   (+)= CODFOR_CAR
AND   FOR_DIG_FOR  (+)= DAC(CODFOR_CAR)
and    CAR.OBS_CAR like 'REFORÇO MANUAL%'--'ABASTECIMENTO%' --'REFORÇO MANUAL%' 
and   dtaemi_car = 300818 

