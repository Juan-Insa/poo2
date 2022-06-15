#include <iostream>
#include "LinkedList.h"
using namespace std;

struct NodoL {
    int elem;         //velor del nodo
    NodoL* siguiente; //puntero al siguiente nodo
};

struct LinkedListSt {
    // INV.REP.: cantidad indica la cantidad de nodos que se pueden recorrer
    // desde primero por siguiente hasta alcanzar a NULL
    int cantidad;   // cantidad de elementos
    NodoL* primero; // puntero al primer nodo
};

struct IteratorSt {
    NodoL* current;
};

// Crea una lista vacía.
// Costo: O(1). todas las operaciones son O(1).
LinkedList nil(){
    LinkedList xs = new LinkedListSt;
    xs->cantidad = 0;
    xs->primero = NULL;
    return xs;
}

// Indica si la lista está vacía.
// Costo: O(1). todas las operaciones son O(1).
bool isEmpty(LinkedList xs) {
    return xs->cantidad == 0;
}

// Devuelve el primer elemento
// Costo: O(1). todas las operaciones son O(1).
int head(LinkedList xs) {
    return xs->primero->elem;
}

// Agrega un elemento al principio de la lista.
// Costo: O(1). todas las operaciones son O(1).
void Cons(int x, LinkedList xs) {
    NodoL* nodo = new NodoL;
    nodo->elem = x;
    nodo->siguiente = xs->primero;

    xs->primero = nodo;
    xs->cantidad++;
}

// Quita el primer elemento.
// Costo: O(1). todas las operaciones son O(1).
void Tail(LinkedList xs) {
    if(xs->cantidad != 0) {
        NodoL* temp = xs->primero;
        xs->primero = xs->primero->siguiente;
        xs->cantidad--;
        delete temp;
    }
}

// Devuelve la cantidad de elementos.
// Costo: O(1). todas las operaciones son O(1).
int length(LinkedList xs) {
    return xs->cantidad;
}

// Agrega un elemento al final de la lista.
// Costo: O(N), siendo N la cantidad de elementos de la lista.
// Justif.: se recorren todos los nodos de la lista.
void Snoc(int x, LinkedList xs) {
    NodoL* nodo = new NodoL();
    nodo->elem = x;
    nodo->siguiente = NULL;

    NodoL* actual = xs->primero;
    while(actual->siguiente != NULL){ 
        actual = actual->siguiente;    
    }
    actual->siguiente = nodo; 
    xs->cantidad++;
}

// Apunta el recorrido al primer elemento.
// Costo: O(1), todas las operaciones son O(1).
ListIterator getIterator(LinkedList xs) {
    ListIterator ixs = new IteratorSt;
    ixs->current = xs->primero;
    return ixs;
}

// Devuelve el elemento actual en el recorrido.
// Costo: O(1), todas las operaciones son O(1).
int current(ListIterator ixs) {
    return ixs->current->elem;
}

// Reemplaza el elemento actual por otro elemento
// Costo: O(1), todas las operaciones son O(1).
void SetCurrent(int x, ListIterator ixs) {
    ixs->current->elem = x;
}

// Pasa al siguiente elemento.
// Costo: O(1), todas las operaciones son O(1).
void Next(ListIterator ixs) {
    ixs->current = ixs->current->siguiente;
}

// Indica si el recorrido ha terminado.
// Costo: O(1), todas las operaciones son O(1).
bool atEnd(ListIterator ixs) {
    return ixs->current == NULL;
}

// Libera la memoria ocupada por el iterador.
// Costo: O(1), todas las operaciones son O(1).
void DisposeIterator(ListIterator ixs) {
    delete ixs;
}

// Libera la memoria ocupada por la lista.
// Costo: O(N), siendo N la cantidad de elementos de la lista.
// Justif.: se recorren todos los nodos de la lista.
void DestroyL(LinkedList xs) {
    NodoL* temp = xs->primero;
    while(xs->primero = NULL) { // libero todos los nodos
        xs->primero = xs->primero->siguiente;
        delete temp;
        temp = xs->primero;
    }
    delete xs; // libero el encabezado
}

void imprimirNodos(LinkedList xs){
    NodoL* actual = xs->primero;
    cout << "Elementos <- [ ";
    for (int i=0; i < xs->cantidad; i++){
        if(i>0) {cout << ", "; }
        cout << actual->elem;
        actual = actual->siguiente;
    }
    cout << " ]" << endl;
}

void imprimirLista(LinkedList xs){
    cout << "Cantidad: " << length(xs) << endl;
    cout << "Primero: " <<  xs->primero << " = "<< head(xs) << endl;
    imprimirNodos(xs);
}

int main(){
    LinkedList xs = nil();  
    cout << "es vacia: " << isEmpty(xs) << endl; 
    Cons(5, xs); Cons(4, xs); Cons(3, xs);
    imprimirLista(xs);
    Tail(xs);
    cout << "" << endl;
    imprimirLista(xs);
    Snoc(6, xs); Snoc(7, xs);
    cout << "" << endl;
    imprimirLista(xs);
    DestroyL(xs);
    cout << "" << endl;
    imprimirLista(xs);

}
























