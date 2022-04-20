-- 1. PIZZAS

data Pizza = Prepizza | Capa Ingrediente Pizza

data Ingrediente = Salsa | Queso | Jamon | Aceitunas Int

p1 = Capa Salsa (Capa Queso (Capa Jamon (Capa (Aceitunas 8) Prepizza)))
p2 = Capa Salsa (Capa Queso (Capa (Aceitunas 8) (Capa Jamon (Capa (Aceitunas 8) Prepizza))))

-- a) Dada una pizza devuelve la cantidad de ingredientes
cantidadDeCapas :: Pizza -> Int
cantidadDeCapas Prepizza   = 0
cantidadDeCapas (Capa i p) = 1 + cantidadDeCapas p

-- b) Dada una lista de ingredientes construye una pizza
armarPizza :: [Ingrediente] -> Pizza
armarPizza []     = Prepizza
armarPizza (i:is) = Capa i (armarPizza is)

-- c) Le saca los ingredientes que sean jamón a la pizza
sacarJamon :: Pizza -> Pizza
sacarJamon Prepizza   = Prepizza
sacarJamon (Capa i p) = 
	if esJamon i 
		then p
		else Capa i (sacarJamon p)

-- dado un ingrediente, indica si es Jamon. 
esJamon :: Ingrediente -> Bool
esJamon Jamon = True
esJamon _     = False

-- d) Dice si una pizza tiene salsa y queso
-- tieneSoloSalsaYQueso :: Pizza -> Bool
-- tieneSoloSalsaYQueso Prepizza   = 
-- tieneSoloSalsaYQueso (Capa i p) = esSalsa 
-- 
-- tieneSoloQuesoYSalsa :: Pizza -> Bool 
-- tieneSoloQuesoYSalsa Prepizza   =
-- tieneSoloQuesoYSalsa (Capa i p) =
--     if esQueso p
--         then tieneSoloSalsa p
--         else False


-- e) Recorre cada ingrediente y si es aceitunas duplica su cantidad
duplicarAceitunas :: Pizza -> Pizza
duplicarAceitunas Prepizza   = Prepizza
duplicarAceitunas (Capa i p) = 
	if esAceitunas i
		then Capa (dobleAceitunas i) (duplicarAceitunas p)
		else Capa i (duplicarAceitunas p)

-- dado un ingrediente, indica si es Aceitunas.
esAceitunas :: Ingrediente -> Bool
esAceitunas (Aceitunas n) = True
esAceitunas _             = False

-- dadas Aceitunas, duplica su cantidad. precond: solo le puedo dar como ingrediente Aceitunas
dobleAceitunas :: Ingrediente -> Ingrediente
dobleAceitunas (Aceitunas n) = Aceitunas (n*2) 

-- f) Dada una lista de pizzas devuelve un par donde la primera componente es la cantidad de
--    ingredientes de la pizza, y la respectiva pizza como segunda componente
cantCapasPorPizza :: [Pizza] -> [(Int, Pizza)]
cantCapasPorPizza []     = []
cantCapasPorPizza (p:ps) = (cantidadDeCapas p, p) : cantCapasPorPizza ps


-- 2. MAPA DE TESOROS (CON BIFURCACIONES)

data Dir = Izq | Der

data Objeto = Tesoro | Chatarra

data Cofre = Cofre [Objeto]

data Mapa = Fin Cofre | Bifurcacion Cofre Mapa Mapa

m1 :: Mapa
m1 = (Bifurcacion (Cofre []) 
	        (Bifurcacion (Cofre [Tesoro]) 
	        	(Fin (Cofre [Tesoro])) (
	             Fin (Cofre [Chatarra])))
            (Fin (Cofre [Chatarra, Tesoro]))) 

m2 :: Mapa
m2 = (Bifurcacion (Cofre []) 
	        (Bifurcacion (Cofre []) 
	        	(Fin (Cofre [])) 
	        	(Bifurcacion (Cofre []) 
	        		(Fin (Cofre [Tesoro])) 
	        		(Fin (Cofre []))))
            (Fin (Cofre []))) 

m3 :: Mapa
m3 = Bifurcacion (Cofre [Tesoro]) 
	    (Bifurcacion (Cofre []) 
	      	(Bifurcacion (Cofre [])
	      	    (Fin (Cofre [Tesoro])) 
	       	    (Fin (Cofre [Tesoro]))) 
	      	(Bifurcacion (Cofre [Tesoro]) 
	      		(Fin (Cofre [Tesoro])) 
	       		(Bifurcacion (Cofre [Tesoro]) 
	      			(Fin (Cofre [Tesoro])) 
	       			(Fin (Cofre [])))))
        (Fin (Cofre []))

-- 1) Indica si hay un tesoro en alguna parte del mapa
hayTesoro :: Mapa -> Bool
hayTesoro (Fin c)               = hayTesoroEnC c
hayTesoro (Bifurcacion c mi md) = hayTesoroEnC c || hayTesoro mi || hayTesoro md

-- dado un cofre indica si contiene un tesoro
hayTesoroEnC :: Cofre -> Bool
hayTesoroEnC (Cofre os) = hayTesoroEnO os

-- dada una lista de Objeto, indica si contiene un tesoro.
hayTesoroEnO :: [Objeto] -> Bool
hayTesoroEnO []     = False
hayTesoroEnO (o:os) = esTesoro o || hayTesoroEnO os

-- dado un Objeto, indica si es un Tesoro.
esTesoro :: Objeto -> Bool
esTesoro Tesoro = True
esTesoro _      = False

-- 2) Indica si al final del camino hay un tesoro. Nota: el final de un camino se representa con una
--    lista vacía de direcciones.
hayTesoroEn :: [Dir] -> Mapa -> Bool
hayTesoroEn []     (Fin c)               = hayTesoroEnC c
hayTesoroEn []     (Bifurcacion c mi md) = hayTesoroEnC c     
hayTesoroEn (d:ds) (Fin c)               = False
hayTesoroEn (d:ds) (Bifurcacion c mi md) = 
	if esIzq d
		then hayTesoroEn ds mi
		else hayTesoroEn ds md

-- dada una Dir, indica si es Izquierda.
esIzq :: Dir -> Bool
esIzq Izq = True
esIzq _   = False

-- 3) Indica el camino al tesoro. Precondición: existe un tesoro y es único.
caminoAlTesoro :: Mapa -> [Dir]
caminoAlTesoro (Fin c)               = []
caminoAlTesoro (Bifurcacion c mi md) = 
	if hayTesoroEnC c 
        then []
        else if hayTesoro mi
        	then Izq : caminoAlTesoro mi 
        	else Der : caminoAlTesoro md

-- 4) Indica el camino de la rama más larga.
caminoDeLaRamaMasLarga :: Mapa -> [Dir]
caminoDeLaRamaMasLarga (Fin c)               = []
caminoDeLaRamaMasLarga (Bifurcacion c mi md) = 
    if esRamaMasLarga mi md
        then Izq : caminoDeLaRamaMasLarga mi 
        else Der : caminoDeLaRamaMasLarga md

-- dados dos Mapa, indica si el primero es más profundo que el segundo.
esRamaMasLarga :: Mapa -> Mapa -> Bool
esRamaMasLarga m1 m2 = heightM m1 > heightM m2

-- dado un Mapa, indica su profundidad.
heightM :: Mapa -> Int
heightM (Fin c)               = 0
heightM (Bifurcacion c mi md) = 1 + max (heightM mi) (heightM md)


-- 5) Devuelve los tesoros separados por nivel en el árbol.
tesorosPorNivel :: Mapa -> [[Objeto]]
tesorosPorNivel (Fin c)               = tesorosEnC c : []
tesorosPorNivel (Bifurcacion c mi md) = 
    tesorosEnC c : juntarPorNivel (tesorosPorNivel mi) (tesorosPorNivel md)

-- dado un Cofre, devuelve una lista con sus tesoros.
tesorosEnC :: Cofre -> [Objeto]
tesorosEnC (Cofre os) = tesorosEnO os

-- dado una lista de Objeto, la devuelve sólo con los tesoros.
tesorosEnO :: [Objeto] -> [Objeto]
tesorosEnO []     = []
tesorosEnO (o:os) = 
	if esTesoro o
		then o : tesorosEnO os
		else tesorosEnO os


juntarPorNivel :: [[Objeto]] -> [[Objeto]] -> [[Objeto]]
juntarPorNivel []          yss   = yss
juntarPorNivel xss         []    = xss
juntarPorNivel (xs:xss) (ys:yss) = (xs ++ ys) : juntarPorNivel xss yss

-- 6) Devuelve todos lo caminos en el mapa
todosLosCaminos :: Mapa -> [[Dir]]
todosLosCaminos (Fin c)               = []
todosLosCaminos (Bifurcacion c mi md) = 
	agregarATodos Izq (todosLosCaminos mi) ++ agregarATodos Der (todosLosCaminos md)

-- Dados una dirección y una lista de listas de direcciones, agrega la dirección dada al comienzo de cada una.
agregarATodos :: Dir -> [[Dir]] -> [[Dir]]
agregarATodos d []       = [[d]]
agregarATodos d (ds:dss) = (d:ds) : agregarATodos d dss


-- 3. NAVE ESPACIAL

data Componente = LanzaTorpedos | Motor Int | Almacen [Barril]

data Barril = Comida | Oxigeno | Torpedo | Combustible

data Sector = S SectorId [Componente] [Tripulante]

type SectorId = String
type Tripulante = String

data Tree a = EmptyT | NodeT a (Tree a) (Tree a)

data Nave = N (Tree Sector)

n1 :: Nave
n1 = N  (NodeT (S "control" [(Motor 6), (Motor 4)] ["fring","lalo"])
	            (NodeT (S "ala medica" [Almacen [Oxigeno]] ["hannibal"]) 
	            	EmptyT 
	            	EmptyT) 
		        (NodeT (S "laboratorio" [(Motor 3), Almacen [Combustible]] ["walter"]) 
		        	EmptyT 
		       	    (NodeT (S "comedor" [Almacen [Comida, Combustible]] ["bojack"]) 
		       	    	(NodeT (S "motor2" [(Motor 6)] ["toreto"]) 
		       	    	    EmptyT
		       	            EmptyT)
		                EmptyT)))

               
               -- (NodeT (S "ala medica" [Almacen [Oxigeno]] ["pepe"] EmptyT EmptyT))
               -- (NodeT (S "ala laboratorio" [Almacen [Combustible]] ["lalo"] EmptyT (NodeT (S "comedor" [Almacen [Comida]] ["bojack"] EmptyT EmptyT)))))


-- 1) Devuelve todos los sectores de la nave.
sectores :: Nave -> [SectorId]
sectores (N t) = sectoresT t

-- Devuelve todos los sectores del árbol de sectores.
sectoresT :: Tree Sector -> [SectorId]
sectoresT EmptyT          = []
sectoresT (NodeT s si sd) =
	sectorId s : sectoresT si ++ sectoresT sd

-- dado un Sector, devuelve su id.
sectorId :: Sector -> String
sectorId (S i _ _) = i

-- 2) Propósito: Devuelve la suma de poder de propulsión de todos los motores de la nave. Nota:
--    el poder de propulsión es el número que acompaña al constructor de motores.
poderDePropulsion :: Nave -> Int
poderDePropulsion (N t) = poderDePropulsionT t

poderDePropulsionT :: Tree Sector -> Int
poderDePropulsionT EmptyT          = 0
poderDePropulsionT (NodeT s si sd) = 
   propulsionS s + poderDePropulsionT si + poderDePropulsionT sd         

-- dado un sector, devuelve el poder de propulsión. nota: si no hay un motor, devuelve 0.
propulsionS :: Sector -> Int
propulsionS (S _ cs _) = propulsionC cs

-- dada una lista de comoponentes, devuelve la propulsión de los motores.
propulsionC :: [Componente] -> Int
propulsionC []     = 0
propulsionC (c:cs) = propulsion c + propulsionC cs
        

-- dado un motor, devuelve su poder de propulsión.
propulsion :: Componente -> Int
propulsion (Motor n) = n
propulsion _         = 0

-- Devuelve todos los barriles de la nave.
barriles :: Nave -> [Barril]
barriles (N t) = barrilesT t

barrilesT :: Tree Sector -> [Barril]
barrilesT EmptyT          = []
barrilesT (NodeT s si sd) = barrilesS s ++ barrilesT si ++ barrilesT sd

barrilesS :: Sector -> [Barril]
barrilesS (S _ cs _) = barrilesC cs

barrilesC :: [Componente] -> [Barril]
barrilesC []     = []
barrilesC (c:cs) = 
	if esAlmacen c
	    then barril c ++ barrilesC cs
        else barrilesC cs

-- Indica si el componente dado es un almacen.
esAlmacen :: Componente -> Bool
esAlmacen (Almacen bs) = True
esAlmacen _            = False

-- dado un componente almacen, devuelve su barril. precond: el componente debe ser Almacen.
barril :: Componente -> [Barril]
barril (Almacen bs) = bs
barril _            = error"me pasaste cualquier gilada"


-- 4) Propósito: Añade una lista de componentes a un sector de la nave.
--    Nota: ese sector puede no existir, en cuyo caso no añade componentes
agregarASector :: [Componente] -> SectorId -> Nave -> Nave
agregarASector cs i (N t) = N (agregarASectorT cs i t)

agregarASectorT :: [Componente] -> SectorId -> Tree Sector -> Tree Sector
agregarASectorT cs i EmptyT          = EmptyT
agregarASectorT cs i (NodeT s si sd) = 
	if esSectorConId s i
	    then NodeT (agregarASectorS cs s) si sd
	    else NodeT s (agregarASectorT cs i si) (agregarASectorT cs i sd)

-- dada una lista de componente y un sector, agrega los componentes al sector.
agregarASectorS :: [Componente] -> Sector -> Sector
agregarASectorS [] s             = s
agregarASectorS cs1 (S i cs2 tr) = (S i (cs1 ++ cs2) tr)

-- dado un sector y un sectorid, indica si al sector le corresponde el id.
esSectorConId :: Sector -> SectorId -> Bool
esSectorConId (S i _ _) sid = i == sid

-- Incorpora un tripulante a una lista de sectores de la nave.
-- Precondición: Todos los id de la lista existen en la nave.
asignarTripulanteA :: Tripulante -> [SectorId] -> Nave -> Nave
asignarTripulanteA t ids (N tr) = N (asignarTripulanteAT t ids tr)

asignarTripulanteAT :: Tripulante -> [SectorId] -> Tree Sector -> Tree Sector
asignarTripulanteAT _ _   EmptyT          = EmptyT
asignarTripulanteAT t ids (NodeT s si sd) = 
    NodeT (asignarTripulanteAS t ids s) (asignarTripulanteAT t ids si) (asignarTripulanteAT t ids sd) 
    
    
asignarTripulanteAS :: Tripulante -> [SectorId] -> Sector -> Sector    
asignarTripulanteAS t []       s = s
asignarTripulanteAS t (id:ids) s =
    if esSectorConId s id
        then asignarTripulante t s
	else asignarTripulanteAS t ids s

-- Propósito: Devuelve los sectores en donde aparece un tripulante dado.
sectoresAsignados :: Tripulante -> Nave -> [SectorId]
sectoresAsignados tr (N t) = sectoresAsignadosT tr t

sectoresAsignadosT :: Tripulante -> Tree Sector -> [SectorId]
sectoresAsignadosT t EmptyT          = []
sectoresAsignadosT t (NodeT s si sd) = singularSi s (esAsignadoA t s) : sectoresAsignadosT t si ++ sectoresAsignadosT t sd

-- dado un tripulante y un sector, indica si el tripulante pertenece al sector.
esAsignadoA :: Tripulante -> Sector -> Bool
esAsignadoA t (S i cs ts) = estaElTripulante t ts

-- dado un tripulante y una lista de tripulante, indica si el tripulante pertenece la lista.
estaElTripulante :: Tripulante -> [Tripulante] -> Bool
estaElTripulante _  []     = False
estaElTripulante t1 (t:ts) = t1 == t || estaElTripulante t1 ts


-- 4. MANADA DE LOBOS

type Presa = String -- nombre de presa

type Territorio = String -- nombre de territorio

type Nombre = String -- nombre de lobo

data Lobo = Cazador Nombre [Presa] Lobo Lobo Lobo | Explorador Nombre [Territorio] Lobo Lobo | Cria Nombre

data Manada = M Lobo

-- 1) Construir un valor de tipo Manada que posea 1 cazador, 2 exploradores y que el resto sean
--    crías. Resolver las siguientes funciones utilizando recursión estructural sobre la estructura
--    que corresponda en cada caso.

m1 = Cazador "pichicho" [] 
         (Explorador "firu" [] 
	     (Cria "sfaf") 
	     (Cria "asfas"))
	 (Explorador "pancho" 
	     (Cria "ksa")
	     (Cria "kasn"))
	 (Cria "qpq") 

--  dada una manada, indica si la cantidad de alimento cazado es mayor a la cantidad de crías.
buenaCaza :: Manada -> Bool 
buenaCaza (M l) = buenaCazaL l

buenaCazaL :: Lobo -> Bool
buenaCazaL (Cria       n)             = 
buenaCazaL (Explorador n ts l1 l2)    =  
buenaCazaL (Cazador    n ps l1 l2 l3) = 

	 



        














