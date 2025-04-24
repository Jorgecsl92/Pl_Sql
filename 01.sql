declare 
    -- MI COMENTARIO
    -- DECLARAMOS UNA VARIABLE
    numero int;
    texto varchar2(50);
begin 
    texto := 'mi primer PL/SQL';
    dbms_output.put_line('Mensaje: ' || texto );
    dbms_output.put_line('Mi primer bloque anonimo');
    numero := 44;
    dbms_output.put_line(' Valor numero: ' || numero );
    numero := 22;
    dbms_output.put_line(' Valor numero nuevo: ' || numero );
end;


declare 
    nombre varchar2(30);
begin 
    nombre := '&dato';
    dbms_output.put_line('Su nombre es ' || nombre);
end;


declare    
    fecha date;
    texto varchar2(50);
    longitud int;
begin 
    fecha := sysdate;
    texto := '&data';
    -- ALMACENAMOS LA LONGITUD DEL TEXTO
    longitud := length(texto);
    -- LA LONGITUD DE SU TEXTO ES 41
    dbms_output.put_line('La longitud del texto es ' || longitud);
    -- HOY ES .....Miercoles
    dbms_output.put_line('Hoy es ' || to_char(fecha, 'day'));
    dbms_output.put_line(texto);
end;


-- REALIZA UN PROGRAMA DONDE PEDIREMOS DOS NUMEROS AL USUARIO.
-- MOSTRAREMOS POR PANTALLA LA SUMA
-- ¿QUE INFORMACION TENGO QUE GUARDAR?
-- numero1 numero2 suma
declare 
    numero1 int;
    numero2 int;
    suma int;
begin
    numero1 := &num1;
    numero2 := &num2; 
    suma := numero1 + numero2; 
    dbms_output.put_line('La suma de ' || numero1 || ' + ' || numero2 || ' = ' || suma);
end;
-- QUITAR LA DEFINICION DE LAS VARIABLES
undefine num1;
undefine num2;


-- COMBINAR SENTENCIAS PL-SQL CON SENTENCIAS SQL
-- NO PODEMOS HACER select PARA MOSTRAR DATOS
declare 
    -- DECLARAMOS UNA VARIABLE PARA ALMACENAR EL NUMERO DE DEPARTAMENTO
    v_departamento int;
begin 
    -- PEDIMOS UN NUMERO AL USUARIO
    v_departamento := &dept;
    update emp set salario = salario + 1 
    where dept_no = v_departamento;
end;
undefine dept;
select * from emp;