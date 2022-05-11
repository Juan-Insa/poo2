data Tree a = EmptyT | NodeT a (Tree a) (Tree a)
-- INV. Rep.: 
-- el arbol cumple ser un BST y no tiene elementos repetidos

-- Propósito: dado un BST dice si el elemento pertenece o no al árbol.
-- Costo: O(log N)
belongsBST :: Ord a => a -> Tree a -> Bool
belongsBST x EmptyT          = False
belongsBST x (NodeT y ti td) = 
	if x == y 
		then True
		else if x < y
			then belongsBST x ti
			else belongsBST x td

-- Propósito: dado un BST inserta un elemento en el árbol.
-- Costo: O(log N)
insertBST :: Ord a => a -> Tree a -> Tree a
insertBST x EmptyT          = NodeT x EmptyT EmptyT
insertBST x (NodeT y ti td) = 
	if x == y
		then NodeT x ti td
		else x < y
		    then NodeT y (insertBST x ti) td
		    else NodeT y ti (insertBST x td)


-- Propósito: dado un BST borra un elemento en el árbol.
-- Costo: O(log N)
deleteBST :: Ord a => a -> Tree a -> Tree a
deleteBST x EmptyT          =
deleteBST x (NodeT y ti td) =
	if x == t
		then rearmarBST ti td
	    else if x < y
	    	then NodeT y (deleteBST x ti) td
	        else NodeT y ti (deleteBST x td)

-- Costo: (log N)
rearmarBST :: Ord a => Tree a -> Tree a -> Tree a
rearmarBST EmptyT td = td
rearmarBST ti     td =
	let (minimo, td') = splitMinBST td
	  in NodeT minimo ti td'

 -- PRECOND: ambos árboles son BSTs
rearmarBST' :: Ord a => Tree a -> Tree a -> Tree a
rearmarBST' EmptyT td = td
rearmarBST' ti     td = NodeT (maxBST ti) (delMaxBST ti) td

-- PRECOND: no es vacío
maxBST :: Ord a => Tree a -> Tree a
maxBST (NodeT x _ EmptyT) = x 
maxBST (NodeT _ _ td)     = maxBST td

-- PRECOND: no es vacío
delMaxBST :: Ord a => Tree a -> Tree a
delMaxBST (NodeT _ ti EmptyT) = ti 
delMaxBST (NodeT x ti td) = NodeT x ti (delMaxBST td)


-- Propósito: dado un BST devuelve un par con el mínimo elemento y el árbol sin el mismo.
-- precond: el árbol no es vacio.
-- Costo: O(log N)
splitMinBST :: Ord a => Tree a -> (a, Tree a)
splitMinBST (NodeT x EmptyT td) = (x, td)
splitMinBST (NodeT x ti td)     = 
	let (minimo, ti') = splitMinBST ti
	  in (minimo, NodeT x ti' td)

-- Propósito: dado un BST devuelve un par con el máximo elemento y el árbol sin el mismo.
-- Costo: O(log N)
splitMaxBST :: Ord a => Tree a -> (a, Tree a)
splitMaxBST (NodeT x ti EmptyT) = (x, ti)  
splitMaxBST (NodeT x ti td) =
	let (maximo, td') = splitMaxBST td
	  in (maximo, NodeT x ti td')


-- Propósito: indica si el árbol cumple con los invariantes de BST.
-- Costo: O(N^2).
esBST :: Tree a -> Bool
esBST t = balanceado t && estaOrdenado t

-- indica si el arbol esta ordenado de acuerdo a la invariante de BST.
estaOrdenado :: Tree a -> Bool
estaOrdenado EmptyT          = True
estaOrdenado (NodeT x ti td) =
	mayorYMenorQue x ti td && (esBST ti) && (esBST td)

-- indica si el valor dado es mayor a la raiz de primer arbol y menor a la del segundo.
-- Costo: O(1).
mayorYMenorQue :: a -> Tree a -> Tree a -> Bool
mayorYMenorQue x ti td = x > rootT ti && x < rootT td 

-- devuelve la raiz del árbol dado.
-- precond: el árbol no es vacío.
-- Costo: O(1).
rootT :: Tree a -> a
rootT EmptyT          = error"el árbol está vacío, chumbazo"
rootT (NodeT x ti td) = x 

-- indica si el arbol dado es balanceado.
-- Costo: O(n).
balanceado :: Tree a -> Bool
balanceado EmptyT          = True
balanceado (NodeT x ti td) = 
	abs (heightT ti - heightT td) <= 1

-- Costo: O(n).
heightT :: Tree a -> Int
heightT EmptyT          = 0
heightT (NodeT x ti td) = 
	heightT 1 + max (heightT ti) (height td)


-- Propósito: dado un BST y un elemento, devuelve el máximo elemento que sea menor al
-- elemento dado.
-- Costo: O(log N)
elMaximoMenorA :: Ord a => a -> Tree a -> Maybe a
elMaximoMenorA x EmptyT          = Nothing
elMaximoMenorA x (NodeT y ti td) = 
	if x > y && esMenorA x maybeRoot td 
		then Just y
		else if x < y
			then elMaximoMenorA x ti
		    else elMaximoMenorA x td

-- indica si el primer elemento es menor al segundo.
-- Costo: O(1).
esMenorA :: a -> Maybe a -> Bool
esMenorA x (Just y) = x < y
esMenorA x Nothing  = True

-- dado un arbol devuelve el valor de su raiz, si es emptyT devuelve Nothing.
-- Costo: O(1).
maybeRoot :: Tree a -> Maybe a
maybeRoot EmptyT          = Nothing
maybeRoot (NodeT x ti td) = Just x

-- Propósito: dado un BST y un elemento, devuelve el mínimo elemento que sea mayor al
-- elemento dado.
-- Costo: O(log N)
elMinimoMayorA :: Ord a => a -> Tree a -> Maybe a
elMinimoMayorA x EmptyT          = Nothing
elMinimoMayorA x (NodeT y ti td) =
    if x < y && esMenorA x ti
    	then Just y
    	else if x < y 
    		then elMinimoMayorA x ti
    		else elMinimoMayorA x td

inorder :: Tree a -> [a]    -- O(n^2), si (++) es O(n)
                            -- pero O(n), si (++) es O(1)
inorder EmptyT          = []
inorder (NodeT x ti td) = inorder ti ++ [x] ++ inorder td







	


















