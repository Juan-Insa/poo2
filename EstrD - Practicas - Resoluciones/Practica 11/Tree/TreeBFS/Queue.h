#include <iostream>
#include "Tree.h"
using namespace std;

struct QueueSt;

typedef QueueSt* Queue;

Queue emptyQ();
bool isEmptyQ(Queue q);
Tree firstQ(Queue q);
void Enqueue(Tree t, Queue q);
void Dequeue(Queue q);
int lengthQ(Queue q);
void MergeQ(Queue q1, Queue q2);
void DestroyQ(Queue q);
