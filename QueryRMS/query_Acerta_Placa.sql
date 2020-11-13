--Consulta
select * from ag1lgnfi  where nfi_destino = '&Destino_sem_digito' and nfi_nota = '&nota_fiscal';

--Correção
update ag1lgnfi
   set nfi_transp_placa = '       ' ,nfi_transp_uf = ' '
where nfi_destino = '&Destino_sem_digito' and nfi_nota = '&nota_fiscal';

select nfi_origem,nfi_nota,nfi_serie,nfi_transp_placa,nfi_transp_uf 
  from ag1lgnfi 
   where  nfi_data_agenda = 1110512  
   and nfi_agenda = 44 
   and nfi_transp_placa = '*.*    ' for update
   --and nfi_origem  in(1) for update