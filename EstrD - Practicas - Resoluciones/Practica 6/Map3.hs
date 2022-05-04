module Map1(Map, emptyM, assocM, lookupM, deleteM, keys) where

data Map k v = M [k] [v]
{- INV.REP.: 
    - en M ks vs, no hay claves repetidas ks.
    - en M ks vs, ks tiene la misma longitud que vs.
-}

-- Propósito: devuelve un map vacío
-- Costo: O(1).
emptyM :: Map k v
emptyM = M [] []

-- Propósito: agrega una asociación clave-valor al map.
-- Costo: O(n), siendo n la cantidad de claves del map.
assocM :: Eq k => k -> v -> Map k v -> Map k v
assocM k v (M ks vs) = M (asociarK k ks) (asociarV k v ks vs)

-- agrega la clave dada si no se encuentra en la lista.
-- Costo: O(n), siendo n la cantidad de claves de la lista.
asociarK :: Eq k => k -> [k] -> [k]
asociarK k []      = [k]
asociarK k (k':ks) = 
	if k == k' 
		then k' : ks 
		else k' : asociarK k  ks

-- Propósito: agrega una asociación clave-valor al map.
-- Costo: O(n)
assocM2 :: Eq k => k -> v -> Map k v -> Map k v
assocM2 k v (MKV ks vs) = armarM (asociarK k v ks vs)

-- Costo: O(1)
armarM :: ([k],[v]) -> Map k v
armarM (ks,vs) = MKV ks vs

-- Costo: O(n)
asociarK :: Eq k => k -> v -> [k] -> [v] -> ([k],[v])
asociarK k v []      vs      = ([k],[v])
asociarK k v (k':ks) (v':vs) =
	if k == k'
		then ((k':ks), (v:vs))
		else agregarPar k' v' (asociarK k v ks vs)

-- Costo: O(1)
agregarPar :: Eq k => k -> v -> ([k],[v]) -> ([k], [v])
agregarPar k v (ks,vs) = ((k:ks), (v:vs))


-- dado una clave, un valor y dos listas de asociacion clave/valor, agrega o actualiza el valor 
-- en la lista de valores segun corresponda.
-- Costo: O(n), siendo n la cantidad de claves de la lista.
asociarV :: Eq k => k -> v -> [k] -> [v] -> [v]
asociarV k v []      vs      = vs
asociarV k v (k':ks) (v':vs) = 
	if k == k'
		then v : vs
		else v : (asociarV k v ks vs)

-- Propósito: encuentra un valor dado una clave.
-- Costo: O(n), siendo n la cantidad de claves del map.
lookupM :: Eq k => k -> Map k v -> Maybe v
lookupM k (M ks vs) = buscar k ks vs

-- encuentra un valor dado una clave en la lista de valores.
-- Costo: O(n), siendo n la cantidad de claves de la lista.
buscar :: Eq k => k -> [k] -> [v] -> Maybe v
buscar k []      vs     = Nothing
buscar k (k':ks) (v:vs) =  
	if k == k'
		then Just v
		else buscar k ks vs

-- Propósito: borra una asociación dada una clave.
-- Costo: O(n), siendo n la cantidad de claves del map.
deleteM :: Eq k => k -> Map k v -> Map k v
deleteM k (M ks vs) = M (borrarK k ks) (borrarV k ks vs)

-- borra la clave dada de la lista de claves.
-- Costo: O(n), siendo n la cantidad de claves de la lista.
borrarK :: Eq k => k -> [k] -> [k]
borrarK k []      = []
borrarK k (k':ks) = 
	if k == k'
		then ks
		else k' : borrarK k ks 

-- borra el valor asociado a la clave dada de la lista de valores.
-- Costo: O(n), siendo n la cantidad de claves de la lista.
borrarV :: Eq k => k -> [k] -> [v] -> [v]
borrarV k []      vs     = []
borrarV k (k':ks) (v:vs) = 
	if k == k'
		then vs
		else v : borrarV k ks vs

-- Propósito: borra una asociación dada una clave.
-- Costo: O(n), siendo n la cantidad de pares del map.
-- esta implementación la hace parcial
deleteM2 :: Eq k => k -> Map k v -> Map k v
deleteM2 k (M ks vs) = armarM (borrar2 k ks vs)

-- borra un par clave/valor de la lista dada una clave.
-- Costo: O(n), siendo n la cantidad de pares de la lista.
borrar2 :: Eq k => k -> [k] -> [v] -> ([k],[v])
borrar2 k []      vs     = error"no hay clave con valor dado"
borrar2 k (k':ks) (v:vs) = 
	if k == k'
		then (ks,vs)
		else agregarPar k' v (borrar2 k ks vs)

-- Propósito: devuelve las claves del map.
-- Costo: O(1)
keys :: Map k v -> [k]
keys (M ks vs) = ks

