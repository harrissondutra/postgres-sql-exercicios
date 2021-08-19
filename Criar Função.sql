CREATE OR REPLACE FUNCTION public.fnc_retorna_data(dcd_aluno numeric)
 RETURNS date 
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
AS $function$


DECLARE

v_data date;
   
begin
   
	SELECT dt_nascimento INTO v_data FROM public.mat_aluno ma WHERE cd_aluno = dcd_aluno;
	
    return (v_data);
end;

 

$function$
;

 


