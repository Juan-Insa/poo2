#include <iostream>
#include "ArrayList.h"
using namespace std;

struct ArrayListSt{
    int cantidad;   // cantidad de elementos
    int* elementos; // array de elementos
    int capacidad;  // tamaño del array
};

// Crea una lista con 0 elementos.
// Nota: empezar el array list con capacidad 16}
ArrayList newArrayList(){
    ArrayList xs = new ArrayListSt; 
    xs->cantidad = 0;
    xs->elementos = new int[16];
    xs->capacidad = 16;
    return xs;
}

// Crea una lista con 0 elementos y una capacidad dada por parámetro.
ArrayList newArrayListWith(int capacidad){
    ArrayList xs = new ArrayListSt;
    xs->cantidad = 0;
    xs->elementos = new int[capacidad];
    xs->capacidad = capacidad;
    return xs;
}

// Devuelve la cantidad de elementos existentes.
int lengthAL(ArrayList xs){
    return xs->cantidad;
}

// Devuelve el iésimo elemento de la lista.
// tendría q haber una precondición que el indice es menor o igual a la cantidad
// de elementos del arraylist.
int get(int i, ArrayList xs){
    return xs->elementos[--i];
}

// Reemplaza el iésimo elemento por otro dado.
void set(int i, int x, ArrayList xs){
    if (i <= xs->cantidad){
        xs->elementos[i-1] = x;
    }
}

// Decrementa o aumenta la capacidad del array.
// Nota: en caso de decrementarla, se pierden los elementos del final de la lista.
// observación: conviene reusar newArrayListWith???
void resize(int capacidad, ArrayList xs){
    int* ys = new int[capacidad];
    int nuevaCantidad = 0;
    for (int i=0; i < capacidad && i < xs->capacidad; i++){
        ys[i] = xs->elementos[i];
        nuevaCantidad++;
    }
    delete xs->elementos;
    xs->capacidad = capacidad;
    xs->cantidad = nuevaCantidad;
    xs->elementos = ys;
}

// nota: en esta caso pierdo el puntero original, estaría creando un ArrayList nuevo.
void resize2(int capacidad, ArrayList xs){
    ArrayList ys = new ArrayListSt;
    ys->capacidad = capacidad;
    ys->cantidad = 0;
    ys->elementos = new int[capacidad];
    for (int i=0; i < capacidad && i < xs->capacidad; i++){
        ys->elementos[i] = xs->elementos[i];
        ys->cantidad++;
    }
    delete xs->elementos;
    delete xs;
}

// Agrega un elemento al final de la lista.
void add(int x, ArrayList xs){
    if (xs->cantidad == xs->capacidad){
        resize(xs->capacidad * 2, xs);
    }
    xs->elementos[xs->cantidad] = x;
    xs->cantidad++;
}

// Borra el último elemento de la lista.
// nota: solamente tengo q reducir la cantidad, así cuando se agrega un elemento
// nuevo, simplemente lo pisa o reescribe.
void remove(ArrayList xs){
    xs->cantidad--;
}

void imprimirElementos(ArrayList xs){
    cout << "Elementos <- [ ";
    for (int i=0; i < xs->cantidad; i++){
        if(i>0) {cout << ", "; }
        cout << xs->elementos[i];
    }
    cout << " ]" << endl;
}

void showArrayList(ArrayList xs){
    cout << "Capacidad: " << xs->capacidad << endl;
    cout << "Cantidad de elementos: " << lengthAL(xs) << endl;
    imprimirElementos(xs);
}

/*
int main(){
    ArrayList xs = newArrayListWith(3);
    add(5, xs); add(10, xs); add(15, xs);
    showArrayList(newArrayList());
    showArrayList(xs);
    set(2, 20, xs);
    showArrayList(xs);
    cout << get(3, xs) <<endl;
    resize(5, xs); add(50,xs);
    showArrayList(xs);
    add(25, xs); add(30, xs); // aca el add hace un rezise con el doble de capacidad.
    showArrayList(xs);
    remove(xs);
    add(100, xs);
    showArrayList(xs);
}
*/








