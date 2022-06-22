#include <iostream>
#include "Queue.h"
#include "Tree.h"
using namespace std;

struct NodoQ {
    Tree elem; // valor del nodo
    NodoQ* siguiente; // puntero al siguiente nodo
};

// INV. REP.: *cantidad indica la cantidad de nodos que se pueden recorrer
            // desde primero por siguiente hasta alcanzar a NULL.
            // * primero = NULL sii ultimo = NULL
            // * si ultimo != NULL, ultimo->siguiente = NULL.

struct QueueSt {
    int cantidad;   // cantidad de elementos
    NodoQ* primero; // puntero al primer nodo
    NodoQ* ultimo;  // puntero al ultimo nodo
};

// Crea una lista vacía..
// Costo: O(1).
Queue emptyQ(){
    Queue q = new QueueSt;
    q->cantidad = 0;
    q->primero = NULL;
    q->ultimo = NULL; 
    return q;
}

// Indica si la lista está vacía.
// Costo: O(1).
bool isEmptyQ(Queue q) {
    return q->cantidad == 0;
}

// Devuelve el primer elemento.
// Costo: O(1).
Tree firstQ(Queue q) {
    return q->primero->elem;
}

// Agrega un elemento al final de la cola.
// Costo: O(1).
void Enqueue(Tree t, Queue q) {
    NodoQ* nodo = new NodoQ;
    nodo->elem = t;
    nodo->siguiente = NULL;

    if (q->ultimo == NULL) {q->primero = nodo;}
    else                  {q->ultimo->siguiente = nodo;}
    q->ultimo = nodo;
    q->cantidad++;
}

// Quita el primer elemento de la cola.
// Costo: O(1).
void Dequeue(Queue q) {
    NodoQ* temp = q->primero;
    q->primero = q->primero->siguiente;
    q->cantidad--;

    // por si borro al último elemento
    if (q->primero == NULL){
        q->ultimo = NULL;
    }
    delete temp;
}

// Devuelve la cantidad de elementos de la cola.
// Costo: O(1).
int lengthQ(Queue q) {
    return q->cantidad;
}

// Anexa q2 al final de q1, liberando la memoria inservible de q2 en el proceso.
// Nota: Si bien se libera memoria de q2, no necesariamente la de sus nodos.
// Costo: O(1).
void MergeQ(Queue q1, Queue q2) {
    if(q1->ultimo == NULL) {q1->primero = q2->primero;}
    else                   {q1->ultimo->siguiente = q2->primero;}
    q1->ultimo = q2->ultimo;
    q1->cantidad += q2->cantidad;
    delete q2;
}


// Libera la memoria ocupada por la lista.
// Costo: O(n).
void DestroyQ(Queue q) {
    NodoQ* temp = q->primero;
    while (q->primero != NULL){
        q->primero = q->primero->siguiente;
        delete temp;
        temp = q->primero;
    }
    delete q;
}

void imprimirNodos(Queue q){
    NodoQ* actual = q->primero;
    cout << "Elementos <- [ ";
    for (int i=0; i < q->cantidad; i++){
        if(i>0) {cout << ", "; }
        cout << actual->elem;
        actual = actual->siguiente;
    }
    cout << " ]" << endl;
}

void imprimirLista(Queue q){
    cout << "Cantidad: " << lengthQ(q) << endl;
    cout << "Primero: " <<  q->primero << " = "<< firstQ(q) << endl;
    imprimirNodos(q);
}
