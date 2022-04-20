-- 1. Tipos Recursivos Simples

-- 1.1 Celdas con bolitas

data Color = Azul | Rojo

data Celda = Bolita Color Celda | CeldaVacia

b1 = Bolita Rojo (Bolita Rojo (Bolita Azul CeldaVacia))

-- a) Dados un color y una celda, indica la cantidad de bolitas de ese color. Nota: pensar si ya
--    existe una operación sobre listas que ayude a resolver el problema.
nroBolitas :: Color -> Celda -> Int
nroBolitas _ CeldaVacia      = 0
nroBolitas c (Bolita cb cel) = unoSi (esMismoColor c cb) + nroBolitas c cel

-- Dada una condición, devuelve 1 si se cumple y 0 de no hacerlo.
unoSi :: Bool -> Int
unoSi True  = 1
unoSi False = 0

-- Dados dos colores, indica si son el mismo.
esMismoColor :: Color -> Color -> Bool
esMismoColor Azul Azul = True
esMismoColor Rojo Rojo = True
esMismoColor _    _    = False


-- b) Dado un color y una celda, agrega una bolita de dicho color a la celda.
poner :: Color -> Celda -> Celda
poner c CeldaVacia = Bolita c CeldaVacia
poner c cel        = Bolita c cel

-- c) Dado un color y una celda, quita una bolita de dicho color de la celda. Nota: a diferencia de
--    Gobstones, esta función es total.
sacar :: Color -> Celda -> Celda
sacar _ CeldaVacia      = CeldaVacia
sacar c (Bolita cb cel) = 
	if esMismoColor c cb 
		then cel
		else Bolita cb (sacar c cel)

-- d) Dado un número n, un color c, y una celda, agrega n bolitas de color c a la celda.
-- utilizando recursión sobre números y la función poner:
ponerN :: Int -> Color -> Celda -> Celda
ponerN 0 c cel = cel
ponerN n c cel = poner c (ponerN (n-1) c cel)


-- 1.2 Camino Hacia El Tesoro

data Objeto = Cacharro | Tesoro

data Camino = Fin | Cofre [Objeto] Camino | Nada Camino

c1 = Nada (Cofre os1 (Nada (Cofre os2 (Cofre [] Fin))))
c2 = Nada (Cofre os2 (Nada (Nada (Cofre [] (Cofre os2 Fin)))))
c3 = Nada (Cofre os1 (Nada (Nada (Cofre [] (Nada Fin)))))
c4 = Cofre os2 (Cofre os2 (Nada (Nada (Cofre os2 (Cofre os2 Fin)))))

os1 = Cacharro : []
os2 = Cacharro : Cacharro : Tesoro : [] 


-- a) Indica si hay un cofre con un tesoro en el camino
hayTesoro :: Camino -> Bool
hayTesoro Fin          = False
hayTesoro (Nada c)     = hayTesoro c
hayTesoro (Cofre os c) = hayUnTesoro os || hayTesoro c

-- dada una lista de Objeto, indica si contiene un Tesoro.
hayUnTesoro :: [Objeto] -> Bool
hayUnTesoro []     = False
hayUnTesoro (o:os) = esTesoro o || hayUnTesoro os

esTesoro :: Objeto -> Bool
esTesoro Tesoro = True
esTesoro _      = False

-- b) Indica la cantidad de pasos que hay que recorrer hasta llegar al primer cofre con un tesoro.
--    Si un cofre con un tesoro está al principio del camino, la cantidad de pasos a recorrer es 0.
--    Precondición: tiene que haber al menos un tesoro. -> sinó estaría contando todos los pasos del camino.
pasosHastaTesoro :: Camino -> Int
pasosHastaTesoro Fin          = 0
pasosHastaTesoro (Nada c)     = 1 + pasosHastaTesoro c
pasosHastaTesoro (Cofre os c) = 
    if hayUnTesoro os
        then 0
        else 1 + pasosHastaTesoro c 

-- c) Indica si hay al menos “n” tesoros en el camino.
alMenosNTesoros :: Int -> Camino -> Bool
alMenosNTesoros n Fin          = False
alMenosNTesoros n (Nada c)     = alMenosNTesoros n c
alMenosNTesoros n (Cofre os c) = 
	cantDeTesoros os >= n || alMenosNTesoros (n-cantDeTesoros os) c


cantDeTesoros :: [Objeto] -> Int
cantDeTesoros []     = 0
cantDeTesoros (o:os) = unoSi (esTesoro o) + cantDeTesoros os


-- d) Dado un rango de pasos, indica la cantidad de tesoros que hay en ese rango. Por ejemplo, si
--    el rango es 3 y 5, indica la cantidad de tesoros que hay entre hacer 3 pasos y hacer 5. Están
--    incluidos tanto 3 como 5 en el resultado
cantTesorosEntre :: Int -> Int -> Camino -> Int
cantTesorosEntre n m c = cantTesorosHasta (m-n) (avanzarHasta n c)

-- dado una cantidad de pasos y un camino, avanza la cantidad de pasos por el camino.
avanzarHasta :: Int -> Camino -> Camino
avanzarHasta 0 c            = c
avanzarHasta n Fin          = Fin
avanzarHasta n (Nada c)     = avanzarHasta (n-1) c
avanzarHasta n (Cofre os c) = avanzarHasta (n-1) c

-- dado una cantidad de pasos y un camino, indica la cantidad de tesoros en los pasos recorridos del camino.
cantTesorosHasta :: Int -> Camino -> Int
cantTesorosHasta 0 c            = 0
cantTesorosHasta n Fin          = 0
cantTesorosHasta n (Nada c)     = cantTesorosHasta (n-1) c
cantTesorosHasta n (Cofre os c) = cantDeTesoros os + cantTesorosHasta (n-1) c


-- 2. Tipos Arbóreos

-- 2.1 Árboles Binarios

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

t1 :: Tree Int
t1 = NodeT 10 (NodeT 5 
	                   (NodeT 3 EmptyT EmptyT) 
	                   (NodeT 4 EmptyT EmptyT))
	          (NodeT 15 
	          	       (NodeT 13 
	          	       	        (NodeT 12 EmptyT EmptyT) 
	          	       	        EmptyT)
	          	       EmptyT) 

t2 :: Tree Int
t2 = NodeT 10 (NodeT 4 
	                   (NodeT 3 EmptyT EmptyT) 
	                   (NodeT 4 EmptyT EmptyT))
	          (NodeT 10 
	          	       (NodeT 4 
	          	       	        (NodeT 12 EmptyT EmptyT) 
	          	       	         EmptyT)
	          	       (NodeT 4 
	          	       	        (NodeT 10 EmptyT (NodeT 20 EmptyT EmptyT))
	          	                 EmptyT)) 
t3 = EmptyT

-- 1) Dado un árbol binario de enteros devuelve la suma entre sus elementos.
sumarT :: Tree Int -> Int
sumarT EmptyT          = 0
sumarT (NodeT x ti td) = x + sumarT ti + sumarT td

-- 2) Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árbol (size
--    en inglés).
sizeT :: Tree a -> Int
sizeT EmptyT          = 0
sizeT (NodeT x ti td) = 1 + sizeT ti + sizeT td

-- 3) Dado un árbol de enteros devuelve un árbol con el doble de cada número.
mapDobleT :: Tree Int -> Tree Int
mapDobleT EmptyT          = EmptyT
mapDobleT (NodeT x ti td) = NodeT (x*2) (mapDobleT ti) (mapDobleT td)

-- 4) Dados un elemento y un árbol binario devuelve True si existe un elemento igual a ese en el árbol.
perteneceT :: Eq a => a -> Tree a -> Bool
perteneceT e EmptyT          = False
perteneceT e (NodeT x ti td) = e==x || perteneceT e ti || perteneceT e td

-- 5) Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árbol que son
--    iguales a e.
aparicionesT :: Eq a => a -> Tree a -> Int
aparicionesT e EmptyT          = 0
aparicionesT e (NodeT x ti td) = unoSi (e==x) + aparicionesT e ti + aparicionesT e td

-- 6) Dado un árbol devuelve los elementos que se encuentran en sus hojas.
leaves :: Tree a -> [a]
leaves EmptyT                  = []
leaves (NodeT x EmptyT EmptyT) = [x]	
leaves (NodeT x ti td)         = leaves ti ++ leaves td 

-- 7) Dado un árbol devuelve su altura.
heightT :: Tree a -> Int
heightT EmptyT          = 0
heightT (NodeT x ti td)	= 1 + max (heightT ti) (heightT td)

-- 8) Dado un árbol devuelve el árbol resultante de intercambiar el hijo izquierdo con el derecho,
--    en cada nodo del árbol.
mirrorT :: Tree a -> Tree a
mirrorT EmptyT          = EmptyT
mirrorT (NodeT x ti td) = NodeT x (mirrorT td) (mirrorT ti)

-- 9) Dado un árbol devuelve una lista que representa el resultado de recorrerlo en modo in-order.
--    Nota: En el modo in-order primero se procesan los elementos del hijo izquierdo, luego la raiz
--    y luego los elementos del hijo derecho.
toList :: Tree a -> [a]
toList EmptyT          = []
toList (NodeT x ti td) = toList ti ++ [x] ++ toList td


-- 10) Dados un número n y un árbol devuelve una lista con los nodos de nivel n. El nivel de un
--     nodo es la distancia que hay de la raíz hasta él. La distancia de la raiz a sí misma es 0, y la
--     distancia de la raiz a uno de sus hijos es 1.
--     Nota: El primer nivel de un árbol (su raíz) es 0
levelN :: Int -> Tree a -> [a]
levelN _ EmptyT          = []
levelN 0 (NodeT x ti td) = [x] 
levelN n (NodeT x ti td) = levelN (n-1) ti ++ levelN (n-1) td

-- 11) Dado un árbol devuelve una lista de listas en la que cada elemento representa un nivel de
--     dicho árbol.
listPerLevel :: Tree a -> [[a]]
listPerLevel EmptyT          = []
listPerLevel (NodeT x ti td) = 
	[x] : juntarPorNivel (listPerLevel ti) (listPerLevel td)

juntarPorNivel :: [[a]] -> [[a]] -> [[a]]
juntarPorNivel []       yss      = yss
juntarPorNivel xss        []     = xss
juntarPorNivel (xs:xss) (ys:yss) = (xs ++ ys) : juntarPorNivel xss yss

listPerLevel2 :: Tree a -> [[a]]
listPerLevel2 t = listPerLevel2' t (heightT t)

-- Dados un árbol y su profundidad, devuelve una lista de listas en la que cada elemento representa
-- un nivel de dicho árbol.
listPerLevel2' :: Tree a -> Int -> [[a]]
listPerLevel2' EmptyT _ = []
listPerLevel2' t      0 = [levelN 0 t]
listPerLevel2' t      p = listPerLevel2' t (p-1) ++ [levelN p t]    

-- 12) Devuelve los elementos de la rama más larga del árbol.
ramaMasLarga :: Tree a -> [a]
ramaMasLarga EmptyT          = []
ramaMasLarga (NodeT x ti td) = 
	if esRamaMasLarga ti td
		then x : ramaMasLarga ti
		else x : ramaMasLarga td 

-- Dados dos árboles, indica si el primero es más profundo que el segundo.
esRamaMasLarga :: Tree a -> Tree a -> Bool
esRamaMasLarga t1 t2 = heightT t1 > heightT t2

-- Dado un árbol devuelve todos los caminos, es decir, los caminos desde la raiz hasta las hojas
todosLosCaminos :: Tree a -> [[a]]
todosLosCaminos EmptyT          = []
todosLosCaminos (NodeT x ti td) = 
	[x] : agregar x (todosLosCaminos ti) ++ agregar x (todosLosCaminos td)      

-- Dados un elemento y un una lista de listas de elemento, agrega el elemento al comienzo. 
agregar :: a -> [[a]] -> [[a]]
agregar x []  = []
agregar x (ys:yss) = (x:ys) : agregar x yss 


-- 2.2. Expresiones Aritméticas

data ExpA = Valor Int | Sum ExpA ExpA | Prod ExpA ExpA | Neg ExpA

-- 1) Dada una expresión aritmética devuelve el resultado evaluarla.
eval :: ExpA -> Int
eval (Valor n)     = n
eval (Sum   e1 e2) = eval e1 + eval e2
eval (Prod  e1 e2) = eval e1 * eval e2 
eval (Neg   e1)    = eval e1 * (-1)  

-- 2) Dada una expresión aritmética, la simplifica según los siguientes criterios (descritos utilizando
--    notación matemática convencional):
--    a) 0 + x = x + 0 = x
--    b) 0 * x = x * 0 = 0
--    c) 1 * x = x * 1 = x
--    d) - (- x) = x
simplificar :: ExpA -> ExpA
simplificar (Valor n)     = Valor n
simplificar (Sum   e1 e2) = simplificarSuma (simplificar e1) (simplificar e2) 
simplificar (Prod  e1 e2) = simplificarProd (simplificar e1) (simplificar e2) 
simplificar (Neg   e1)    = simplificarNeg  (simplificar e1) 


simplificarSuma :: ExpA -> ExpA -> ExpA
simplificarSuma (Valor 0) v2         = v2 
simplificarSuma v1        (Valor 0)  = v1
simplificarSuma v1        v2         = Sum v1 v2


simplificarProd :: ExpA -> ExpA -> ExpA
simplificarProd (Valor 0) v2        = Valor 0
simplificarProd v1        (Valor 0) = Valor 0
simplificarProd (Valor 1) v2        = v2
simplificarProd v1        (Valor 1) = v1
simplificarProd v1        v2        = Prod v1 v2

simplificarNeg :: ExpA -> ExpA
simplificarNeg (Neg e) = e
simplificarNeg e       = Neg e



