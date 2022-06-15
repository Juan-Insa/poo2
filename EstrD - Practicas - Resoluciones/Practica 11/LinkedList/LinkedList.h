#include <iostream>
using namespace std;

struct LinkedListSt;
struct IteratorSt;

typedef LinkedListSt* LinkedList;
typedef IteratorSt* ListIterator;

LinkedList nil();
bool isEmpty(LinkedList xs);
int head(LinkedList xs);
void Cons(int x, LinkedList xs);
void Tail(LinkedList xs);
int length(LinkedList xs);
void Snoc(int x, LinkedList xs);
ListIterator getIterator(LinkedList xs);
int current(ListIterator ixs);
void SetCurrent(int x, ListIterator ixs);
void Next(ListIterator ixs);
bool atEnd(ListIterator ixs);
void DisposeIterator(ListIterator ixs);
void DestroyL(LinkedList xs);








