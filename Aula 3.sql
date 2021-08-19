DO LANGUAGE plpgsql
$body$

 

declare
  j RECORD;
  v_contador numeric;
  v_quantidade numeric;
    
   
  begin
       v_contador :=301;
       v_quantidade := 400;
      

 

      WHILE v_quantidade != v_contador LOOP
        
       insert into MAT_ALUNO values (nextval('SEQ_MAT_ALUNO'),
                                                'NOME ALUNO '||v_contador,
                                                 NOW()-interval '120 days',
                                                'NOME MAE '||v_contador,
                                                 NULL,
                                                 60000000+v_contador,
                                                 'ENDERECO '||v_contador);
        
        RAISE INFO '%', 'Linha : 0'||v_contador;  
        v_contador := v_contador +1;
      
      END LOOP;
       
 end;
  $body$;
 
 
ALTER TABLE public.mat_matricula ALTER COLUMN dt_matricula TYPE timestamp(0) USING dt_matricula::timestamp;
ALTER TABLE public.mat_matricula ALTER COLUMN dt_matricula SET DEFAULT CURRENT_TIMESTAMP;


CREATE OR REPLACE VIEW view_matricula AS 
SELECT fnc_retorna_nome_aluno(cd_aluno), fnc_retorna_idade(fnc_retorna_data(cd_aluno)) AS idade ,m.*, fnc_retorna_data(cd_aluno) FROM mat_matricula m 

 SELECT * FROM public.view_matricula 
 
 DROP VIEW view_matricula 