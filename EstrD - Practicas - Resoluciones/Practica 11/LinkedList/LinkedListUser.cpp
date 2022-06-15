#include <iostream>
#include "LinkedList.h"
using namespace std;

// Devuelve la suma de todos los elementos.
// Costo:(N), siendo N la cantidad de elementos de la lista.
// Justif.: se hace un recorrido sobre la lista utilizando operaciones con O(1).
int sumatoria(LinkedList xs) {
    int total = 0;
    ListIterator ixs = getIterator(xs); // genero iterador
    while(! atEnd(ixs)){
        total += current(ixs);
        Next(ixs);
    }
    DisposeIterator(ixs); // libero iterador
    return total;
}

// Incrementa en uno todos los elementos.
// Costo:(N), siendo N la cantidad de elementos de la lista.
// Justif.: se hace un recorrido sobre la lista utilizando operaciones con O(1).
void Sucesores(LinkedList xs){
    ListIterator ixs = getIterator(xs);
    while(! atEnd(ixs)){
        SetCurrent(current(ixs) + 1, ixs);
        Next(ixs);
    }
    DisposeIterator(ixs);
}

// Indica si el elemento pertenece a la lista.
// Costo:(N), siendo N la cantidad de elementos de la lista.
// Justif.: se hace un recorrido sobre la lista utilizando operaciones con O(1).
bool pertenece(int x, LinkedList xs) {
    ListIterator ixs = getIterator(xs);
    bool resultado;
    while(current(ixs) != x || !atEnd(ixs)){
        Next(ixs);
    }
    resultado = current(ixs) == x; // lo guardo en variable porque si no lo pierdo.
    DisposeIterator(ixs);
    return resultado;
}

int unoSi(bool cond){
    if (cond){
        return 1;
    }
    return 0;
}

// Indica la cantidad de elementos iguales a x.
// Costo:(N), siendo N la cantidad de elementos de la lista.
// Justif.: se hace un recorrido sobre la lista utilizando operaciones con O(1).
int apariciones(int x, LinkedList xs) {
    ListIterator ixs = getIterator(xs);
    int total = 0;
    while (!atEnd(ixs)){
        total += unoSi(current(ixs) == x);
        Next(ixs);
    }
    DisposeIterator(ixs);
    return total;
}

// Devuelve el elemento más chico de la lista.
// Costo:(N), siendo N la cantidad de elementos de la lista.
// Justif.: se hace un recorrido sobre la lista utilizando operaciones con O(1).
int minimo(LinkedList xs){
    if (!isEmpty(xs)) {
        ListIterator ixs = getIterator(xs);
        int minimo = current(ixs);
        Next(ixs);
        while (!atEnd(ixs)){
            minimo = min(minimo, current(ixs));
            Next(ixs);
        }
        DisposeIterator(ixs);
        return minimo;
    }
}

// Dada una lista genera otra con los mismos elementos, en el mismo orden.
// Nota: notar que el costo mejoraría si Snoc fuese O(1)  ¿cómo podría serlo?
// podría serlo si ubiera una operacion en la interfaz de lista que me de el último elemento en O(1).
// Costo: O(N^2): siendo N la cantidad de elementos de xs.
// Justif.: se hace un recorrido sobre xs, utilizando la operación Snoc con O(N). El
// resto de las operaciones es de O(1) y no se toman en cuenta.
LinkedList copy(LinkedList xs) {
    LinkedList ys = nil();
    ListIterator ixs = getIterator(xs);
    while (!atEnd(ixs)){
        Snoc(current(ixs),ys);
        Next(ixs);
    }
    DisposeIterator(ixs);
    return ys;
}

// Agrega todos los elementos de la segunda lista al final de los de la primera.
// La segunda lista se destruye.
// Costo: O(Y*X): siendo Y la cantidad de elementos de ys y X la cant de elementos de X.
// Justif.: por cada elemento de ys se recorre xs con la operación Snoc de O(X).
void Append(LinkedList xs, LinkedList ys) {
    
}







