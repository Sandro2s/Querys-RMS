-- Supermercado S�o Roque Ltda.
-- Data : 17/04/09 (Validado com a Locatelli)
-- Sandro Soares
-- Descri��o : Desenvolvida para extrar os valores vendidos por loja com base nos produtos ajustado para Pis/Cofins.
-- Saidas de produtos.
-- Manuten��o : 09/09/09
select --ie.eschljc_codigo as cod_number,
       --ie.eschljc_codigo || '-' || ie.eschljc_digito as Cod_Loja,
       aa.git_cod_item || '-' || aa.git_digito as Codigo,
       it.det_class_fis as NCM,
       aa.git_descricao as Descricao,
       sum(ie.entsaic_quanti_un) as Quant,
       ie.eschc_nro_nota as Nr_NF,
       rms7to_date(ie.eschc_data) as Data_Saida,
       -- to_number(ag.eschlj_codigo||ag.eschlj_digito,'fm999999999')  as Cod_Fornecedor,
       -- tp.tip_razao_social                                          as Nome_Fornec,
       sum(Round(ie.entsaic_prc_un * ie.entsaic_quanti_un, 2)) as Valor_Venda,
       sum(ie.entsaic_vlr_icm) as Valor_Icms,
       sum(ie.entsaic_perc_ipi) as IPI_Perc,
       sum(ie.entsaic_valor_ipi) as Valor_IPI

  from ag1iensa ie, aa3citem aa, aa1ditem it, aa2ctipo tp
 where ie.esitc_codigo = aa.git_cod_item
   and ie.esitc_codigo in
       (84, 87, 88, 189, 199, 203, 205, 877, 885, 935, 1222, 1340, 1472, 1473, 
         1475,  1482,  1483,  1485,  1486,  1545,  1586,  1594,  1761,  1771, 
         1771,  1775,  1776,  1792,  1800,  1815,  1816,  1817,  1819,  1820, 
         1821,  1822,  1824,  1837,  1838,  1996,  1997,  1998,  1999,  2082, 
         2170, 2173, 2231, 2233, 2235, 2247, 2258, 2274, 2290, 2290, 2292, 2292, 
         2304, 2306, 2308, 2344, 2404, 2406, 2492, 2510, 2522, 2532, 2534, 2551, 
         2559, 2561, 2567, 2587, 2595, 2603, 2607, 2613, 2617, 2645, 2668, 2686, 
         2791, 2795, 2799, 2825, 2895, 2897, 2899, 2901, 2903, 2919, 2965, 2975, 
         3175, 3181, 3211, 3217, 3221, 3223, 3263, 3279, 3488, 3498, 3502, 3504, 
         3574, 3576, 3617, 3655, 3657, 3659, 3740, 3741, 3742, 4952, 4994, 6056, 
         6296, 8490, 9787, 9829,
        10079, 10649, 10650, 10658, 10661, 10662, 10663, 10665, 10666, 10678,
        10681, 10689, 10690, 10691, 10692, 10847, 10848, 10851, 10853, 10854,
        10855, 10873, 10875, 10876, 10877, 10880, 10883, 10885, 10969, 13785,
        13789, 13791, 15095, 15112, 16887, 16888, 18853, 19054, 20133, 21415,
        22403, 22404, 22405, 22575, 22665, 23666, 23749, 24060, 24132, 24192,
        24195, 24302, 24676, 24677, 24680, 25341, 26247, 26248, 26257, 26276,
        26287, 26288, 26338, 26339, 26340, 26341, 26556, 26733, 26781, 26782,
        26783, 26869, 26870, 26986, 27002, 27068, 27072, 27082, 27083, 27084,
        27085, 27088, 27091, 27092, 27095, 27097, 27098, 27101, 27169, 27170,
        27171, 27172, 27173, 27310, 27311, 27312, 27313, 27314, 27317, 27318,
        27320, 27351, 27354, 27366, 27368, 27369, 27371, 27376, 27377, 27378,
        27379, 27380, 27381, 27382, 27383, 27384, 27734, 27868, 27997, 28069,
        28230, 28425, 28580, 28658, 28840, 28972, 28973, 28975, 28976, 28977,
        31914, 34299, 34900, 34901, 40596, 40597, 48876, 59894, 62459, 65588,
        65589, 65604, 66164, 66266, 66711, 66712, 66736, 66738, 66739, 67611,
        67615, 67619, 67625, 67711, 70015, 70907, 72703, 72705, 72707, 72709,
        72713, 72715, 72787, 75677, 75679, 76893, 77405, 79878, 81302, 81308,
        81324, 81336, 85569, 87088, 87236, 87278, 8722, 87426, 87876, 87932,
        88104, 92488, 92840, 92842, 92844, 94228, 94232, 95284, 96439, 97833,
        97910, 97912, 97914, 98044, 98862, 99088, 99088, 99090, 99090, 99098,
        99098, 99100, 99102, 99108, 99120, 99120, 99133, 99133, 99182, 99182,
        99202, 99202, 99204, 99204, 99270, 99270, 99295, 99295, 99306, 99306,
        99308, 99308, 99310, 99310, 99310, 99475, 99616, 100561, 100566,
        100983, 100983, 100983, 101171, 101175, 101177, 101181, 101183,
        101185, 101189, 101191, 101193, 101195, 101606, 101608, 102131,
        106673, 106688, 108686, 108688, 109059, 109061, 109532, 109534,
        110997, 112185, 112671, 112674, 112680, 112682, 112684, 113409,
        113411, 113476, 113855, 113879, 113881, 113885, 113892, 114475,
        114477, 116133, 116135, 116139, 116624, 118685, 118687, 118689,
        118691, 118693, 121200, 121202, 121220, 121222, 121224, 121226,
        121240, 121251, 121699, 122628, 122745, 122945, 123270, 123343,
        125542, 125609, 125617, 125633, 125666, 125849, 125872, 126177,
        126219, 127552, 127730, 127734, 127736, 127742, 127744, 127748,
        131403, 131405, 132940, 133245, 133247, 133251, 133253, 133255,
        133257, 133259, 133261, 133263, 133265, 133267, 133476, 133478,
        133544, 134551, 134734, 134932, 135111, 135160, 135426, 135459,
        135855, 136234, 136465, 136747, 136812, 137091, 137133, 137174,
        137208, 137240, 138024, 138115, 138263, 139063, 140673, 140707,
        140772, 140806, 140848, 140855, 140913, 140954, 140962, 143602,
        143792, 145524, 147934, 150375, 150391, 150433, 150458, 150508,
        151464, 151530, 151571, 153320, 153338, 153346, 153460, 153544,
        154500, 155150, 155184, 157594, 157636, 158337, 158626, 165738,
        181289, 181974, 183814, 183822, 185017, 186163, 188532, 188540,
        188557, 188565, 188573, 188581, 193631, 196659, 196667, 210377,
        219550, 221176, 221564, 226365, 227629, 227637, 230433, 257204,
        258582, 261065, 263145, 263160, 263178, 264010, 268482, 275941,
        275958, 275974, 275982, 278184, 281584, 285452, 285700, 288860,
        290510, 294306, 296079, 309914, 310052, 310060, 317875, 317990,
        327833, 327841, 329409, 339341, 339481, 343640, 343657, 343665,
        345108, 349985, 349993, 350009, 350017, 350025, 350033, 350876,
        351189, 351197, 351247, 351262, 351270, 352922, 354050, 354415,
        354688, 354696, 354704, 355842, 359885, 359893, 359901, 360149,
        360156, 360164, 360172, 360180, 360198, 360206, 360214, 360222,
        361071, 364406, 364851, 370023, 370031, 370049, 370056, 370395,
        370437, 376871, 376905, 377549, 377762, 378042, 383422, 383430,
        383455, 384388, 384917, 385054, 386326, 388546, 388553, 388561, 
        69, 70, 81, 82, 133,
        27129, 28268, 33623, 60809, 60850, 60851, 60871, 60879, 60901, 60902,
        60911, 60912, 60915, 60921, 60922, 60923, 60931, 60932, 60939, 60940,
        60941, 66020, 66032, 66051, 66052, 66054, 66055, 66269, 66311, 66847,
        66849, 67631, 69257, 69259, 69261, 69263, 69265, 69499, 69501, 69505,
        69507, 69509, 69511, 69513, 69515, 69517, 72409, 72413, 80230, 81090,
        81092, 81094, 84676, 91032, 91052, 92114, 92116, 95302, 97799,
        100564, 108643, 118260, 121329, 121331, 121335, 123060, 123246,
        123252, 127268, 127270, 386987, 390997)
   and ie.eschc_data between  1111001 and 1111031
   and ie.eschc_agenda in ('53', '49', '68', '673')
   and it.det_cod_item = aa.git_cod_item
   and tp.tip_codigo = ie.eschljc_codigo
   
 Group by ie.eschc_data,git_cod_item, aa.git_digito,it.det_class_fis,aa.git_descricao,ie.eschc_nro_nota
 order by data_saida,descricao --cod_number, data_saida asc

/*select * from ag1iensa ie where ie.eschc_data = 1090301 and ie.eschc_agenda = 53
   and ie.eschljc_codigo = 2 and ie.esitc_codigo = 115366*/
   
    