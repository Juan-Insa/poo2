#include <iostream>
#include "Tree.h"
#include "Queue.h"
#include "ArrayList.h"
using namespace std;

// Dado un árbol binario de enteros devuelve la suma entre sus elementos
int sumarT(Tree t) {
    int total = 0; Tree actual;   // inicializo acumulador y tree actual. 
    Queue porProcesar = emptyQ(); // inicializo la cola (o lista).
    if (!isEmptyT(t)) { Enqueue(t,porProcesar); } // nunca habrá un emptyT en la cola
    while (!isEmptyQ(porProcesar)){   // si quedan elementos  
        actual = firstQ(porProcesar); // paso el primer t como actual
        Dequeue(porProcesar);         // saco el primer t de la cola
        total += rootT(actual);       // sumo valor del t actual al acumulador
        if (!isEmptyT(right(actual))) { Enqueue(right(actual),porProcesar); } // si el t der no es null lo encolo
        if (!isEmptyT(left(actual)))  { Enqueue(left(actual), porProcesar); } // si el t izq no es null lo encolo
    }
    DestroyQ(porProcesar);
    return total;
}

// Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árbol (size
// en inglés).
int sizeT(Tree t) {
    int total = 0; Tree actual;
    Queue porProcesar = emptyQ();
    if (!isEmptyT(t)) { Enqueue(t, porProcesar); }
    while (!isEmptyQ(porProcesar)) {
        actual = firstQ(porProcesar);
        Dequeue(porProcesar);
        total++;
        if (!isEmptyT(right(actual))) { Enqueue(right(actual),porProcesar); }
        if (!isEmptyT(left(actual)))  { Enqueue(left(actual), porProcesar); } 
    }
    DestroyQ(porProcesar);
    return total;
}

// Dados un elemento y un árbol binario devuelve True si existe un elemento igual a ese en el
// árbol.
bool perteneceT(int e, Tree t) {
    Tree actual;
    Queue porProcesar = emptyQ();
    if (!isEmptyT(t)) { Enqueue(t, porProcesar); }
    while (!isEmptyQ(porProcesar) && rootT(firstQ(porProcesar)) != e){
        actual = firstQ(porProcesar);
        Dequeue(porProcesar);
        if (!isEmptyT(right(actual))) { Enqueue(right(actual),porProcesar); }
        if (!isEmptyT(left(actual)))  { Enqueue(left(actual), porProcesar); }
    }
    if (!isEmptyQ(porProcesar)) { actual = firstQ(porProcesar); } // si no llegué al final (lo encontré)
    DestroyQ(porProcesar);

    return rootT(actual) == e;
}

int unoSi(bool cond){
    if (cond){
        return 1;
    }
    return 0;
}

// Dados un elemento e y un árbol binario devuelve la cantidad de elementos del árbol que son
// iguales a e.
int aparicionesT(int e, Tree t) {
    int total = 0; Tree actual;
    Queue porProcesar = emptyQ();
    if (!isEmptyT(t)) { Enqueue(t,porProcesar); }
    while (!isEmptyQ(porProcesar)) {
        actual = firstQ(porProcesar);
        Dequeue(porProcesar);
        total += unoSi(rootT(actual) == e);
        if (!isEmptyT(right(actual))) { Enqueue(right(actual),porProcesar); }
        if (!isEmptyT(left(actual)))  { Enqueue(left(actual), porProcesar); }
    }
    DestroyQ(porProcesar);
    return total;
}

// Dado un árbol devuelve una lista con todos sus elementos
ArrayList toList(Tree t) {
    ArrayList xs = newArrayList(); Tree actual;
    Queue porProcesar = emptyQ();
    if (!isEmptyT(t)) { Enqueue(t, porProcesar); }
    while (!isEmptyQ(porProcesar)) {
        actual = firstQ(porProcesar);
        add(rootT(actual), xs);
        Dequeue(porProcesar);  
        if (!isEmptyT(right(t))) { Enqueue(right(t),porProcesar); }
        if (!isEmptyT(left(t)))  { Enqueue(left(t), porProcesar); }
    }
    return xs;
}

int main(){
        Tree t1 = nodeT(10, 
                nodeT(6,
                    nodeT(3, 
                        nodeT(1, emptyT(), emptyT()),
                        nodeT(4, emptyT(), emptyT())),
                    nodeT(7, emptyT(), emptyT())),
                nodeT(10,
                    nodeT(13, 
                        emptyT(),
                        nodeT(10, emptyT(), emptyT())),
                    nodeT(26, emptyT(), emptyT()))
              );
    cout << sumarT(t1) << endl;
    cout << sizeT(t1) << endl;
    cout << perteneceT(5,t1) << endl;
    cout << perteneceT(26,t1) << endl;
    cout << aparicionesT(5,t1) << endl;
    cout << aparicionesT(10,t1) << endl;
    ArrayList xs = toList(t1);
}






