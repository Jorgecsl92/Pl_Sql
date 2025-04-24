-- DECLARAR VARIABLES COMO SUBTIPO DE LA TABLA.
declare 
    v_numero dept.dept_no%type;
    v_nombre dept.dnombre%type;
    v_localidad dept.loc%type;
begin 
    v_numero := &numero;
    v_nombre := '&nombre';
    v_localidad := '&localidad';
    insert into dept values (v_numero, v_nombre, v_localidad);
end;
undefine numero;
undefine nombre;
undefine localidad;


-- PRÁCTICA: FUNDAMENTOS PL-SQL --
-- 1. Crear un bloque anónimo que sume dos números introducidos por teclado y muestre el resultado por pantalla.
DECLARE
	V_NUMERO1 NUMBER := &NUM1;
	V_NUMERO2 NUMBER := &NUM2;
	V_RESUL NUMBER;
BEGIN
	V_RESUL := V_NUMERO1 + V_NUMERO2;
DBMS_OUTPUT.PUT_LINE(V_RESUL);
END;

-- 2. Insertar en la tabla EMP un empleado con código 9999 asignado directamente en la variable con %TYPE, apellido ‘PEREZ’, oficio ‘ANALISTA’ y código del departamento al que pertenece 10.
DECLARE 
	V_EMP EMP.EMP_NO%TYPE := 9999;
BEGIN
	INSERT INTO EMP(EMP_NO, APELLIDO,OFICIO, DEPT_NO)
	VALUES(V_EMP,’PEREZ’,’ANALISTA’,10);
COMMIT;
END;

-- 3.  Incrementar el salario en la tabla EMP en 200 EUROS a todos los trabajadores que sean ‘ANALISTA’, mediante un bloque anónimo PL, asignando dicho valor a una variable declarada con %TYPE.
DECLARE
	V_INCREMENTO EMP.SALARIO%TYPE := 200;
BEGIN
	UPDATE EMP
	SET SALARIO = SALARIO + V_INCREMENTO
	WHERE OFICIO = ‘ANALISTA’;
COMMIT;
END;

-- 4. Realizar un programa que devuelva el número de cifras de un número entero, introducido por teclado, mediante una variable de sustitución.
DECLARE
	V_NUM NUMBER := &NUM;
BEGIN
DBMS_OUTPUT.PUT_LINE('EL NUMERO '||V_NUM||' TIENE UNA LONGITUD DE '||LENGTH(V_NUM));
END;

-- 5.  Crear un bloque PL para insertar una fila en la tabla DEPT. Todos los datos necesarios serán pedidos desde teclado.
DECLARE
	V_DEPTNO NUMBER := &DEPTNO;
	V_LOC VARCHAR2(30) := ‘&LOC’;
	V_DNAME VARCHAR2(30) := ‘&DNAME’;
BEGIN
	INSERT INTO DEPT
	VALUES(V_DEPTNO, V_LOC, V_DNAME);
COMMIT;
END;

-- 6.   Crear un bloque PL que actualice el salario de los empleados que no cobran comisión en un 5%.
DECLARE
	V_INCREMENTO NUMBER := 0.05;
BEGIN
	UPDATE EMP
	SET SALARIO = SALARIO + (SALARIO * V_INCREMENTO)
	WHERE COMISION IS NULL;
	
END;

-- 7.  Crear un bloque PL que almacene la fecha del sistema en una variable. Solicitar un número de meses por teclado y mostrar la fecha del sistema incrementado en ese número de meses.
DECLARE 
	V_DATE DATE := SYSDATE;
	V_MESES NUMBER := &MESES;
BEGIN
	DBMS_OUTPUT.PUT_LINE(ADD_MONTHS(V_DATE, V_MESES));
END;

-- 8. Introducir dos números por teclado y devolver el resto de la división de los dos números.
DECLARE
  V_NUMERO1 NUMBER := &NUM1;
  V_NUMERO2 NUMBER := &NUM2;
  V_RESUL NUMBER;
BEGIN
  V_RESUL := MOD(V_NUMERO1,V_NUMERO2);
DBMS_OUTPUT.PUT_LINE(V_RESUL);
END;

-- 9. Solicitar un nombre por teclado y devolver ese nombre con la primera inicial en mayúscula.
DECLARE
  apellido varchar2(15) := '&dato';
  V_RESUL varchar2(15);
BEGIN
  V_RESUL :=INITCAP(apellido);
DBMS_OUTPUT.PUT_LINE(V_RESUL);
END;

-- 10.  Crear un bloque anónimo que permita borrar un registro de la tabla emp introduciendo por parámetro un número de empleado.
DECLARE
  V_NUM NUMBER := &NUM;
BEGIN
DELETE FROM EMP WHERE EMP_NO=&NUM;
COMMIT;
END;

-- ESTRUCTURAS PL.SQL
-- DEBEMOS COMPROBAR SI UN NUMERO ES POSITIVO O NEGATIVO
declare 
    v_numero int;
begin
    -- PEDIMOS EL NUMERO AL USUARIO
    v_numero := &numero;
    --PREGUNTAMOS POR EL PROPIO NUMERO
    if (v_numero >= 0) then
        dbms_output.put_line('Positivo: ' || v_numero);
    else
         dbms_output.put_line('Negativo: ' || v_numero);
    end if;
    dbms_output.put_line('Fin de programa');
end;
undefine numero;

-- DEBEMOS COMPROBAR SI UN NUMERO ES POSITIVO, NEGATIVO o CERO
declare 
    v_numero int;
begin
    v_numero := &numero;
    if (v_numero > 0) then  
        dbms_output.put_line('Es positivo....' || v_numero);
    elsif (v_numero = 0) then
        dbms_output.put_line('Es cero!!! ' || v_numero);
    else
        dbms_output.put_line('Negativo: ' || v_numero);
    end if;
    dbms_output.put_line('Fin de programa 2');
end;

declare 
    v_numero int;
begin
    v_numero := &numero;
    if (v_numero > 0) then  
        dbms_output.put_line('Es positivo....' || v_numero);
    elsif (v_numero = 0) then
        dbms_output.put_line('Es cero!!! ' || v_numero);
    elsif (v_numero < 0) then
        dbms_output.put_line('Negativo: ' || v_numero);
    end if;
    dbms_output.put_line('Fin de programa 2');
end;
undefine numero;

-- PEDIR UN NUMERO AL USUARIO DEL 1 AL 4
    -- 1.PRIMAVERA
    -- 2.VERANO
    -- 3.OTOÑO
    -- 4.INVIERNO
-- SI NOS DA OTRO NUMERO, LE INDICAMOS QUE ES UN ERROR 

declare 
    v_estacion int;
begin
    v_estacion := &estacion;
    if (v_estacion = 1) then  
        dbms_output.put_line('Es primavera ' || v_estacion);
    elsif (v_estacion = 2) then
        dbms_output.put_line('Es verano ' || v_estacion);
    elsif (v_estacion = 3) then
        dbms_output.put_line('Es otoño ' || v_estacion);
    elsif (v_estacion = 4) then
        dbms_output.put_line('Es invierno ' || v_estacion);
    else 
        dbms_output.put_line('Es un error ' || v_estacion);
    end if;
        dbms_output.put_line('Fin de programa ');
end;
undefine estacion;

-- PEDIREMOS DOS NUMEROS AL USUARIO Y DEBEMOS DEVOLVER QUE NUMERO ES MAYOR.
declare
    v_numero1 int;
    v_numero2 int;
begin
    v_numero1 := &numero1;
    v_numero2 := &numero2;
    if  (v_numero1 > v_numero2) then
        dbms_output.put_line(v_numero1 || ' Es mayor ' || v_numero2);
    elsif  (v_numero2 > v_numero1) then
        dbms_output.put_line(v_numero2 || ' Es mayor ' || v_numero1);
    end if;
end;
undefine numero1;
undefine numero2;

-- PEDIR UN NUMERO AL USUARIO E INDICAR SI ES PAR O IMPAR
declare 
    v_numero int;
begin 
    v_numero := &numero;
    if (mod (v_numero , 2) = 0) then 
        dbms_output.put_line ('El numero es par');
    else 
        dbms_output.put_line ('El numero es impar'); 
    end if;
end;
undefine numero;

-- POR SUPUESTO, PODEMOS PERFECTAMENTE UTILIZAR CUALQUIER OPERADOR, TANTO DE COMPARACION,
-- COMO RELACIONAL EN NUESTROS CODIGOS.LOGMNR$COL_GG_TABF_PUBLIC

-- PEDIR UNA LETRA AL USUARIO. SI LA LETRA ES VOCAL (a,e,i,o,u) PINTAMOS VOCAL, SINO, CONSONANTE
declare 
    v_letra varchar2(1);
begin 
    v_letra := lower('&letra'); -- la hacemos minusculas
    if (v_letra = 'a' or v_letra = 'e' or v_letra= 'i' or v_letra= 'o' or v_letra= 'u') then
        dbms_output.put_line('Vocal ' || v_letra);
    else 
        dbms_output.put_line('Consonante ' || v_letra);
    end if;
     dbms_output.put_line('Fin de programa ');
end;
undefine letra;

-- PEDIR TRES NUMEROS AL USUARIO
-- DEBEMOS MOSTRAR EL MAYOR DE ELLOS Y EL MENOR DE ELLOS
declare 
    v_numero1 int;
    v_numero2 int;
    v_numero3 int;
begin 
    v_numero1 := &numero1;
    v_numero2 := &numero2;
    v_numero3 := &numero3;
    if (v_numero1 > v_numero2 and v_numero1 > v_numero3) then 
        dbms_output.put_line('Mayor ' || v_numero1);
    elsif (v_numero2 > v_numero1 and v_numero2 > v_numero3) then
        dbms_output.put_line('Mayor ' || v_numero2);
    elsif (v_numero3 > v_numero1 and v_numero3 > v_numero2) then
        dbms_output.put_line('Mayor ' || v_numero3);
    end if;
     if (v_numero1 < v_numero2 and v_numero1 < v_numero3) then 
        dbms_output.put_line('Menor ' || v_numero1);
    elsif (v_numero2 < v_numero1 and v_numero2 < v_numero3) then
        dbms_output.put_line('Menor ' || v_numero2);
    else 
        dbms_output.put_line('Menor ' || v_numero3);
    end if;
end;
undefine numero1;
undefine numero2;
undefine numero3;

-- PEDIR TRES NUMEROS AL USUARIO
-- DEBEMOS MOSTRAR EL MAYOR DE ELLOS Y EL MENOR DE ELLOS Y EL INTERMEDIO



-- CALCULAR DIA DE NACIMIENTO DE LA SEMANA
-- Pedir una fecha al usuario para calcular el día de la semana que nació.  Tenemos que tener la tabla de días de la semana para la correspondencia comenzando en sábado
/*
Debemos tener el día, el número de mes y el año que el usuario haya nacido.
A partir de esto datos hay que calcular lo siguiente para averiguar el día de la semana de nacimiento:
Ejemplo  22/06/1983

Hay que tener en cuenta el mes para realizar el cálculo, si el mes es Enero, el Mes será 13 y restaremos uno al año. Si el Mes es Febrero, el Mes será 14 y restaremos uno al año.

Para poder calcular el número final de la semana debemos seguir los siguientes pasos:

    1. Multiplicar el Mes más 1 por 3 y dividirlo entre 5

 ((6 + 1) * 3) / 5  = 4

    2. Dividir el año entre 4
  1983 / 4  = 495

    3. Dividir el año entre 100

  1983 / 100 = 19

    4. Dividir el año entre 400

  1983 / 400 = 4

    5. Sumar el dia, el doble del mes, el año, el resultado de la operación 1, el resultado de la operación 2, menos el resultado de la operación 3 más la operación 4 más 2.

  22 + (6 * 2) + 1983 + 4 + 495 - 19 + 4 + 2 = 2503

    6. Dividir el resultado anterior entre 7.

  2503 / 7 = 357

    7. Restar el número del paso 5 con el número del paso 6 por 7.

 	  2503 – (357 * 7) = 4
    8. Miramos la tabla y vemos que el número 4 corresponde a Miércoles
*/

