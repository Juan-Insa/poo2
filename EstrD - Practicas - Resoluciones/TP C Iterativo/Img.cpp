#include "Img.h"
#include <math.h>

#define DIR        int
#define HOJA       99
#define HORIZONTAL 42
#define VERTICAL   17

struct ITreeSt {     
    DIR      division;    
    Color    color;       
    ITreeSt* first;    
    ITreeSt* second;
};
 /* INV.REP.
    * el valor de division admitidos son HOJA(99), HORIZONTAL(42) O VERTICAL(17).
    OBS: si division es
      - HOJA, entonces color es el color del bloque representado  
      - HORIZONTAL, entonces first es la parte izquierda y second la derecha
      - VERTICAL, entonces first es la parte superior y second la inferior
 */

struct ImgSt {
    int height;
    int width;
    int size;
    ITreeSt* t;
};
 /* INV.REP.
    * el valor de size es menor o igual a width * height.
    * el valor de size es igual a la cantidad de hojas de t.
    * todo nodo de t con campo DIR VERTICAL tiene hijos con DIR HORIZONTAL u HOJA.
    * todo nodo de t con campo DIR HORIZONTAL tiene hijos con DIR VERTICAL u HOJA.
    * width y height son valores potencia de 2.
    * width y height tienen el mismo valor. Obs: forman un cuadrado.
 */

struct NodoQ {
    ITreeSt* elem; // valor del nodo
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

typedef QueueSt* Queue;


/*
------------------------------------------------------
QUEUE - IMPLEMENTACIÓN
------------------------------------------------------
*/
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
ITreeSt* firstQ(Queue q) {
    return q->primero->elem;
}

// Agrega un elemento al final de la cola.
// Costo: O(1).
void Enqueue(ITreeSt* x, Queue q) {
    NodoQ* nodo = new NodoQ;
    nodo->elem = x;
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
    
    // por si saco al último elemento
    if (q->primero == NULL){
        q->ultimo = NULL;
    }
    
    delete temp;
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
// --------------------------------------------------------


//---------------------------------------------------------
// sizeImg
//---------------------------------------------------------

int unoSi(bool cond){
  if (cond) {
    return 1;
  }
  return 0;
}

// devuelve la cantidad de bloques de la imágen.
// obs: serían la cantidad de hojas que componen el árbol de la img.
int sizeImg2(Img img) {
  ITreeSt* t = img->t;
  int total = 0; ITreeSt* actual;
  Queue porProcesar = emptyQ();
  if (t != NULL) { Enqueue(t, porProcesar); }
  while (!isEmptyQ(porProcesar)) {
    actual = firstQ(porProcesar);
    Dequeue(porProcesar);
    total += unoSi(actual->division == HOJA);
    if (actual->first  != NULL) { Enqueue(actual->first,  porProcesar); }
    if (actual->second != NULL) { Enqueue(actual->second, porProcesar); }
  }
  DestroyQ(porProcesar);
  return total;
}


// devuelve la cantidad de bloques de la imágen.
// obs: serían la cantidad de hojas que componen el árbol de la img.
int sizeImg(Img img) {
  return img->size;
}

//---------------------------------------------------------
// createImg
//---------------------------------------------------------
// AUXILIAR SUGERIDA
ITreeSt* loadIT(int iw, int ih
               ,int fw, int fh
               ,int n, Matrix m, DIR d) {
  ITreeSt* t = new ITreeSt;
  t->division = d;
  if (n == 1) {
    cout << "hoja" << endl;
    t->division = HOJA;
    t->color  = M_getAt(m, iw, ih);
    t->first  = NULL;
    t->second = NULL;
    return t;
  }
  if (t->division == HORIZONTAL){
    cout << "nodo horizontal " << endl; 
    t->color  = NULL;
    t->first  = loadIT(iw, ih,        fw, fh/2, n/2, m, VERTICAL);
    t->second = loadIT(iw, ih+(fh/2), fw, fh/2, n/2, m, VERTICAL);
    return t;
  }
  if (t->division == VERTICAL){
    cout << "nodo vertical " << endl; 
    t->color  = NULL;
    t->first  = loadIT(iw,        ih, fw/2, fh, n/2, m, HORIZONTAL);
    t->second = loadIT(iw+(fw/2), ih, fw/2, fh, n/2, m, HORIZONTAL);
    return t;
  }
  return t;
}

// genera una imagen a partir de la matriz y dimension dada.
// PRECOND: w es potencia de 2, m es de w*w
Img createImg(Matrix m, int w) {
  Img i = new ImgSt;
  i->height = w;
  i->width  = w;
  i->size   = w*w;
  cout << i->height << endl;
  cout << i->width << endl;
  cout << i->size << endl;
  i->t      = loadIT(1, 1, w, w, w*w, m, HORIZONTAL);
  M_delete(m);
  return i;
}

//---------------------------------------------------------
// CompressImg
//---------------------------------------------------------
int buildT(ITreeSt* t) {
  // si los hijos son hojas con mismo color
  if (t->first->division  == HOJA && 
    t->second->division == HOJA && 
    t->first->color == t->second->color) {

    // modifico al padre como hoja del color de los hijos
    t->division = HOJA;
    t->color  = t->first->color;

    // elimino los hijos
    delete t->first;
    delete t->second;

    // los declaro NULL
    t->first  = NULL;
    t->second = NULL;

    return 1;
  }
  return 0;
}


// AUXILIAR SUGERIDA
// OBS: el int retornado es la cantidad de hojas comprimidas.
// VERSION RECURSIVA
int CompressIT(ITreeSt* t) {  
  if (t->division != HOJA) {
    return CompressIT(t->first) + CompressIT(t->second) + buildT(t);
  }
  return 0;
}

// auxiliar VERSION ITERATIVA, dado un arbol destruye los nodos hijos si son hojas de mismo color y le asigna
// ese color al padre volviendolo una hoja del color de los hijos.
// precond: el árbol dado no es NULL y no es HOJA.
// OBS: *si se destruyen los hijos retorna el valor 1, de lo contrario 2.
// esto sirve para modificar el size resultante.
int Compress(ITreeSt* t) {
  ITreeSt* hijo1 = t->first; ITreeSt* hijo2 = t->first;
  // si los hijos son hojas con mismo color
  if (t->first->division  == HOJA &&
      t->second->division == HOJA &&
      t->first->color == t->second->color) {
        // cambio al padre como hoja del color de sus hijos.
        t->color  = hijo1->color;
        t->division = HOJA;
        t->first    = NULL;
        t->second   = NULL;

        // destruyo los hijos :)
        delete hijo1;
        delete hijo2;
        return 1;
  }
  if (t->first->division  == HOJA &&
      t->second->division == HOJA){
        return 2;
  }
  if ((t->first->color != NULL && t->second->color == NULL) ||
      (t->first->color == NULL && t->second->color != NULL)){
        return 1;
  }
  return 0;
}

//VERSION ITERATIVA
int CompressIT2(ITreeSt* t) { 
  // si la raíz(t) es una hoja
  if (t->division == HOJA) {
    return 1;
  }
  int size = 0; ITreeSt* actual; 
  Queue porProcesar = emptyQ();
  Enqueue(t, porProcesar);
  while (!isEmptyQ(porProcesar)) {
    actual = firstQ(porProcesar);
    if (actual->first != NULL && actual->first->division != HOJA)   { Enqueue(actual->first, porProcesar); }
    if (actual->second != NULL && actual->second->division != HOJA) { Enqueue(actual->second, porProcesar); }
    Dequeue(porProcesar);
    size += Compress(actual);
    cout << size << endl;
  }
  DestroyQ(porProcesar);
  return size;
}

void CompressImg(Img img) {
  if (img->t != NULL) { img->size -= CompressIT(img->t); }
}

//---------------------------------------------------------
// RenderImg
//---------------------------------------------------------
void RenderBlock(int x, int y, int w, int h, ITreeSt* t) {
    if (t->color != NULL){
      cout << 
        "\n<rect"
          << " x=\""      << 50 * x << "\""
          << " y=\""      << 50 * y << "\""
          << " width=\""  << 50 * w << "\""
          << " height=\"" << 50 * h << "\""
          << " style=\"fill:"; RenderColor(t->color,10); 
      cout <<
        ";stroke-width:3;stroke:rgb(0,0,0) " "\"/>";
    }
}

// AUXILIAR SUGERIDA
void RenderIT(int x, int y, int w, int h, ITreeSt* t) {
  if (t->division == HOJA) {
    RenderBlock(x,y,w,h,t);
  }
  if (t->division == HORIZONTAL) {
    RenderIT(x, y,       w, h/2, t->first);
    RenderIT(x, y+(h/2), w, h/2, t->second);
  }
  if (t->division == VERTICAL) {
    RenderIT(x,       y, w/2, h, t->first);
    RenderIT(x+(w/2), y, w/2, h, t->second);
  }
}

void RenderImg(Img img) {
  int w = img->width;
  int h = img->height;
  ITreeSt* t = img->t;
  cout << "<svg height=\"" << h * 50 << "\""
         <<    " width=\"" << w * 50 
       << "\">";
            RenderIT(0, 0, w, h, t);
  cout << "\n</svg>";
} 

Matrix Source2() {
  Matrix source2 = M_new(8,8, green4);
  for(int i=1;i<=8;i++) { for(int j=1;j<=4;j++) { M_setAt(source2,i,j,cyan); } }
  M_setAt(source2,3,2,green1);  M_setAt(source2,2,3,green1);
  M_setAt(source2,3,3,green1);  M_setAt(source2,2,4,green1);
  M_setAt(source2,3,5,green1);
  M_setAt(source2,3,4,green2);  M_setAt(source2,6,4,green2);
  M_setAt(source2,4,3,green2);  M_setAt(source2,4,4,green2);
  M_setAt(source2,4,5,green2);  M_setAt(source2,5,3,green2);
  M_setAt(source2,5,4,green2);  M_setAt(source2,5,5,green2);
  M_setAt(source2,4,2,green3);  M_setAt(source2,5,2,green3);
  M_setAt(source2,6,2,green3);  M_setAt(source2,6,3,green3);
  M_setAt(source2,7,3,green3);  M_setAt(source2,6,5,green3);
  M_setAt(source2,7,4,green3);
  M_setAt(source2,4,6,brown1);  M_setAt(source2,4,7,brown1);
  M_setAt(source2,5,6,brown2);  M_setAt(source2,5,7,brown2);
  return(source2);
}


int main(){
  Matrix m = Source2();
  Img i = createImg(m,8);
  cout << sizeImg2(i) << endl;
  CompressImg(i);
  cout << sizeImg2(i) << endl;
  cout << sizeImg(i) << endl;
  RenderImg(i);
}

/*
void RenderIT2(int x, int y, int w, int h, ITreeSt* t) {
    ITreeSt* actual; 
    Queue porProcesar = emptyQ();
    if (t != NULL) { Enqueue(t, porProcesar); }
    while (!isEmptyQ(porProcesar)) {
      actual = firstQ(porProcesar);
      Dequeue(porProcesar);
      RenderBlock(x, y, w, h, actual);
      if (actual->first  != NULL) { Enqueue(actual->first,  porProcesar); }
      if (actual->second != NULL) { Enqueue(actual->second, porProcesar); }
    }
    DestroyQ(porProcesar);
}*/