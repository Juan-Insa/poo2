#include <iostream>
#include "LinkedList2.h"
#include "Set.h"
using namespace std;

struct NodoS {
    int elem;         // valor del nodo
    NodoS* siguiente; // puntero al siguiente nodo
};

// INV. REP.: // INV.REP.: *cantidad indica la cantidad de nodos que se pueden recorrer
              // desde primero por siguiente hasta alcanzar a NULL.
              // * no existen nodos con valores repetidos.
struct SetSt {
    int cantidad;   // cantidad de elementos diferentes
    NodoS* primero; // puntero al primer nodo
};


// Crea un conjunto vacío.
// Costo: O(1), todas las operaciones son O(1).
Set emptyS() {
    Set s = new SetSt;
    s->cantidad = 0;
    s->primero = NULL;
    return s;
}

// Indica si el conjunto está vacío.
// Costo: O(1), todas las operaciones son O(1).
bool isEmptyS(Set s) {
    return s->cantidad == 0;
}

// Indica si el elemento pertenece al conjunto.
// Costo: O(N), siendo N la cantidad de nodos del set.
// Justif.: se recorren los nodos del set, uitlizando operaciones de O(1)
bool belongsS(int x, Set s) {
    if (s->cantidad != 0) {
        NodoS* actual = s->primero;
        while(actual->elem != x || actual != NULL){
            actual = actual->siguiente;
        }
        return actual->elem == x;
    else {return false;} 
    }
}

// Agrega un elemento al conjunto.
// Costo: O(N), siendo N la cantidad de nodos del set.
// Justif.: se recorren los nodos del set, uitlizando operaciones de O(1)
void AddS(int x, Set s) {
    NodoS* nodo = new NodoS;
    nodo->elem = x;
    nodo->siguiente = NULL;

    NodoS* actual = s->primero;
    while(actual->elem != x || actual == NULL) {
        actual = actual->siguiente;
    }
    if (actual->elem != x){
        nodo->siguiente = s->primero;
        s->primero = nodo;
    }
}

// Quita un elemento dado.
// Costo: O(N), siendo N la cantidad de nodos del set.
// Justif.: se recorren los nodos del set, uitlizando operaciones de O(1)
void RemoveS(int x, Set s) {
    NodoS* actual = s->primero;
    NodoS* anterior = NULL;
    while (actual->elem != x || actual != NULL){
        anterior = actual;
        actual->siguiente;
    }
    if (actual != NULL){
        anterior->siguiente = actual->siguiente;
        delete actual;
    } 
}

// Devuelve la cantidad de elementos.
// Costo: O(1), todas las operaciones son O(1).
int sizeS(Set s) {
    return s->cantidad;
}

// Devuelve una lista con los elementos del conjunto.
// Costo: O(N), siendo N la cantidad de nodos del set.
// Justif.: se recorren los nodos del set, uitlizando operaciones de O(1)
LinkedList setToList(Set s) {
    LinkedList xs = nil();
    NodoS* actual = s->primero;
    while (actual != NULL) {
        Snoc(actual->elem, xs);
    }
    return xs;
}

// Libera la memoria ocupada por el conjunto.
// Costo: O(N), siendo N la cantidad de nodos del set.
// Justif.: se recorren los nodos del set, uitlizando operaciones de O(1)
void DestroyS(Set s) {
    NodoS* temp = s->primero;
    while (s->primero != NULL) {
        s->primero = s->primero->siguiente;
        delete temp;
        temp = s->primero;
    }
    delete s; 
}






