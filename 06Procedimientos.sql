-- Procedimientos almacenados
-- ejemplo para mostrar un mensaje por pantalla
create or replace procedure sp_mensaje
AS
begin   
    -- mostramos un mensaje
    dbms_output.put_line('Hoy es juernes con musica!!!');
end;
-- llamamos al procedimiento
begin
    sp_mensaje;
end;

exec sp_mensaje; -- llamamos al procedimiento

-----------------------------------------------------------------

create or replace procedure sp_ejemplo_plsql
AS
BEGIN
-- procedimiento con bloque anónimo plsql
    declare 
        v_numero number;
    begin
        v_numero := 14;
        if v_numero > 0 then
        dbms_output.put_line('Positivo');
        else
        dbms_output.put_line('Negativo');
        end if;
    end;     
END;
-- llamamos al procedimiento
begin
    sp_ejemplo_plsql;
end;

-- tenemos otra sintaxis para tener variables, dentro de un procedimiento no se utiliza la palabra DECLARE
create or replace procedure sp_ejemplo_plsql2
AS
    v_numero number; -- declaramos la variable
BEGIN
    if v_numero > 0 then
        dbms_output.put_line('Positivo');
    else
        dbms_output.put_line('Negativo');
    end if;
end;
-- llamamos al procedimiento
begin
    sp_ejemplo_plsql2;
end;

-----------------------------------------------------------------

-- Procedimiento para sumar dos números
create or replace procedure sp_sumar_numeros 
(p_numero1 number, p_numero2 number)
AS
    v_suma number; 
BEGIN
        v_suma := p_numero1 + p_numero2; -- suma de los dos números
        dbms_output.put_line('La suma de ' || p_numero1 || ' + ' || p_numero2 || ' es igual a ' || v_suma); -- mostramos el resultado
END;    

-- llamamos al procedimiento
begin
    sp_sumar_numeros(10, 20); -- pasamos los números a sumar
end;

-----------------------------------------------------------------

--  Necesito un procedimiento para dividir dos numeros y que cuando se haga la division entre 0 de un aviso de error. se hara con exeption
-- se llamara sp_dividir_numeros
create or replace procedure sp_dividir_numeros
(p_numero1 number, p_numero2 number)
AS
    v_division number; -- variable para almacenar el resultado de la división
BEGIN
   v_division := p_numero1 / p_numero2; -- división de los dos números
   dbms_output.put_line('La división de ' || p_numero1 || ' / ' || p_numero2 || ' es igual a ' || v_division); -- mostramos el resultado    
EXCEPTION
    WHEN ZERO_DIVIDE THEN -- excepción para división entre 0
        dbms_output.put_line('Error: División entre 0 no permitida.'); -- mostramos el error
END;
-- llamamos al procedimiento
begin
    sp_dividir_numeros(10, 0); -- pasamos los números a dividir
EXCEPTION
    when ZERO_DIVIDE then -- excepción para división entre 0
        dbms_output.put_line('Error: División entre 0 no permitida.'); -- mostramos el error     
end;