CREATE OR REPLACE FUNCTION public.fnc_retorna_nome_mãe(dcd_aluno numeric)
 RETURNS character varying
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
AS $function$


DECLARE

v_nome_mae varchar(100);
   
begin
    IF (mod(dcd_aluno,2)=0) then
    
	select ma.nm_mae  into v_nome_mae from mat_aluno ma where cd_aluno  = dcd_aluno;

	ELSE v_nome_mae := '';
	
	END IF;
	

 

    return ltrim(v_nome_mae);
end;

 

$function$
;