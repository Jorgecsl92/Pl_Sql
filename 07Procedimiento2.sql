--REALIZAR UN PROCEDIMIENTO PARA INSERTAR UN NUEVO DEPARTAMENTO
create or replace procedure sp_insertardepartamento
(p_id DEPT.DEPT_NO%TYPE
, p_nombre DEPT.DNOMBRE%TYPE
, p_localidad DEPT.LOC%TYPE)
as
begin
    insert into DEPT values (p_id, p_nombre, p_localidad);
    --normalmente, dentro de los procedimientos de acción se incluye
    --commit o rollback si diera una excepción
    commit;
end;
--llamada al procedimiento
begin
    sp_insertardepartamento(11, '11', '11');
end;
select * from DEPT;
rollback;

-- Version 2
-- Realizar un procedimiento para insertar un nuevo departamento
-- Generamos el id con el max automatico dentro del PROCEDURE
create or replace procedure sp_insertardepartamento
( p_nombre DEPT.DNOMBRE%TYPE
, p_localidad DEPT.LOC%TYPE)
as
    v_max_id dept.dept_no%type; -- variable para almacenar el máximo id
begin
    -- realizamos el cursr implicito para buscar el max id
    select max(dept_no) +1 into v_max_id from dept; -- buscamos el máximo id
    insert into DEPT values (v_max_id + 1, p_nombre, p_localidad); -- insertamos el nuevo departamento con el id incrementado
    --normalmente, dentro de los procedimientos de acción se incluye
    --commit o rollback si diera una excepción
    commit;
EXCEPTION
    when no_data_found then -- excepción para no encontrar datos
        dbms_output.put_line('Error: No se encontraron datos.'); -- mostramos el error
        ROLLBACK;
end;
--llamada al procedimiento
begin
    sp_insertardepartamento('miercoles', 'miercoles'); -- pasamos el nombre y la localidad del nuevo departamento
end;
select * from DEPT;

-- Realizar un preocedimento para incrementar el salario de los empleados por un oficio.  
-- Debemos enviar el oficio y el incremento. 
create or replace procedure sp_incrementado_emp_oficio
(p_oficio EMP.OFFICIO%TYPE, p_incremento NUMBER)
AS
BEGIN
    -- Actualizamos el salario de los empleados según el oficio y el incremento
    UPDATE EMP SET SALARIO = SALARIO + p_incremento 
    WHERE upper(OFICIO) = upper(p_oficio); -- actualizamos el salario de los empleados con el oficio especificado
    commit;
end;
/
BEGIN
    sp_incrementado_emp_oficio('analista', 1);
END;

select * from EMP where oficio = 'analista'; -- mostramos los empleados con el oficio especificado

-- Necesito un procedimiento para insertar un doctor. 
-- Enviaremos todos los datos del doctor, excepto el id.
-- Debemos recuperar el maximo id de doctor dentro del procedimiento.
select * from doctor;
create or replace procedure sp_insertar_doctor
(p_hospital_cod doctor.hospital_cod%type
, p_apellido doctor.apellido%type
, p_especialidad doctor.especialidad%type
, p_salario doctor.salario%type)
AS
    v_max_iddoctor_no doctor.doctor_no%type; -- variable para almacenar el máximo id de doctor
begin
    -- Buscamos el máximo id de doctor y lo incrementamos en 1 para el nuevo doctor
    select max(doctor_no) + 1 into v_max_iddoctor_no from doctor; -- buscamos el máximo id de doctor
    insert into doctor values (v_max_iddoctor_no, p_hospital_cod, p_apellido, p_especialidad, p_salario); -- insertamos el nuevo doctor con el id incrementado
    commit;
    dbms_output.put_line('Doctor insertado con éxito ' || sql%rowcount); -- mostramos el mensaje de éxito   
end;
select * from doctor; -- mostramos los doctores

--llamada al procedimiento
begin
    sp_insertar_doctor(21, 'willson', 'Oncologo', 30000); -- pasamos los datos del nuevo doctor
end;
select * from doctor; -- mostramos los doctores

-- version 2
-- Necesito un procedimiento para insertar un doctor. 
-- Enviaremos todos los datos del doctor, excepto el id.
-- Debemos recuperar el maximo id de doctor dentro del procedimiento.
-- Enviamos el nombre del hospital en lugar del id hospital
-- Controlar si existe el hospital enviado.
select * from doctor;
create or replace procedure sp_insertar_doctor
(p_hospital_nombre hospital.nombre%type
, p_apellido doctor.apellido%type
, p_especialidad doctor.especialidad%type
, p_salario doctor.salario%type)
AS
    v_max_iddoctor_no doctor.doctor_no%type; -- variable para almacenar el máximo id de doctor
    v_hospitalcod hospital.hospital_cod%type; -- variable para almacenar el id del hospital
begin
    -- Buscamos el máximo id de doctor y lo incrementamos en 1 para el nuevo doctor
    select max(doctor_no) + 1 into v_max_iddoctor_no from doctor; -- buscamos el máximo id de doctor
    insert into doctor values (v_max_iddoctor_no, v_hospitalcod, p_apellido, p_especialidad, p_salario); -- insertamos el nuevo doctor con el id incrementado

    select hospital_cod into v_hospitalcod from hospital 
    where upper(nombre) = upper(p_hospital_nombre); -- buscamos el id del hospital

    dbms_output.put_line('Doctor insertado con éxito ' || sql%rowcount); -- mostramos el mensaje de éxito   
    commit;
exception 
    when no_data_found then -- excepción para no encontrar datos
        dbms_output.put_line('No existe el hospital ' || p_hospital_nombre); -- mostramos el error
end;
select * from doctor; -- mostramos los doctores
--llamada al procedimiento
begin
    sp_insertar_doctor('la paz', 'House', 'Diagnostico', 50000); -- pasamos los datos del nuevo doctor
end;

-- Podemos utilizar  cursores explicitos dentro de un procedimiento
-- Realizar un procedimiento para mostrar los empleados de un determinado numero de departamento.
create or replace procedure sp_empleados_dept
(p_deptno EMP.DEPT_NO%type)
AS
    CURSOR cursor_emp IS -- cursor para seleccionar los empleados del departamento
        SELECT * FROM EMP WHERE DEPT_NO = p_deptno; -- seleccionamos los empleados del departamento especificado
begin
    for v_reg_emp in cursor_emp
    LOOP
        dbms_output.put_line('apellido' || v_reg_emp.apellido || ', oficio ' || v_reg_emp.oficio); -- mostramos el nombre y el departamento del empleado
    END LOOP;
    end;
    BEGIN
        sp_empleados_dept(10); -- llamamos al procedimiento con el número de departamento
    END;
    -- mostramos los empleados del departamento especificado
    select * from EMP where dept_no = 10; -- mostramos los empleados del departamento 10

    -----------------------------------Parametros de salida-------------------------------------------------
-- Vamos a realizar un procedimiento para enviar el nombre del departamento y devolver el numero de dicho departamento.
create or replace procedure sp_numerodepartamento
(p_nombre dept.dnombre%type, p_iddept out dept.dept_no%type) -- el id del departamento es un parametro de salida
as
    v_iddept dept.dept_no%type;
begin 
    select dept_no into v_iddept from dept 
    where upper(dnombre) = upper(p_nombre);
    p_iddept := v_iddept; -- asignamos el id del departamento al parametro de salida
     dbms_output.put_line('El número de departamento es ' || v_iddept); -- mostramos el número de departamento
end;
begin  
    sp_numerodepartamento('ventas'); -- llamamos al procedimiento con el nombre del departamento
end;
-- mostramos el número de departamento          
select * from dept ;

-- Necesito un precedimiento para incrementar en 1
-- El salario de los empleados de un departamento.
-- Enviaremos al procedimiento el nombre del departamento.
create or replace procedure sp_incrementar_sal_dept
(p_nombre dept.dnombre%type)
as  
    v_num  dept.dept_no%type; -- variable para almacenar el id del departamento 
begin 
    
-- llamamos al procedimiento de numero para recuperar el numero a partir del nombre
    -- sp_numerodepartamento
    -- (p_nombre dept.dnombre%type, p_iddept out dept.dept_no%type) -- el id del departamento es un parametro de salida
    sp_numerodepartamento (p_nombre, v_num);
    -- actualizamos el salario de los empleados del departamento
    update emp set salario = salario + 1 
    where dept_no = v_num; -- actualizamos el salario de los empleados del departamento especificado
    dbms_output.put_line('Salarios modificados: ' || sql%rowcount); -- mostramos el número de salarios modificados
end;
begin 
    sp_incrementar_sal_dept('ventas'); -- llamamos al procedimiento con el nombre del departamento
end;