-- 1. NÚMEROS ENTEROS

-- 1. Defina las siguientes funciones:

-- a) Dado un número devuelve su sucesor.
sucesor :: Int -> Int
sucesor n = n + 1

-- b) Dados dos números devuelve su suma utilizando la operación +.
sumar :: Int -> Int -> Int
sumar n m = n + m 

-- c) Dado dos números, devuelve un par donde la primera componente es la división del
--    primero por el segundo, y la segunda componente es el resto de dicha división.
divisionYResto :: Int -> Int -> (Int, Int)
divisionYResto n m = (div n m, mod n m)

-- d) Dado un par de números devuelve el mayor de estos.
maxDelPar :: (Int, Int) -> Int
maxDelPar (x, y) = 
	if x > y 
		then x 
		else y 

-- 2. De 4 ejemplos de expresiones diferentes que denoten el número 10, utilizando en 
--    cada expresión a todas las funciones del punto anterior.

-- a) maxDelPar (divisionYResto (sucesor 20) (sumar 1 1))
-- b) sucesor (maxDelPar (divisionYResto (sumar 20 7) 3))
-- c) sumar 7 (maxDelPar (divisionYResto 10 (sucesor 6)))
-- d) maxDelPar (divisionYResto (sumar 20 (sucesor 4)) 15)


-- 2. TIPOS ENUMERATIVOS

-- 1. Definir el tipo de dato Dir, con las alternativas Norte, Sur, Este y Oeste. Luego implementar
--    las siguientes funciones:

data Dir = Norte | Sur | Este | Oeste

-- a) Dada una dirección devuelve su opuesta
opuesto :: Dir -> Dir
opuesto Norte = Sur 
opuesto Este  = Oeste
opuesto Sur   = Norte
opuesto Oeste = Este

-- b) Dadas dos direcciones, indica si son la misma (con pattern matching).
iguales :: Dir -> Dir -> Bool
iguales Norte Norte = True
iguales Este Este   = True
iguales Sur Sur     = True
iguales Oeste Oeste = True
iguales _ _         = False

-- c) Dada una dirección devuelve su siguiente, en sentido horario, y suponiendo que no existe
--    la siguiente dirección a Oeste.
siguiente :: Dir -> Dir
siguiente Norte = Este 
siguiente Este  = Sur 
siguiente Sur   = Oeste

-- 2. Definir el tipo de dato DiaDeSemana, con las alternativas Lunes, Martes, Miércoles, Jueves,
--    Viernes, Sabado y Domingo. Supongamos que el primer día de la semana es lunes, y el último
--    es domingo. Luego implementar las siguientes funciones:

data DiaDeSemana = Lunes | Martes | Miercoles | Jueves | Viernes | Sabado | Domingo

-- a) Devuelve un par donde la primera componente es el primer día de la semana, y la
--    segunda componente es el último día de la semana.
primeroYUltimoDia :: (DiaDeSemana, DiaDeSemana)
primeroYUltimoDia = (Lunes, Domingo)

-- b) Dado un dia de la semana indica si comienza con la letra M.
empiezaConM :: DiaDeSemana -> Bool
empiezaConM Martes    = True
empiezaConM Miercoles = True
empiezaConM _         = False 

-- c) Dado dos dias de semana, indica si el primero viene después que el segundo.
vieneDespues :: DiaDeSemana -> DiaDeSemana -> Bool
vieneDespues d1 d2 = nroDiaDeSemana d1 > nroDiaDeSemana d2

-- propósito: dado un día de semana lo devuelve numericamente (siendo dede Lunes=1 a Domingo=7) 
nroDiaDeSemana :: DiaDeSemana -> Int 
nroDiaDeSemana Lunes     = 1
nroDiaDeSemana Martes    = 2 
nroDiaDeSemana Miercoles = 3 
nroDiaDeSemana Jueves    = 4 
nroDiaDeSemana Viernes   = 5 
nroDiaDeSemana Sabado    = 6 
nroDiaDeSemana Domingo   = 7

-- d) Dado un dia de la semana indica si no es ni el primer ni el ultimo dia.
estaEnElMedio :: DiaDeSemana -> Bool
estaEnElMedio Lunes   = False
estaEnElMedio Domingo = False
estaEnElMedio _       = True


-- 3. Los booleanos también son un tipo de enumerativo. Un booleano es True o False. Defina
--    las siguientes funciones utilizando pattern matching

-- a) Dado un booleano, si es True devuelve False, y si es False devuelve True.
--    En Haskell ya está definida como not.
negar :: Bool -> Bool
negar True  = False 
negar False = True

-- b) Dados dos booleanos, si el primero es True y el segundo es False, devuelve False, sino devuelve True.
implica :: Bool -> Bool -> Bool
implica True False = False
implica _ _        = True

-- c) Dados dos booleanos si ambos son True devuelve True, sino devuelve False.
--    En Haskell ya está definida como &&
and :: Bool -> Bool -> Bool
and True a = a
and _ _    = False

-- d) Dados dos booleanos si alguno de ellos es True devuelve True, sino devuelve False.
--    En Haskell ya está definida como ||. 
or :: Bool -> Bool -> Bool
or False a = a
or _ _     = True


-- 3. REGISTROS

-- 1. Definir el tipo de dato Persona, como un nombre y la edad de la persona. Realizar las
--    siguientes funciones:

data Persona = ConsP String Int 

pepe = ConsP "pepe" 60
lalo = ConsP "lalo" 50

-- Devuelve el nombre de una persona
nombre :: Persona -> String
nombre (ConsP n e) = n 

-- Devuelve la edad de la persona.
edad :: Persona -> Int
edad (ConsP n e) = e 

-- Aumenta en uno la edad de la persona.
crecer :: Persona -> Persona
crecer (ConsP n e) = (ConsP n (sucesor e))

-- Dados un nombre y una persona, devuelve una persona con la edad de la persona y el nuevo nombre.
cambioDeNombre :: String -> Persona -> Persona
cambioDeNombre nom p = (ConsP nom (edad p))

-- Dadas dos personas indica si la primera es mayor que la segunda.
esMayorQueLaOtra :: Persona -> Persona -> Bool
esMayorQueLaOtra p1 p2 = edad p1 > edad p2

-- Dadas dos personas devuelve a la persona que sea mayor.
laQueEsMayor :: Persona -> Persona -> Persona
laQueEsMayor p1 p2 =  
	if esMayorQueLaOtra p1 p2 
		then p1
		else p2

-- 2. Definir los tipos de datos Pokemon, como un TipoDePokemon (agua, fuego o planta) y un
--    porcentaje de energía; y Entrenador, como un nombre y dos Pokémon. Luego definir las
--    siguientes funciones:

data Pokemon = ConsPo TipoDePokemon Int 

data TipoDePokemon = Agua | Fuego | Planta 

data Entrenador = ConsE String Pokemon Pokemon 

squirtle   = ConsPo Agua   20
charmander = ConsPo Fuego  25
charizard  = ConsPo Fuego  30
bulbasaur  = ConsPo Planta 18

papo = ConsE "Papo" squirtle bulbasaur
tito = ConsE "Tito" charizard charmander

-- Dados dos Pokémon indica si el primero, en base al tipo, es superior al segundo. Agua
-- supera a fuego, fuego a planta y planta a agua. Y cualquier otro caso es falso.
superaA :: Pokemon -> Pokemon -> Bool
superaA po1 po2 = leGanaPorTipo (tipo po1) (tipo po2) 

-- Dados dos tipos de Pokemon indica si el primero le gana al segundo.
leGanaPorTipo :: TipoDePokemon -> TipoDePokemon -> Bool
leGanaPorTipo Agua Fuego   = True
leGanaPorTipo Fuego Planta = True
leGanaPorTipo Planta Agua  = True
leGanaPorTipo _ _          = False

-- Dado un Pokemon devuelve su tipo.
tipo :: Pokemon -> TipoDePokemon
tipo (ConsPo t e) = t

-- Devuelve la cantidad de Pokémon de determinado tipo que posee el entrenador.
cantidadDePokemonDe :: TipoDePokemon -> Entrenador -> Int
cantidadDePokemonDe t (ConsE n p1 p2) = unoSi (esDeTipo t (tipo p1)) + 
                                        unoSi (esDeTipo t (tipo p2))

-- Dados dos TipoDePokemon indica si son el mismo tipo.
esDeTipo :: TipoDePokemon -> TipoDePokemon -> Bool
esDeTipo Agua Agua     = True
esDeTipo Fuego Fuego   = True
esDeTipo Planta Planta = True
esDeTipo _ _           = False

-- Dado un Bool devuelve el valor 1 si se cumple la condición, de lo contrario devuelve 0. 
unoSi :: Bool -> Int 
unoSi True  = 1
unoSi False = 0 


-- Dado un par de entrenadores, devuelve a sus Pokémon en una lista
juntarPokemon :: (Entrenador, Entrenador) -> [Pokemon]
juntarPokemon (e1, e2) = pokemonDeEntrenador e1 ++ pokemonDeEntrenador e2

pokemonDeEntrenador :: Entrenador -> [Pokemon]
pokemonDeEntrenador (ConsE n p1 p2) = p1 : p2 : []


-- 4 FUNCIONES POLIMÓRFICAS

-- 1. Defina las siguientes funciones polimórficas

-- a) Dado un elemento de algún tipo devuelve ese mismo elemento.
loMismo :: a -> a
loMismo a = a

-- b) Dado un elemento de algún tipo devuelve el número 7.
siempreSiete :: a -> Int
siempreSiete a = 7

-- c) Dadas una tupla, invierte sus componentes.
-- ¿Por qué existen dos variables de tipo diferentes?
-- las variables tienen que ser diferentes para representar que son distintos componentes,
-- pero pueden ser del mismo tipo.
swap :: (a,b) -> (b, a)
swap (x, y) = (y, x)

-- 2 ¿Por qué estas funciones son polimórficas?
-- porque aceptan y dan resultado para cualquier variable de tipos.


-- 5 PATTERN MATCHING SOBRE LISTAS

-- 1. Defina las siguientes funciones polimórficas utilizando pattern matching sobre listas (no
--   utilizar las funciones que ya vienen con Haskell):

-- 2. Dada una lista de elementos, si es vacía devuelve True, sino devuelve False.
--    Definida en Haskell como null.
estaVacia :: [a] -> Bool
estaVacia [] = True
estaVacia _  = False

-- Dada una lista devuelve su primer elemento.
-- Definida en Haskell como head.
elPrimero :: [a] -> a  
elPrimero (x:_) = x  

-- Dada una lista devuelve esa lista menos el primer elemento.
-- Definida en Haskell como tail
sinElPrimero :: [a] -> [a]
sinElPrimero (_:xs) = xs 

-- Dada una lista devuelve un par, donde la primera componente es el primer elemento de la
-- lista, y la segunda componente es esa lista pero sin el primero.
splitHead :: [a] -> (a, [a])
splitHead xs = (elPrimero xs, sinElPrimero xs)



















