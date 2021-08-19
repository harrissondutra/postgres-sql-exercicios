

drop view VIEW_MAT_ALUNO;
drop table MAT_MATRICULA;
drop table MAT_CURSO;
drop table MAT_ALUNO;
drop sequence SEQ_MAT_ALUNO;
drop sequence SEQ_MAT_CURSO;
drop sequence SEQ_MAT_MATRICULA;
drop table MAT_ALUNO_ADITORIA;
drop FUNCTION trigger_MAT_ALUNO;


-------------------------------------------------------------------------------

CREATE SEQUENCE SEQ_MAT_ALUNO
INCREMENT 1
START 1;

create table MAT_ALUNO
(
  CD_ALUNO NUMERIC(10) not null,
  NM_ALUNO VARCHAR(200) not null,
  DT_NASCIMENTO DATE not null,
  NM_MAE VARCHAR(200) not null,
  NM_PAI VARCHAR(200),
  CEP numeric,
  NM_ENDERECO VARCHAR(500)
);

alter table MAT_ALUNO add constraint CNT_ALUNO_PK primary KEY(CD_ALUNO);
CREATE  INDEX CONCURRENTLY IND_MAT_ALUNO_1  ON MAT_ALUNO (NM_ALUNO);
CREATE  INDEX CONCURRENTLY IND_MAT_ALUNO_2  ON MAT_ALUNO (DT_NASCIMENTO);
CREATE  INDEX CONCURRENTLY IND_MAT_ALUNO_3  ON MAT_ALUNO (NM_MAE);

-------------------------------------------------------------------------------

CREATE SEQUENCE SEQ_MAT_CURSO
INCREMENT 1
START 1;

create table MAT_CURSO 
(
  CD_CURSO numeric not null,
  NM_CURSO VARCHAR(100) not NULL
);


alter table MAT_CURSO add constraint CNT_MAT_CURSO_PK primary KEY(CD_CURSO);
CREATE UNIQUE INDEX CONCURRENTLY IND_MAT_CURSO_1  ON MAT_CURSO (NM_CURSO);

insert into MAT_CURSO values (NEXTVAL('SEQ_MAT_CURSO'),'ADMINISTRACAO');
insert into MAT_CURSO values (NEXTVAL('SEQ_MAT_CURSO'),'INFORMATICA');
commit;



-------------------------------------------------------------------------------

CREATE SEQUENCE SEQ_MAT_MATRICULA
INCREMENT 1
START 1;

create table MAT_MATRICULA
(
  CD_MATRICULA numeric not null,
  CD_ALUNO numeric not null,
  CD_CURSO numeric not null,
  DT_MATRICULA DATE default CURRENT_DATE
);

alter table MAT_MATRICULA add constraint CNT_MAT_MATRICULA_PK primary KEY(CD_MATRICULA);
alter table MAT_MATRICULA add constraint CNT_MAT_MATRICULA_ALUNO_FK foreign key (CD_ALUNO) references MAT_ALUNO(CD_ALUNO);
alter table MAT_MATRICULA add constraint CNT_MAT_MATRICULA_CRUSO_FK foreign key (CD_CURSO) references MAT_CURSO(CD_CURSO);
CREATE UNIQUE INDEX CONCURRENTLY IND_MAT_MATRICULA_1  ON MAT_MATRICULA (CD_ALUNO);
CREATE UNIQUE INDEX CONCURRENTLY IND_MAT_MATRICULA_2  ON MAT_MATRICULA (CD_ALUNO,CD_CURSO);

-------------------------------------------------------------------------------


create table MAT_ALUNO_ADITORIA AS
select * from MAT_ALUNO;

alter table MAT_ALUNO_ADITORIA add  DT_AUDITORIA DATE;


CREATE OR REPLACE FUNCTION trigger_MAT_ALUNO()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
 
declare   
   V_CD_ALUNO  numeric;
  
begin		
	  
 insert into MAT_ALUNO_ADITORIA
	(
	  CD_ALUNO ,
	  NM_ALUNO ,
	  DT_NASCIMENTO ,
	  NM_MAE ,
	  NM_PAI,
	  CEP ,
	  NM_ENDERECO,
	  DT_AUDITORIA)
	   values
	      (   new.CD_ALUNO ,
			  new.NM_ALUNO ,
			  new.DT_NASCIMENTO ,
			  new.NM_MAE ,
			  new.NM_PAI ,
			  new.CEP ,
			  new.NM_ENDERECO,
			  NOW());
    
		
return new;
end;

$function$
;


create trigger trigger_trg_MAT_ALUNO AFTER
insert or UPDATE
    on
    MAT_ALUNO for each row execute procedure trigger_MAT_ALUNO();

   
   
 create or replace view VIEW_MAT_ALUNO AS
 select A.*,'A' TIPO  from MAT_ALUNO A;
 
 
 
 DO LANGUAGE plpgsql
$body$

declare
  j RECORD;
  v_contador numeric;
  v_quantidade numeric;
    
   
  begin
	   v_contador :=1;
	   v_quantidade := 100;
	  

	  WHILE v_quantidade != v_contador LOOP
        
       insert into MAT_ALUNO values (nextval('SEQ_MAT_ALUNO'),
                                                'NOME ALUNO '||v_contador,
                                                 NOW()-interval '3 days',
                                                'NOME MAE '||v_contador,
                                                 NULL,
                                                 60000000+v_contador,
                                                 'ENDERECO '||v_contador);
        
        RAISE INFO '%', 'Linha : 0'||v_contador;  
        v_contador := v_contador +1;
       
       
      END LOOP;
         
  

 end;
  $body$  