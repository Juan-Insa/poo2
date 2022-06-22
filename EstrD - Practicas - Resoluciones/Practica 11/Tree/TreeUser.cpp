#include <iostream>
#include "Tree.h"
#include "ArrayList.h"
using namespace std;

// Dado un árbol binario de enteros devuelve la suma entre sus elementos
int sumarT(Tree t) {
    if (isEmptyT(t)){
        return 0;
    }
    else {
        return rootT(t) + sumarT(left(t)) + sumarT(right(t));
    }
}

// Dado un árbol binario devuelve su cantidad de elementos, es decir, el tamaño del árbol (size
// en inglés).
int sizeT(Tree t) {
    if (isEmptyT(t)){
        return 0;
    }
    else {
        return 1 + sizeT(left(t)) + sizeT(right(t));
    }
}

// Dados un elemento y un árbol binario devuelve True si existe un elemento igual a ese en el
// árbol.
bool perteneceT(int e, Tree t) {
    if (isEmptyT(t)) {
        return false;
    }
    else {
        return rootT(t) == e || perteneceT(e,left(t)) || perteneceT(e,right(t));
    }
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
    if (isEmptyT(t)){
        return 0;
    }
    else {
        return unoSi(e == rootT(t)) + aparicionesT(e,left(t)) + aparicionesT(e,right(t));
    }
}

// Dado un árbol devuelve su altura.
int heightT(Tree t) {
    if (isEmptyT(t)){
        return 0;
    }
    else {
        return 1 + max (heightT(left(t)), heightT(right(t)));
    }
}

// agrega los nodos del árbol al arraylist dado.
void addToList(ArrayList xs, Tree t){
    if (!isEmptyT(t)){
        add(rootT(t), xs);
        addToList(xs,left(t));
        addToList(xs,right(t));
    }    
}

// Dado un árbol devuelve una lista con todos sus elementos
ArrayList toList(Tree t) {
    ArrayList xs = newArrayList(); // lista como acumulador
    addToList(xs,t);
    return xs;
}

// agrega las hojas del árbol al arrayList
// precondición: el árbol no es vacío
void leavesFrom(ArrayList xs, Tree t){
    if(!isEmptyT(t)){
        // si es hoja la agrega
        if (isEmptyT(left(t)) && isEmptyT(right(t))) {
            add(rootT(t), xs);
        }
        else {
            leavesFrom(xs, left(t));
            leavesFrom(xs, right(t));
        }
    }
}

// Dado un árbol devuelve los elementos que se encuentran en sus hojas
ArrayList leaves(Tree t) {
    ArrayList xs = newArrayList();
    leavesFrom(xs,t);
    return xs;
}

void levelNT(int n, Tree t, ArrayList xs){
    if (!isEmptyT(t)){
        if (n == 0) {
            add(rootT(t),xs);
        }
        else {
            levelNT(n-1, left(t),xs);
            levelNT(n-1, right(t),xs);
        }
    }
}

// Dados un número n y un árbol devuelve una lista con los nodos de nivel n.
ArrayList levelN(int n, Tree t) {
    ArrayList xs = newArrayList();
    levelNT(n,t,xs);
    return xs;
}


int main() {
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
    cout << perteneceT(24,t1) << endl;
    cout << aparicionesT(10,t1) << endl;
    cout << heightT(t1) << endl;
    showArrayList(toList(t1));
    showArrayList(leaves(t1));
    showArrayList(levelN(2,t1));
}
















