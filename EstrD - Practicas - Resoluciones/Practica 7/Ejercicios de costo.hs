{-

Ejercicio 1 
heapsort :: Ord a => [a] -> [a]
el costo seria O(n log n), siendo n la cantidad de elementos de la lista. Porque se haría
recursión sobre la opercaciónes con costo logarítmico.


-- Ejercicio 3

-- Costo: O(n log n), siendo n la cant de pares del map.
valuesM :: Eq k => Map k v -> [Maybe v]

-- Costo O(n*m), siendo n la cantidad de elementos de la lista y m las del map.
todasAsociadas :: Eq k => [k] -> Map k v -> Bool

-- Costo O(n log n), siendo n la cant de pares de la lista. 
listToMap :: Eq k => [(k, v)] -> Map k v

-- Costo O(n log n), siendo n la cant de pares del map.
mapToList :: Eq k => Map k v -> [(k, v)]

-- Costo O(n log n), siendo n la cantidad de pares de la lista.
agruparEq :: Eq k => [(k, v)] -> Map k [v]

-- Costo O(t log n), siendo t la cantidad de elementos de la lista y n el tamaño maximo del map.
incrementar :: Eq k => [k] -> Map k Int -> Map k Int

-- Costo O(t log n), siendo t el tamaño del primer map y n la del segundo. 
mergeMaps:: Eq k => Map k v -> Map k v -> Map k v

-- Costo O(n log n), siendo n la cantidad de elementos de la lista.
indexar :: [a] -> Map Int a

-- Costo O(n log n), siendo n la cantidad de caracteres distintos del string.
ocurrencias :: String -> Map Char Int


-}