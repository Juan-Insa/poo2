module PriorityQueue1 (PriorityQueue, emptyPQ, isEmptyPQ, insertPQ, findMinPQ, deleteMinPQ) where

data PriorityQueue a = P [a]

-- Propósito: devuelve una priority queue vacía.
-- Costo: O(1).
emptyPQ :: PriorityQueue a
emptyPQ = P []

-- Propósito: indica si la priority queue está vacía.
-- Costo: O(1).
isEmptyPQ :: PriorityQueue a -> Bool
isEmptyPQ (P xs) = null xs

-- Propósito: inserta un elemento en la priority queue.
-- Costo: O(1).
insertPQ :: Ord a => a -> PriorityQueue a -> PriorityQueue a
insertPQ x (P xs) = P (x:xs)

-- Propósito: devuelve el elemento más prioriotario (el mínimo) de la priority queue.
-- Precondición: parcial en caso de priority queue vacía.
-- Costo: O(n), siendo n la cant de elementos de la pq.
findMinPQ :: Ord a => PriorityQueue a -> a
findMinPQ (P xs) = minimum xs

-- Propósito: devuelve una priority queue sin el elemento más prioritario (el mínimo).
-- Precondición: parcial en caso de priority queue vacía
-- Costo: O(n), siendo n la cant de elementos de la pq.
deleteMinPQ :: Ord a => PriorityQueue a -> PriorityQueue a
deleteMinPQ (P xs) = P (borrar (minimum xs) xs)

-- dado un elemento y una lista de elemento, borra el elemento de la lista.
-- Costo: O(n), siendo n la cant de elementos de la lista.
borrar :: Eq a => a -> [a] -> [a]
borrar x (y:ys) = 
	if x == y 
	    then ys 
	    else y : borrar x ys
