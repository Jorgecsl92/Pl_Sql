-- Almacena consultas en variables
-- bloque para consultas de accion
-- insertar 5 departamentos en un bloque pl/sql dinamico
declare 
    v_nombre dept.dnombre%type;
    v_loc dept.loc%type;
begin
    -- vamos a realizar un bucle para insetar 5 departamentos
    for i in 1..5 loop
        v_nombre := 'Departamento' || i;
        v_loc := 'Localidad' || i;
        insert into DEPT values 
        ((select max (DEPT_NO)+1 from DEPT), v_nombre, v_loc);
    end loop;
    dbms_output.put_line('Fin de programa');
end;
select * from dept;
ROLLBACK;

-- realizamos un bloque pl/sql que pedira un numero al usuario y mostrara el departamento con dicho numero
-- el siguiente eemplo no funcionara porque solo de puede hacer select si hay antes un "insert into, update, delete"
declare 
    v_id int;
begin 
    v_id := &numero;
    select * from dept 
    where detp_no=v_id;
end;
undefine numero;

-- TIPOS DE CURSORES
-- Implicito: solo puede devolver una fila
-- vamos a recuperar e oficio del empleao REY
declare 
    v_oficio emp.oficio%type;
begin 
    select oficio into v_oficio 
    from emp where upper(apellido)='rey';
    dbms_output.put_line('El oficio de Rey es ...'|| v_oficio); 
end;

-- Explcicito: puede devolver mas de una fila y es necesario declararlos
-- mostrar el apellido y salario de todos los empleados
declare 
    v_ape emp.apellido%type;
    v_sal emp.salario%type;
    -- declaramos nuestro cursor con una consulta
    -- la consulta debe tener los mismo datos para luego haver el fetch
    cursor cursoremp is 
    select apellido, salario 
    from emp;
begin 
    --1) abrir el cursor
    open cursoremp;
    -- bucle infinito
    LOOP    
        -- 2) extraemos los datos del cursor
        fetch cursoremp INTO v_ape, v_sal;
        -- 3) preguntamos que haya terminado
        exit when cursoremp%notfound;
        -- dibujamos los datos
        dbms_output.put_line('Apellido: ' || v_ape || ', Salario: ' || v_sal);  
    end loop;
    -- 4) cerramos cursor
    close cursoremp;
end;
select * from emp;

-- Atributos
-- ROWCOUNT para las consultas de accion
-- Incrementar en 1 el salario de los empleados del departamento 10. Mostrar el numero de empleados modificados
begin
    update emp set salario = salario +1
    where det_no=10;
    dbms_output.put_line('Empleados modificados: ' || sql%rowcount);
end;
-- Incrementar en 10000 al empleado que menos cobre en la empresa
-- 1) ¿que necesito para esto?
-- minimo salario Implicito
-- 2) ¿que mas? update a ese salario
declare 
    v_minimo_salario emp.salario%type;
begin 
    -- realizamos una consulta para recuperar el minimo salario
    select min(salario) into v_minimo_salario from emp;
    update emp set salario = salario + 10000
    where salario=v_minimo_salario;
    dbms_output.put_line('El salario minimo aumento a'|| sql%rowcount || ' empleados'); 
end;
select * from emp;

-- Realizar un codigo pl/sql donde pediremos
-- el numero, nombre y localidad de un departmento
-- si el departamento existe, modificamos su nombre y localidad
-- si el departamento no existe, lo insertamos
select * from dept;
-- 90, I+D, Gijon
declare 
    v_id dept.dept_no%type := 90;
    v_nombre dept.dnombre%type := 'I+D';
    v_loc dept.loc%type := 'Gijon';
    v_existe dept.dept_no%type := null;
    cursor cursordept is
    select dept_no from dept;
begin 
    open cursordept;
    loop
        fetch cursordept into v_existe;
        exit when cursordept%notfound;
        if v_existe = v_id then                     
            update DEPT
            set dnombre = v_nombre,
                loc = v_loc
            where dept_no = v_id;
            dbms_output.put_line ('update');
            close cursordept;
            return;
        end if;
    end loop;
    close cursordept;
    insert into dept (dept_no, dnombre, loc)
    values (v_id, v_nombre, v_loc);
    dbms_output.put_line ('insert');
end;

-- Realizar un codigo pl/sql para modificar el salario del empleado ARROYO
-- Si el empleado cobra mas de 250000, le bajamos el sueldo en 10000. Sino, le subimos el sueldo 10000
declare 
    v_salario emp.salario%type;
    v_idemp emp.emp_no%type;
begin 
    select emp_no, salario into v_idemp, v_salario from emp
    where upper(APELLIDO)='ARROYO';
    if v_salario > 250000 then
    v_salario := v_salario - 100000;
    else v_salario := v_salario + 10000;
    end if;
    update emp set salario=v_salario
    where emp_no=v_idemp;
    dbms_output.put_line('Salario modificado: ' || v_salario);
end;

-- Realaizar el siguiente codigo pl/sql.
-- Nacesitammos modificar e salario de los doctors LA PAZ.
-- Si la suma salarial supera 1000000 bajamos los salarios en 10000 a todos
-- Si la suma salarial no supera el millon, subimos salarios en 10000
-- Mostrar el nuemro de filas que hemos modificado (subir o bajar).
-- Doctores con suerte 6, doctores con mala suerte 6.
select hospital_cod from HOSPITAL;
select * from doctor;
select * from hospital;

declare
    v_salario doctor.salario%type;
    v_idhospital hospital.hospital_cod%type;
    cursor cursorsalario is
    select hospital_cod, into v_idhospital from HOSPITAL
    where upper (HOSPITAL_COD)=22;
begin 
    open cursorsalario;
    loop  
        fetch cursorsalario into v_idhospital, v_salario;
        exit when cursorsalario%notfound;
        if v_salario > 1000000 then                   
            v_salario := v_salario - 10000;
        else v_salario := v_salario + 10000;
        end if; 
        update hospital set salario=v_salario
        where hospital_cod=v_idhospital;
    end loop;  
end;
---------------------------correccion---------------------------
declare 
    v_suma_salarial number;
begin
    select sum(doctor.salario) as sumasalarial
    from DOCTOR inner join HOSPITAL
    on doctor.hospital_cod = hospital.hospital_cod 
    where lower(hospital.nombre)='la paz';
    dbms_output.put_line('Suma salarial La paz: ' || v_suma_salarial);
    if v_suma_salarial > 1000000 then 
        update doctor set salario = salario - 10000
        where hospital_cod= (select hospital_cod from hospital where upper(nombre)='LA PAZ');   
        dbms_output.put_line('Bajando salarios' || sql%rowcount);
    else  
        update doctor set salario = salario + 10000
        where hospital_cod= (select hospital_cod from hospital where upper(nombre)='LA PAZ');   
        dbms_output.put_line('Doctores ricos' || sql%rowcount);
    end if;    
end;

--------------------------solucion 2-----------------------------

-----------------------------------------------------------------

-- Realizamos la declaracion con departamentos
-- Podemos almacenar todos los departamentos (uno a uno) en un rowtype
describe dept;
declare 
    v_fila dept%rowtype;
    cursor cursor_dept is     
    select * from dept;
begin 
    open cursor_dept;
    loop 
        fetch cursor_dept into v_fila;
        exit when cursor_dept%notfound;   
        dbms_output.put_line('Id: ' || v_fila.dept_no || ', Nombre: ' || v_fila.dnombre || ', Localidad: ' || v_fila.loc);
    end loop;
    close cursor_dept;
end; 
rollback;

-- Realizar un cursor para mostrar el apellido, salario y oficio de empleados
declare   
    cursor cursor_emp is     
    select apellido, salario, oficio, salario + comision as total
    from emp;
begin    
    for v_registro in cursor_emp
    loop   
        dbms_output.put_line('Apellido ' || v_registro.apellido || ' , Salario: ' || v_registro.salario || ', Oficio: ' || v_registro.oficio || ', Tostal' || v_registro.total); 
    end loop;
end;