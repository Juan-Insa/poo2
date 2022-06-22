#include <iostream>
#include "Set.h"
#include "LinkedList2.h"
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
    NodoS* actual = s->primero;
    while(actual != NULL && actual->elem != x){
        actual = actual->siguiente;
    }
    if (actual == NULL) {
        return false;
    }
    return actual->elem == x;
}

// Agrega un elemento al conjunto.
// Costo: O(N), siendo N la cantidad de nodos del set.
// Justif.: se recorren los nodos del set, uitlizando operaciones de O(1)
void AddS(int x, Set s) {
    NodoS* nodo = new NodoS;
    nodo->elem = x;
    nodo->siguiente = NULL;

    NodoS* actual = s->primero;
    while(actual != NULL && actual->elem != x) {
        actual = actual->siguiente;
    }
    if (actual == NULL){ // si no encontró un duplicado (llegó al final)
        nodo->siguiente = s->primero; 
        s->primero = nodo;
        s->cantidad++;
    }
}

// Quita un elemento dado.
// Costo: O(N), siendo N la cantidad de nodos del set.
// Justif.: se recorren los nodos del set, uitlizando operaciones de O(1)
void RemoveS(int x, Set s) {
    NodoS* actual = s->primero;
    NodoS* anterior = NULL;
    while (actual != NULL && actual->elem != x){
        anterior = actual;
        actual = actual->siguiente;
    }
    if (actual != NULL){
        anterior->siguiente = actual->siguiente;
        s->cantidad--;
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
        actual = actual->siguiente;
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

void imprimirNodos(Set s){
    NodoS* actual = s->primero;
    cout << "Elementos <- [ ";
    for (int i=0; i < s->cantidad; i++){
        if(i>0) {cout << ", "; }
        cout << actual->elem;
        actual = actual->siguiente;
    }
    cout << " ]" << endl;
}

void imprimirLista(Set s){
    cout << "Cantidad: " << sizeS(s) << endl;
    cout << "Primero: " <<  s->primero << " = "<< s->primero->elem << endl;
    imprimirNodos(s);
}

int main(){
    Set xs = emptyS();
    cout << isEmptyS(xs) << endl;
    cout << belongsS(5,xs) << endl;
    AddS(10,xs); AddS(15,xs); AddS(10,xs); AddS(20,xs);
    cout << belongsS(15,xs) << endl;
    imprimirLista(xs); 
    RemoveS(15,xs);
    imprimirLista(xs);
    imprimirLista(setToList(xs));
}

