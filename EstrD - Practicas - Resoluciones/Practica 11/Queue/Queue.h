#include <iostream>
using namespace std;

struct QueueSt;

typedef QueueSt* Queue;

Queue emptyQ();
bool isEmptyQ(Queue q);
int firstQ(Queue q);
void Enqueue(int x, Queue q);
void Dequeue(Queue q);
int lengthQ(Queue q);
void MergeQ(Queue q1, Queue q2);
void DestroyQ(Queue q);
