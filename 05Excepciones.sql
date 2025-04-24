-- Capturar una excepcion del sistema
declare 
    v_numero1 number := &&numero1;
    v_numero2 number := &&numero2;
    v_division number;
begin
    v_division := v_numero1 / v_numero2;
    dbms_output.put_line('La division es: ' || v_division);
exception
    when zero_divide then
        dbms_output.put_line('No se puede dividir entre cero');
end;
undefine numero1;
undefine numero2;

select * from emp;

-- Cuando los empleados tengan una comision con valor 0, se lanzara una excepcion. 
-- Tendremos una tabla donde almacenaremos los empleados con comision mayor a cero.  
create table emp_comision (apellido varchar2(50), comision number(9));

declare  
cursor cursor_emp is 
    select apellido, comision 
    from emp 
    order by comision desc;
    exception_comision exception;
begin    
    for v_record in cursor_emp
    loop  
        if (v_record.comision = 0) THEN
            raise exception_comision;
        else
            insert into emp_comision (apellido, comision) values (v_record.apellido, v_record.comision);    
        end if;
    end loop;
exception
    when exception_comision then
        dbms_output.put_line('Comisiones a ZERO'); 
    -- quiero detener esto cuando la comision sea 0
end;

-- Pragma exception_init nos permite asociar un error de excepcion a un error de sistema.
DECLARE
    exception_nulos EXCEPTION;
    PRAGMA EXCEPTION_INIT(exception_nulos, -1400); -- error de no nulo
BEGIN
    insert into dept values (null, 'departamento', 'pragma');
EXCEPTION
    when exception_nulos then
        dbms_output.put_line('Error de no nulo');
END;
--------------------------
declare 
    v_id number;
begin  
    select dept_no into v_id 
    from dept
    where dnombre = 'Ventas';
    dbms_output.put_line('El id del departamento Ventas es: ' || v_id);
EXCEPTION
    when too_many_rows then
        dbms_output.put_line('Demasiadas filas en el cursor');
    when others then -- captura cualquier error
        dbms_output.put_line(to_char (sqlcode) || '  ' || sqlerrm);
end;
--------------------------
declare 
    v_id number;
begin 
    RAISE_APPLICATION_ERROR(-20400, 'Puedo hacer esto con un exception?????'); 
    select dept_no into v_id 
    from dept
    where dnombre = 'Ventas';
    dbms_output.put_line('El id del departamento Ventas es: ' || v_id);
end;
--------------------------




