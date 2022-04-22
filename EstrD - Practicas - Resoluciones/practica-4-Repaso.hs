-- 1. PIZZAS

data Pizza = Prepizza | Capa Ingrediente Pizza

data Ingrediente = Salsa | Queso | Jamon | Aceitunas Int

p1 = Capa Salsa (Capa Queso (Capa Jamon (Capa (Aceitunas 8) Prepizza)))
p2 = Capa Salsa (Capa Queso (Capa (Aceitunas 8) (Capa Jamon (Capa (Aceitunas 8) Prepizza))))
p3 = Capa Salsa (Capa Queso (Capa Queso (Capa Queso (Capa Salsa Prepizza))))

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
tieneSoloSalsaYQueso :: Pizza -> Bool
tieneSoloSalsaYQueso p = tieneQueso p && tieneSalsa p && noTieneAceitunasYJamon p

-- dada una pizza, indica si tiene salsa.
tieneSalsa :: Pizza -> Bool
tieneSalsa Prepizza   = False
tieneSalsa (Capa i p) = esSalsa i || tieneSalsa p

-- dada una pizza, indica si tiene queso.
tieneQueso :: Pizza -> Bool
tieneQueso Prepizza   = False
tieneQueso (Capa i p) = esQueso i || tieneQueso p

noTieneAceitunasYJamon :: Pizza -> Bool
noTieneAceitunasYJamon Prepizza   = False
noTieneAceitunasYJamon (Capa i p) = not (esAceitunas i) && not (esJamon i) && noTieneAceitunasYJamon p

-- dado un ingrediente, indica si es aceitunas.
esAceitunas :: Ingrediente -> Bool
esAceitunas (Aceitunas n) = True
esAceitunas _            = False

-- dado un ingrediente, indica si es queso.
esQueso :: Ingrediente -> Bool
esQueso Queso = True
esQueso _     = False

-- dado un ingrediente, indica si es salsa.
esSalsa :: Ingrediente -> Bool
esSalsa Salsa = True
esSalsa _     = False


-- e) Recorre cada ingrediente y si es aceitunas duplica su cantidad
duplicarAceitunas :: Pizza -> Pizza
duplicarAceitunas Prepizza   = Prepizza
duplicarAceitunas (Capa i p) = Capa (dobleAceitunas i) (duplicarAceitunas p)

-- dadas Aceitunas, duplica su cantidad. precond: solo le puedo dar como ingrediente Aceitunas
dobleAceitunas :: Ingrediente -> Ingrediente
dobleAceitunas (Aceitunas n) = Aceitunas (n*2) 
dobleAceitunas i             = i

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
hayTesoroEn []     m                     = hayTesoroEnPrimerCofre m   
hayTesoroEn (d:ds) (Fin c)               = False
hayTesoroEn (d:ds) (Bifurcacion c mi md) = 
	if esIzq d
		then hayTesoroEn ds mi
		else hayTesoroEn ds md

-- indica si hay un tesoro en el primer cofre del mapa dado
hayTesoroEnPrimerCofre :: Mapa -> Bool 
hayTesoroEnPrimerCofre (Fin c)               = hayTesoroEnC c 
hayTesoroEnPrimerCofre (Bifurcacion c mi md) = hayTesoroEnC c


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
todosLosCaminos (Fin c)               = [[]]
todosLosCaminos (Bifurcacion c mi md) = 
	[] : agregarATodos Izq (todosLosCaminos mi) ++ agregarATodos Der (todosLosCaminos md)

-- Dados una dirección y una lista de listas de direcciones, agrega la dirección dada al comienzo de cada una.
agregarATodos :: Dir -> [[Dir]] -> [[Dir]]
agregarATodos d []       = []
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
		        (NodeT (S "laboratorio" [(Motor 3), Almacen [Combustible]] ["walter","fring"]) 
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
barrilesC (c:cs) = barril c ++ barrilesC cs

-- dado un componente almacen, devuelve su barril. precond: el componente debe ser Almacen.
barril :: Componente -> [Barril]
barril (Almacen bs) = bs
barril _            = []


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

-- 5) Incorpora un tripulante a una lista de sectores de la nave.
--    Precondición: Todos los id de la lista existen en la nave.
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

-- dados un tripulante y un sector, lo asigna al mismo.
asignarTripulante :: Tripulante -> Sector -> Sector
asignarTripulante t (S i cs ts) = S i cs (t:ts) 

-- 6) Devuelve los sectores en donde aparece un tripulante dado.
sectoresAsignados :: Tripulante -> Nave -> [SectorId]
sectoresAsignados tr (N t) = sectoresAsignadosT tr t

sectoresAsignadosT :: Tripulante -> Tree Sector -> [SectorId]
sectoresAsignadosT t EmptyT          = []
sectoresAsignadosT t (NodeT s si sd) = 
	singularSi (sectorId s) (esAsignadoA t s) ++ sectoresAsignadosT t si ++ sectoresAsignadosT t sd

-- dado un tripulante y un sector, indica si el tripulante pertenece al sector.
esAsignadoA :: Tripulante -> Sector -> Bool
esAsignadoA t (S i cs ts) = elem t ts

singularSi :: a -> Bool -> [a]
singularSi x True  = [x]
singularSi x False = [] 


-- 4. MANADA DE LOBOS

type Presa = String -- nombre de presa

type Territorio = String -- nombre de territorio

type Nombre = String -- nombre de lobo

data Lobo = Cazador Nombre [Presa] Lobo Lobo Lobo | Explorador Nombre [Territorio] Lobo Lobo | Cria Nombre

data Manada = M Lobo

-- 1) Construir un valor de tipo Manada que posea 1 cazador, 2 exploradores y que el resto sean
--    crías. Resolver las siguientes funciones utilizando recursión estructural sobre la estructura
--    que corresponda en cada caso.

manada = M (Cazador "pichicho" ["1","2","3","4","5","6"] 
               (Explorador "firu" [] 
	               (Cria "sfaf") 
	               (Cria "asfas"))
	           (Explorador "pancho" []
	               (Cria "ksa")
	               (Cria "kasn"))
	           (Cria "qpq"))

manada2 = M (Cazador "pichicho" ["1","2"] 
               (Cazador "firu" ["1","2","3","4","5"]  
	               (Cria "sfaf") 
	               (Cria "asfas")
                   (Cazador "lola" ["1","2","3","4","5","6"] 
                   	    (Cria "asfasg")
                   	    (Cria "asgag")
                   	    (Cria "agsbhsdh")))
	           (Explorador "pancho" []
	               (Cria "ksa")
	               (Cria "kasn"))
	           (Cria "qpq"))

manada3 = M (Cazador "pichicho" ["1","2"] 
               (Explorador "firu" ["desembarco del rey"]  
	               (Cria "sfaf") 
                   (Explorador "lola" ["desembarco del rey", "invernalia"] 
                   	    (Cria "asgag")
                   	    (Cria "agsbhsdh")))
	           (Explorador "pancho" ["desembarco del rey"]
	               (Cria "ksa")
	               (Cria "kasn"))
	           (Cria "qpq"))


-- 2) dada una manada, indica si la cantidad de alimento cazado es mayor a la cantidad de crías.
buenaCaza :: Manada -> Bool 
buenaCaza (M l) = cantDePresas l > cantDeCrias l

-- dado un lobo, describe la cantidad de presas que cazaron. 
cantDePresas :: Lobo -> Int
cantDePresas (Cria       n)             = 0
cantDePresas (Explorador n ts l1 l2)    = cantDePresas l1 + cantDePresas l2 
cantDePresas (Cazador    n ps l1 l2 l3) = 
    length ps + cantDePresas l1 + cantDePresas l2 + cantDePresas l3

cantDeCrias :: Lobo -> Int
cantDeCrias (Cria       n)             = 1
cantDeCrias (Explorador n ts l1 l2)    = cantDeCrias l1 + cantDeCrias l2
cantDeCrias (Cazador    n ps l1 l2 l3) = cantDeCrias l1 + cantDeCrias l2 + cantDeCrias l3

-- 3) dada una manada, devuelve el nombre del lobo con más presas cazadas, junto con su cantidad de
--    presas. Nota: se considera que los exploradores y crías tienen cero presas cazadas, y que 
--    podrían formar parte del resultado si es que no existen cazadores con más de cero presas

elAlfa :: Manada -> (Nombre, Int)
elAlfa (M l) = elAlfaL l

elAlfaL :: Lobo -> (Nombre, Int)
elAlfaL (Cria n)                   = (n,0)
elAlfaL (Explorador n ts l1 l2)    = mayorCazador (mayorCazador (n,0) (elAlfaL l1)) (elAlfaL l2)
elAlfaL (Cazador    n ps l1 l2 l3) = 
	mayorCazador (mayorCazador (mayorCazador (n,length ps) (elAlfaL l1)) (elAlfaL l2)) (elAlfaL l3)

-- dadas dos tuplas con nombre de lobo y el número de presas asignadas, devuelve la de mayor cantidad
-- de presas cazadas.
mayorCazador :: (Nombre, Int) -> (Nombre, Int) -> (Nombre, Int)
mayorCazador c1 c2 = 
	if snd c1 > snd c2
		then c1
		else c2


-- 4) dado un territorio y una manada, devuelve los nombres de los exploradores que
--    pasaron por dicho territorio.
losQueExploraron :: Territorio -> Manada -> [Nombre]
losQueExploraron t (M l) = losQueExploraronL t l

losQueExploraronL :: Territorio -> Lobo -> [Nombre]
losQueExploraronL t (Cria n)                = []
losQueExploraronL t (Explorador n ts l1 l2) = singularSi n (elem t ts) ++ losQueExploraronL t l1 ++ losQueExploraronL t l2
losQueExploraronL t (Cazador n ps l1 l2 l3) = 
    losQueExploraronL t l1 ++ losQueExploraronL t l2 ++ losQueExploraronL t l3


-- 5) dada una manada, denota la lista de los pares cuyo primer elemento es un territorio y cuyo segundo 
--    elemento es la lista de los nombres de los exploradores que exploraron  dicho territorio. Los 
--    territorios no deben repetirse.
exploradoresPorTerritorio :: Manada -> [(Territorio, [Nombre])]
exploradoresPorTerritorio (M l) = exploradoresPorTerritorioL l

-- agregarExploradorA n ts (exploradoresPorTerritorioL l1) ++ (exploradoresPorTerritorioL l2)

exploradoresPorTerritorioL :: Lobo -> [(Territorio, [Nombre])]
exploradoresPorTerritorioL (Cria n)                = []
exploradoresPorTerritorioL (Explorador n ts l1 l2) = agregarExploradoresA (exploradorPorTerritorio n ts) (exploradoresPorTerritorioL l1 ++ exploradoresPorTerritorioL l2)
exploradoresPorTerritorioL (Cazador n ps l1 l2 l3) = 
	exploradoresPorTerritorioL l1 ++ exploradoresPorTerritorioL l2 ++ exploradoresPorTerritorioL l3

-- dada una lista de pares territorio/nombre, y una lista de pares territorio/lista de nombres, agrega 
-- los nombres del primer par a la lista de nombres del segundo al que le corresponde el mismo territorio.
agregarExploradoresA :: [(Territorio, Nombre)] -> [(Territorio, [Nombre])] -> [(Territorio, [Nombre])]
agregarExploradoresA []     ys = ys
agregarExploradoresA (x:xs) ys = agregarExplorador x (agregarExploradoresA xs ys)

-- dada un par territorio/nombre, y una lista de pares territorio/nombrelista de nombres, agrega el nombre del 
-- primer par a la lista de nombres del segundo al que le corresponde el mismo territorio.
agregarExplorador :: (Territorio, Nombre) -> [(Territorio, [Nombre])] -> [(Territorio, [Nombre])]
agregarExplorador p []     = (fst p, [(snd p)]) : []
agregarExplorador p (x:xs) = agregarExploradorA p x : (agregarExplorador p xs)

-- dados dos pares territorio/nombre agrega el nombre del primer par a la lista de nombres del segundo
-- si tienen el mismo territorio como primer elemento.
agregarExploradorA :: (Territorio, Nombre) -> (Territorio, [Nombre]) -> (Territorio, [Nombre])
agregarExploradorA p1 p2 = 
	if fst p1 == fst p2
		then agregarNombre (snd p1) p2
		else p2

-- dados un nombre y un par territorio/lista de nombre, agrega el nombre a la lista de nombres del par.
agregarNombre :: Nombre -> (Territorio, [Nombre]) -> (Territorio, [Nombre])
agregarNombre n (t,ns) = (t, n : ns)

-- dado un nombre y una lista de territorios, devuelve una lista de pares con los territorios asociados
-- al nombre.
exploradorPorTerritorio :: Nombre -> [Territorio] -> [(Territorio, Nombre)]
exploradorPorTerritorio n []     = []
exploradorPorTerritorio n (t:ts) = (t,n) : exploradorPorTerritorio n ts


-- 6) dado un nombre de cazador y una manada, indica el nombre de todos los cazadores que tienen
--    como subordinado al cazador dado (directa o indirectamente). 
--    Precondición: hay un cazador con dicho nombre y es único.
superioresDelCazador :: Nombre -> Manada -> [Nombre]
superioresDelCazador = undefined

















