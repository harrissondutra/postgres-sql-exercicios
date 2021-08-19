 DO LANGUAGE plpgsql
$body$

 

declare
  j RECORD;
  v_qte_linha numeric;
   
  begin
        v_qte_linha := v_qte_linha + 1;
       
   FOR j IN (
         select cd_aluno from mat_aluno ma 
   ) loop
         if  (mod(j.cd_aluno,2)=0) then
           insert into mat_matricula  values (nextval('public.SEQ_MAT_MATRICULA'),j.cd_aluno,1);
          else
             insert into mat_matricula  values (nextval('public.SEQ_MAT_MATRICULA'),j.cd_aluno,2);
         end if;
                                                 
    RAISE INFO '%', 'Processando na linha : 0'||v_qte_linha||' Codigo aluno - '||j.cd_aluno;    
     
   END loop;

 

 end;
  $body$    ;