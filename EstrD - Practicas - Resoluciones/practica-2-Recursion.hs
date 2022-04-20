-- 1. RECURSIÓN SOBRE LISTAS

-- Defina las siguientes funciones utilizando recursión estructural sobre listas, salvo que se indique
-- lo contrario:

-- 1) Dada una lista de enteros devuelve la suma de todos sus elementos.
sumatoria :: [Int] -> Int
sumatoria []     = 0
sumatoria (n:ns) = n + sumatoria ns

-- 2) Dada una lista de elementos de algún tipo devuelve el largo de esa lista, es decir, la cantidad
--    de elementos que posee.
longitud :: [a] -> Int  
longitud []     = 0
longitud (x:xs) = 1 + longitud xs

-- 3) Dada una lista de enteros, devuelve la lista de los sucesores de cada entero
sucesores :: [Int] -> [Int]
sucesores []     = []
sucesores (n:ns) = (n+1) : sucesores ns

-- 4) Dada una lista de booleanos devuelve True si todos sus elementos son True.
conjuncion :: [Bool] -> Bool
conjuncion (b:[]) = b
conjuncion (b:bs) = b && conjuncion bs

-- 5) Dada una lista de booleanos devuelve True si alguno de sus elementos es True.
disyuncion :: [Bool] -> Bool
disyuncion (b:[]) = b
disyuncion (b:bs) = b || disyuncion bs

-- 6) Dada una lista de listas, devuelve una única lista con todos sus elementos.
aplanar :: [[a]] -> [a]
aplanar []       = []
aplanar (xs:xss) = xs ++ aplanar xss

-- 7) Dados un elemento e y una lista xs devuelve True si existe un elemento en xs que sea igual a e
pertenece :: Eq a => a -> [a] -> Bool
pertenece e []     = False
pertenece e (x:xs) =  e == x || pertenece e xs

-- 8) Dados un elemento e y una lista xs cuenta la cantidad de apariciones de e en xs.
apariciones :: Eq a => a -> [a] -> Int
apariciones e []     = 0
apariciones e (x:xs) = 
	if e == x
		then 1 + apariciones e xs
		else apariciones e xs

-- 9) Dados un número n y una lista xs, devuelve todos los elementos de xs que son menores a n.
losMenoresA :: Int -> [Int] -> [Int]
losMenoresA n []     = []
losMenoresA n (x:xs) = 
	if x < n 
		then x : losMenoresA n xs
		else losMenoresA n xs 

-- 10) Dados un número n y una lista de listas, devuelve la lista de aquellas listas que tienen más
--     de n elementos.
lasDeLongitudMayorA :: Int -> [[a]] -> [[a]]
lasDeLongitudMayorA n []       = []
lasDeLongitudMayorA n (xs:xss) = 
	if length xs > n 
		then xs : lasDeLongitudMayorA n xss 
		else lasDeLongitudMayorA n xss

-- 11) Dados una lista y un elemento, devuelve una lista con ese elemento agregado al final de la lista.
agregarAlFinal :: [a] -> a -> [a]
agregarAlFinal [] e     = [e]
agregarAlFinal (x:xs) e = x : agregarAlFinal xs e

-- 12) Dadas dos listas devuelve la lista con todos los elementos de la primera lista y todos los
--     elementos de la segunda a continuación. Definida en Haskell como ++.
concatenar :: [a] -> [a] -> [a]
concatenar [] ys = ys
concatenar (x:xs) ys = x : concatenar xs ys

-- 13) Dada una lista devuelve la lista con los mismos elementos de atrás para adelante. Definida
--     en Haskell como reverse.
reversa :: [a] -> [a]
reversa []     = []
reversa (x:xs) = reversa xs ++ [x]

-- 14) Dadas dos listas de enteros, devuelve una lista donde el elemento en la posición n es el
--     máximo entre el elemento n de la primera lista y de la segunda lista, teniendo en cuenta que
--     las listas no necesariamente tienen la misma longitud.
zipMaximos :: [Int] -> [Int] -> [Int]
zipMaximos []     ms     = []
zipMaximos ns     []     = []
zipMaximos (n:ns) (m:ms) = 
	if n > m
		then n : zipMaximos ns ms
		else m : zipMaximos ns ms

-- 15) Dada una lista devuelve el mínimo
elMinimo :: Ord a => [a] -> a
elMinimo (x:[]) = x
elMinimo (x:xs) = min x (elMinimo xs)


-- 2. RECURSIÓN SOBRE NÚMEROS

-- 1) Dado un número n se devuelve la multiplicación de este número y todos sus anteriores hasta
--    llegar a 0. Si n es 0 devuelve 1. La función es parcial si n es negativo
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n-1)

-- 2) Dado un número n devuelve una lista cuyos elementos sean los números comprendidos entre
--    n y 1 (incluidos). Si el número es inferior a 1, devuelve la lista vacía.
cuentaRegresiva :: Int -> [Int]
cuentaRegresiva 0 = []
cuentaRegresiva n = n : cuentaRegresiva (n-1)

-- 3) Dado un número n y un elemento e devuelve una lista en la que el elemento e repite n veces.
repetir :: Int -> a -> [a]
repetir 0 e = []
repetir n e = e : repetir (n-1) e

-- 4) Dados un número n y una lista xs, devuelve una lista con los n primeros elementos de xs.
--    Si la lista es vacía, devuelve una lista vacía.
losPrimeros :: Int -> [a] -> [a]
losPrimeros 0 _      = []
losPrimeros n []     = []
losPrimeros n (x:xs) = x : losPrimeros (n-1) xs 

-- 5) Dados un número n y una lista xs, devuelve una lista sin los primeros n elementos de lista
--    recibida. Si n es cero, devuelve la lista completa.
sinLosPrimeros :: Int -> [a] -> [a]
sinLosPrimeros 0 xs     = xs
sinLosPrimeros n []     = []
sinLosPrimeros n (x:xs) = sinLosPrimeros (n-1) xs

-- 3. REGISTROS

-- PERSONA

-- 1. Definir el tipo de dato Persona, como un nombre y la edad de la persona. Realizar las
--    siguientes funciones:

data Persona = ConsP String Int

jimmy = ConsP "jimmy" 45
lalo  = ConsP "lalo"  50
kim   = ConsP "kim"   40

-- 1) Dados una edad y una lista de personas devuelve a las personas mayores a esa edad.
mayoresA :: Int -> [Persona] -> [Persona]
mayoresA n []     = []
mayoresA n (p:ps) = 
	if esMayorA n p
		then p : mayoresA n ps
		else mayoresA n ps

-- Dada una edad y una Persona indica si la persona es mayor a esa edad.
esMayorA :: Int -> Persona -> Bool
esMayorA n (ConsP nom e) = e > n

-- 2) Dada una lista de personas devuelve el promedio de edad entre esas personas. Precondición: 
--    la lista al menos posee una persona.
promedioEdad :: [Persona] -> Int
promedioEdad ps = promedio (edades ps)

-- Dada una lista de Persona devuelve otra lista con todas las edades.
edades :: [Persona] -> [Int]
edades []     = []
edades (p:ps) = edad p : edades ps

-- Dada una lista de Numero devuelve el promedio.
promedio :: [Int] -> Int
promedio ns = div (sum ns) (length ns)

-- Devuelve la edad de la persona.
edad :: Persona -> Int
edad (ConsP n e) = e 

-- 3) Dada una lista de personas devuelve la persona más vieja de la lista. Precondición: la
--    lista al menos posee una persona.
elMasViejo :: [Persona] -> Persona
elMasViejo (p:[]) = p
elMasViejo (p:ps) = elMasViejoEntre p (elMasViejo ps)

-- dados dos personas, devuelve aquella con mayor edad.
elMasViejoEntre :: Persona -> Persona -> Persona
elMasViejoEntre p1 p2 = 
	if edad p1 > edad p2
	    then p1
	    else p2 


-- POKEMON

data TipoDePokemon = Agua | Fuego | Planta

data Pokemon = ConsPokemon TipoDePokemon Int

data Entrenador = ConsEntrenador String [Pokemon]

squirtle   = ConsPokemon Agua   20
charmander = ConsPokemon Fuego  25
charizard  = ConsPokemon Fuego  30
bulbasaur  = ConsPokemon Planta 18

gus    = ConsEntrenador "gustavo fring"    [squirtle, bulbasaur]
hector = ConsEntrenador "hector salamanca" [charmander, charizard]
don    = ConsEntrenador "don eladio"       [charizard, squirtle, bulbasaur,squirtle, charmander ]

-- 1) Devuelve la cantidad de Pokémon que posee el entrenador.
cantPokemon :: Entrenador -> Int
cantPokemon (ConsEntrenador n ps) = length ps

-- 2) Devuelve la cantidad de Pokémon de determinado tipo que posee el entrenador.
cantPokemonDe :: TipoDePokemon -> Entrenador -> Int
cantPokemonDe t (ConsEntrenador n ps) = cantDeTipo t ps

-- Devuelve la cantidad de Pokémon de determinado tipo que posee la lista de Pokémon dada.
cantDeTipo :: TipoDePokemon -> [Pokemon] -> Int
cantDeTipo t []     = 0
cantDeTipo t (p:ps) = 
	if esMismoTipo t (tipo p)
	    then 1 + cantDeTipo t ps
	    else cantDeTipo t ps

-- Dado un Pokemon devuelve su tipo.
tipo :: Pokemon -> TipoDePokemon
tipo (ConsPokemon t e) = t

-- Dados dos TipoDePokemon indica si son el mismo tipo.
esMismoTipo :: TipoDePokemon -> TipoDePokemon -> Bool
esMismoTipo Agua Agua     = True
esMismoTipo Fuego Fuego   = True
esMismoTipo Planta Planta = True
esMismoTipo _ _           = False

-- 3) Dados dos entrenadores, indica la cantidad de Pokemon de cierto tipo, que le ganarían
--    a los Pokemon del segundo entrenador.
losQueLeGanan :: TipoDePokemon -> Entrenador -> Entrenador -> Int
losQueLeGanan t (ConsEntrenador n1 ps1) (ConsEntrenador n2 ps2) = 
	losQueSuperanA (pokemonDeTipo t ps1) ps2

-- dado un TipoDePokemon y una lista de Pokemon, devuelve la lista con los Pokemon de ese tipo.
pokemonDeTipo :: TipoDePokemon -> [Pokemon] -> [Pokemon]
pokemonDeTipo t []     = []
pokemonDeTipo t (p:ps) = 
	if esMismoTipo t (tipo p)
		then p : pokemonDeTipo t ps
		else pokemonDeTipo t ps

-- Dadas dos listas de Pokemon, indica la cantidad de Pokemon de la primera que le ganarían  
-- a los Pokemon de la segunda.
losQueSuperanA :: [Pokemon] -> [Pokemon] -> Int
losQueSuperanA []       _   = 0
losQueSuperanA (p1:ps1) ps2 = 
	unoSi (superaATodos p1 ps2) + losQueSuperanA ps1 ps2

-- Dado un Pokemon y una lista de Pokemon, indica si el pokemon  le gana a todos los de la lista.
superaATodos :: Pokemon -> [Pokemon] -> Bool
superaATodos p1 []       = True 
superaATodos p1 (p2:ps2) = superaA p1 p2 && superaATodos p1 ps2 

-- Dados dos Pokémon indica si el primero, en base al tipo, es superior al segundo.
-- definida en la práctica anterior.
superaA :: Pokemon -> Pokemon -> Bool
superaA po1 po2 = leGanaPorTipo (tipo po1) (tipo po2) 

-- Dados dos tipos de Pokemon indica si el primero le gana al segundo.
leGanaPorTipo :: TipoDePokemon -> TipoDePokemon -> Bool
leGanaPorTipo Agua Fuego   = True
leGanaPorTipo Fuego Planta = True
leGanaPorTipo Planta Agua  = True
leGanaPorTipo _ _          = False

-- 4) Dado un entrenador, devuelve True si posee al menos un Pokémon de cada tipo posible.
esMaestroPokemon :: Entrenador -> Bool
esMaestroPokemon (ConsEntrenador n ps) = hayTodosLosTipos ps

-- Dada una lista de TipoDePokemon indica si posee todos los tipos posibles.
hayTodosLosTipos :: [Pokemon] -> Bool
hayTodosLosTipos ps = hayPokemonDe Fuego ps && hayPokemonDe Agua ps && hayPokemonDe Planta ps

-- Dado un TipoDePokemon y una lista de Pokemon indica si la lista posee al menos uno del tipo dado.
hayPokemonDe :: TipoDePokemon -> [Pokemon] -> Bool
hayPokemonDe t []     = False
hayPokemonDe t (p:ps) = esMismoTipo t (tipo p) || hayPokemonDe t ps


-- EMPRESA

data Seniority = Junior | SemiSenior | Senior

data Proyecto = ConsProyecto String

data Rol = Developer Seniority Proyecto | Management Seniority Proyecto

data Empresa = ConsEmpresa [Rol]

iluminati = ConsEmpresa [groves, cameron, debus, gottlieb, oppenheimer]

oppenheimer  = (Developer Senior manhattan)
groves = (Management Senior manhattan)
cameron = (Management SemiSenior mkUltra) 
gottlieb = (Developer Senior mkUltra)
debus = (Developer Senior paperclip)

manhattan = ConsProyecto "manhattan"
mkUltra = ConsProyecto "mkUltra"
paperclip = ConsProyecto "paperclip"

-- 1) Dada una empresa denota la lista de proyectos en los que trabaja, sin elementos repetidos.
proyectos :: Empresa -> [Proyecto]
proyectos (ConsEmpresa rs) = proyectosSinRepetidos (todosLosProyectos rs)

-- Dada una lista de Rol, devuelve todos los proyectos.
todosLosProyectos :: [Rol] -> [Proyecto]
todosLosProyectos []     = []
todosLosProyectos (r:rs) = proyecto r : todosLosProyectos rs

-- Dado un Rol, devuelve el Proyecto asociado.
proyecto :: Rol -> Proyecto
proyecto (Developer s p)  = p
proyecto (Management s p) = p

-- Dada una lista la devuelve sin repetidos.
proyectosSinRepetidos :: [Proyecto] -> [Proyecto]
proyectosSinRepetidos []     = []
proyectosSinRepetidos (p:ps) = agregarSiNoEsta p (proyectosSinRepetidos ps)

agregarSiNoEsta :: Proyecto -> [Proyecto] -> [Proyecto]
agregarSiNoEsta p []      = [p]
agregarSiNoEsta p (p2:ps) =  
    if esMismoProyecto p p2
        then agregarSiNoEsta p ps
        else p2 : agregarSiNoEsta p ps

-- Dados dos Proyecto, indica si tienen el mismo nombre.
esMismoProyecto :: Proyecto -> Proyecto -> Bool
esMismoProyecto p1 p2 = nombre p1 == nombre p2

-- Dado un Proyecto, devuelve su nombre.
nombre :: Proyecto -> String
nombre (ConsProyecto n) = n


-- 2) Dada una empresa indica la cantidad de desarrolladores senior que posee, que pertecen
--    además a los proyectos dados por parámetro.
losDevSenior :: Empresa -> [Proyecto] -> Int
losDevSenior (ConsEmpresa rs) ps = cantDesarrolladoresEn (soloLosDevSenior rs) ps

-- Dada una lista de Rol, devuelve la lista sólo con los Developer Senior.
soloLosDevSenior :: [Rol] -> [Rol]
soloLosDevSenior []     = [] 
soloLosDevSenior (r:rs) = 
	if esDevSenior r
		then r : soloLosDevSenior rs
        else soloLosDevSenior rs

-- Dado un Rol, indica si pertenece a un DevSenior.
esDevSenior :: Rol -> Bool
esDevSenior (Developer s _) = esSenior s
esDevSenior _               = False

-- dado un seniority indica si es Senior.
esSenior :: Seniority -> Bool
esSenior Senior = True
esSenior _      = False

-- 3) Indica la cantidad de empleados que trabajan en alguno de los proyectos dados.
cantQueTrabajanEn :: [Proyecto] -> Empresa -> Int
cantQueTrabajanEn ps (ConsEmpresa rs) = cantDesarrolladoresEn rs ps

-- Dadas una lista Rol y proyectos, devuelve la cantidad de desarrolladores que pertenecen
-- a los proyectos dados.
cantDesarrolladoresEn :: [Rol] -> [Proyecto] -> Int
cantDesarrolladoresEn []     _  = 0
cantDesarrolladoresEn (r:rs) ps = unoSi (trabajaEn r ps) + cantDesarrolladoresEn rs ps

-- Dada una condición, devuelve 1 si se cumple y 0 de no hacerlo.
unoSi :: Bool -> Int
unoSi True  = 1
unoSi False = 0

-- Dados un Rol y una lista de Proyecto, indica si el DevSenior trabaja en uno de los proyectos.
trabajaEn :: Rol -> [Proyecto] -> Bool
trabajaEn _ []       = False
trabajaEn r (p2:ps2) = 
	esMismoProyecto (proyecto r) p2 || trabajaEn r ps2 


-- 4) Devuelve una lista de pares que representa a los proyectos (sin repetir) junto con su
--    cantidad de personas involucradas.

asignadosPorProyecto :: Empresa -> [(Proyecto, Int)]
asignadosPorProyecto e = 
	cantPorProyecto (proyectos e) (desarrolladores e) 

-- Dadas unas listas de Proyecto y Rol, devuelve una lista de pares de proyecto junto la cantidad
-- de desarrolladores involucrados.  
cantPorProyecto :: [Proyecto] -> [Rol] -> [(Proyecto, Int)]
cantPorProyecto []     _  = []
cantPorProyecto (p:ps) rs = (p, cantDesarrolladoresEn rs [p]) : cantPorProyecto ps rs

-- Dada una empresa devuelve una lista con sus desarrolladores (Rol).
desarrolladores :: Empresa -> [Rol]
desarrolladores (ConsEmpresa rs) = rs



asignadosPorProyecto' :: Empresa -> [(Proyecto, Int)]
asignadosPorProyecto' (ConsEmpresa rs) = cantPorProyecto' rs
  
cantPorProyecto' :: [Rol] -> [(Proyecto, Int)]
cantPorProyecto' []     = []
cantPorProyecto' (r:rs) = agregarAlProyecto (proyecto r) (cantPorProyecto' rs)

agregarAlProyecto :: Proyecto -> [(Proyecto, Int)] -> [(Proyecto, Int)]
agregarAlProyecto p []         = [(p,1)]
agregarAlProyecto p (tpi:tpis) = 
	if esMismoProyecto p (fst tpi)
		then sumarIntegrante tpi : tpis
		else tpi : agregarAlProyecto p tpis

sumarIntegrante :: (Proyecto, Int) -> (Proyecto, Int)
sumarIntegrante (p,n) = (p,n+1)

