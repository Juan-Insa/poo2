type SectorId = Int

type CUIL = Int

data Empresa = ConsE (Map SectorId (Set Empleado)) (Map CUIL Empleado)

-- Inv. Rep.: 
--    id de sectores y los legajos (CUIL) no pueden repetirse.

{- INTERFAZ EMPLEADO

Propósito: construye un empleado con dicho CUIL.
Costo: O(1)
consEmpleado :: CUIL -> Empleado


Propósito: indica el CUIL de un empleado.
Costo: O(1)
cuil :: Empleado -> CUIL

Propósito: agrega un sector a un empleado.
Costo: O(log N)
agregarSector :: SectorId -> Empleado -> Empleado

Propósito: indica los sectores en los que el empleado trabaja.
Costo: O(N).
sectores :: Empleado -> SectorId

-}

-- Propósito: construye una empresa vacía.
-- Costo: O(1)
consEmpresa :: Empresa
consEmpresa = ConsE emptyM emptyM

-- Propósito: devuelve el empleado con dicho CUIL.
-- Costo: O(log N)
buscarPorCUIL :: CUIL -> Empresa -> Empleado
buscarPorCUIL c (ConsE m1 m2) = lookupM c m2

-- Propósito: indica los empleados que trabajan en un sector dado.
-- Costo: O(N)
empleadosDelSector :: SectorId -> Empresa -> [Empleado]
empleadosDelSector s (ConseE m1 m2) = setToList (lookupM s m1)

-- Propósito: indica todos los CUIL de empleados de la empresa.
-- Costo: O(N)
todosLosCUIL :: Empresa -> [CUIL]
todosLosCUIL (ConsE m1 m2) = keys m2

-- Propósito: indica todos los sectores de la empresa.
-- Costo: O(N)
todosLosSectores :: Empresa -> [SectorId]
todosLosSectores (ConsE m1 m2) = keys m1

-- Propósito: agrega un empleado a la empresa, en el que trabajará en dichos sectores y tendrá
-- el CUIL dado.
-- Costo: O(t log n), donde t es la cantidad de sectores de la lista y n el tamaño del primer map. 
agregarEmpleado :: [SectorId] -> CUIL -> Empresa -> Empresa
agregarEmpleado ss c (ConsE m1 m2) = 
	let empleado = agregarSectores ss (consEmpleado c)
	  in ConsE (agregarEmpleadoSE ss empleado m1) 
	           (assocM c empleado m2) 

-- agrega los sectores dados al empleado.
-- Costo: O(t log n), siendo t la cant de sectores de la lista y n la de sectores del empleado.
agregarSectores :: [SectorId] -> Empleado -> Empleado
agregarSectores []     e = e
agregarSectores (x:xs) e = agregarSector x (agregarSectores xs e)

-- agrega al empleado a cada sector de la lista dada en el map.
-- Costo: O(t log n), donde t es la cantidad de sectores de la lista y n el tamaño del map. 
agregarEmpleadoSE :: [SectorId] -> Empleado -> Map SectorId Set -> Map SectorId Set
agregarEmpleadoSE []     e m = m
agregarEmpleadoSE (s:ss) e m = 
	addEmpleadoASector s e (agregarEmpleadoSE ss e m)

-- costo: O(log n), siendo n el tamaño del map.
addEmpleadoASector :: SectorId -> Empleado -> Map SectorId Set -> Map SectorId Set
addEmpleadoASector s e m =
        let empleados = fromSet (lookupM s m)
          in assocM s (addS e empleados) m

fromSet :: Maybe (Set Empleado) -> Set Empleado
fromSet Nothing   = emptyS
fromSet (Just es) = es

-- Propósito: agrega un sector al empleado con dicho CUIL.
-- Costo: calcular.
agregarASector :: SectorId -> CUIL -> Empresa -> Empresa
agregarASector s c (ConsE m1 m2) = 
	let empleado = agregarSector s (fromJust (lookupM c m2))
	ConsE (addEmpleadoASector s empleado m1) 
	      (assocM c empleado m1)

-- Costo: O(1).
fromJust :: Maybe a -> a
fromJust (Just x) = x


-- Propósito: elimina al empleado que posee dicho CUIL.
-- Costo: O(t log n), siendo t la cant de sectores de la lista y n el tamaño del map.
borrarEmpleado :: CUIL -> Empresa -> Empresa
borrarEmpleado c (ConsE m1 m2) = 
        let empleado = fromJust (lookupM c m2)
	ConsE (borrarEmpleadoSE (sectores c) empleado m1)
	      (deleteM c m2) 

-- Costo: O(t log n), siendo t la cant de sectores de la lista y n el tamaño del map.
-- precond: los sectores de la lista son validos para el map.
borrarEmpleadoSE :: [SectorId] -> Empleado -> Map SectorId Set -> Map SectorId Set
borrarEmpleadoSE []     e m = m
borrarEmpleadoSE (s:ss) e m = 
        let sinEmpleado = removeS e (fromSet (lookupM s m))
	  in assocM s sinEmpleado (borrarEmpleadoSE ss e m)
	  
	  




