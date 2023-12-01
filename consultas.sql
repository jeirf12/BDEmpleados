/*
    Salario máximo, mínimo y promedio para cada sede. 
*/
SELECT 
        sed.sed_nombre as "Sede", 
        max(sal.sal_valor) as "Salario mayor", 
        min(sal.sal_valor) as "Salario menor", 
        ROUND(avg(sal.sal_valor), 2) as "Salario promedio"
    FROM sede SED 
        INNER JOIN  posicion PO ON  po.sed_id = sed.sed_id 
        INNER JOIN  posicion_contrato PC ON  po.pos_id = pc.pos_id 
        INNER JOIN  contrato CON ON  pc.con_id = con.con_id
        INNER JOIN  Salarios SAL ON  con.con_id = sal.con_id 
    GROUP BY sed.sed_nombre
    ORDER BY  "Sede"

/*
    La información de todos los empleados de la compañía quienes tienen 
    asignado un salario  
*/
SELECT 
    emp.emp_nombre || ' ' || emp.emp_apellido as "Nombre Completo", 
    emp.emp_codigo_identificacion as "Identificación", 
    con.con_fecha_inicio, 
    con.con_fecha_fin, 
    sal.sal_valor as Salario
FROM  contratacion.empleado EMP 
INNER JOIN  contratacion.contrato CON ON emp.emp_id = con.emp_id 
LEFT JOIN  contratacion.salarios SAL ON  con.con_id = sal.con_id 
WHERE   EXISTS (
    SELECT SAL2.con_id FROM salarios SAL2 WHERE sal2.con_id = sal.con_id
)
ORDER BY "Nombre Completo"

/*
 Determina el árbol jerparquico de los departamentos de ventas, recuersos humanos y tecnología 
 y adicionamente, muestra quién está en el cargo. 
*/
SELECT  LPAD(pc.percar_cargo, Length(pc.percar_cargo) + (LEVEL*4) - 4, '-')  as Arbol, 
        emp.emp_nombre || ' ' || emp.emp_apellido as Empleado, 
        ar.area_nombre as Area, 
        sed.sed_nombre as Nombre 
FROM Posicion POS  
    INNER JOIN perfilcargo PC ON pc.percar_id = pos.percar_id 
    INNER JOIN posicion_contrato PCC ON  pos.pos_id = pcc.pos_id 
    INNER JOIN contrato CON  ON  pcc.con_id = con.con_id 
    INNER JOIN empleado EMP ON  con.emp_id = emp.emp_id
    INNER JOIN area AR ON  POS.area_id = AR.area_id 
    INNER JOIN sede sed ON  SED.sed_id = pos.sed_id 
WHERE pos.area_id IN (1, 2, 5) -- Departamento de ventas, y recursos humanos   
AND sed.sed_id = 1 
START WITH POS.jefe_id is null  
CONNECT BY PRIOR POS.pos_id = POS.jefe_id  
ORDER SIBLINGS BY POS.jefe_id

--- CUARTA CONSULTA

/*
    Las cargos laborales  que están en la sede 2 pero que no están en la sede tres. 
*/
SELECT DISTINCT 
    pfc.percar_cargo, 
    CAST(pfc.percar_descripcion as Varchar(2000)) as Cargo
FROM contratacion.PerfilCargo PFC 
    INNER JOIN contratacion.Posicion PO ON  pfc.percar_id = po.percar_id 
    INNER JOIN contratacion.Sede SED ON  po.sed_id = sed.sed_id 
MINUS 
SELECT DISTINCT 
    pfc.percar_cargo, 
    CAST(pfc.percar_descripcion as Varchar(2000)) as Descripcion
FROM contratacion.PerfilCargo PFC 
    INNER JOIN contratacion.Posicion PO ON  pfc.percar_id = po.percar_id 
    INNER JOIN contratacion.Sede SED ON  po.sed_id = sed.sed_id 
WHERE sed.sed_id in  (3,1)

/*
    Consulta que muestra la información contractual básica de los empleados de la compañía
*/ 
SELECT DISTINCT 
    pfc.percar_cargo as Cargo,  
    emp.emp_nombre || ' ' || emp.emp_apellido as NombreCompleto, 
    emp.emp_codigo_identificacion as Identificacion, 
    emp.emp_genero as Genero, 
    TRUNC(MONTHS_BETWEEN(CURRENT_DATE , emp.emp_fecha_nacimiento) / 12)  as Edad,
    TRUNC(MONTHS_BETWEEN(con.con_fecha_fin , con.con_fecha_inicio) / 12)  as TiempoLaborado,
    mc.modcon_nombre as ModalidadContractual, 
    tc.tipcon_nombre as TipoContrato, 
    COALESCE(TO_CHAR(sl.sal_valor, 'FM$999,999,999.99'), 'No registra') as Salario  
    
FROM contratacion.PerfilCargo PFC 
    INNER JOIN contratacion.Posicion PO ON  pfc.percar_id = po.percar_id 
    INNER JOIN contratacion.Sede SED ON  po.sed_id = sed.sed_id 
    INNER JOIN contratacion.posicion_contrato PC ON  po.pos_id = pc.pos_id 
    INNER JOIN contratacion.contrato CON ON  pc.con_id = con.con_id 
    INNER JOIN contratacion.empleado EMP ON  con.emp_id = emp.emp_id 
    INNER JOIN contratacion.modalidad_contrato MC ON  con.modcon_id = mc.modcon_id
    INNER JOIN contratacion.tipo_contrato TC ON  tc.tipcon_id = con.tipcon_id 
    LEFT OUTER JOIN contratacion.salarios SL  ON con.con_id = sl.con_id 
ORDER BY  Cargo, NombreCompleto, Edad


