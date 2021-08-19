CREATE OR REPLACE FUNCTION public.fnc_retorna_nome_aluno(dcd_aluno numeric)
 RETURNS character varying
 LANGUAGE plpgsql
 STABLE SECURITY DEFINER
AS $function$

 

DECLARE

 

  v_nome_aluno varchar(100);
   
begin
    select ma.nm_aluno  into v_nome_aluno from mat_aluno ma where cd_aluno  = dcd_aluno;

 

    return ltrim(v_nome_aluno);
end;

 

$function$
;