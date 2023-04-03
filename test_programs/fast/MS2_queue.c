/* Simple, Fast and Practical Non-Blocking and 
 * Blocking Concurrent Queue Algorithms
 * M. M. Michael, M. L. Scott
 * PODC'96
 */
#include <pthread.h>
#include <stdlib.h>

#ifndef CPROVER
#define __CPROVER_atomic_begin() 
#define __CPROVER_atomic_end()  
#define __Bool int
#define nondet() rand()%2
#endif

#define TRUE 1
#define FALSE 0
#define ROUNDS 10

typedef unsigned data_t;

struct _node_t;

typedef struct _node_t {
  data_t value;
  struct _node_t* next;
} node_t;

typedef struct _queue_t {
  node_t* Head;
  node_t* Tail;
  pthread_spinlock_t H_lock;
  pthread_spinlock_t T_lock;
} queue_t;

/* shared structures */
queue_t queue;
node_t shared_nodes[ROUNDS];
size_t counter=0;

node_t* new_node() {
  if(counter<ROUNDS)
    return shared_nodes+counter++;
  else
    return NULL;
}

void initialize(queue_t* Q) {
  node_t* node=new_node();
  node->next=NULL;
  Q->Head=Q->Tail=node;
  pthread_spin_init(&Q->H_lock, NULL);
  pthread_spin_init(&Q->T_lock, NULL);
}

void enqueue(queue_t* Q, data_t value) {
  node_t* node=new_node();
  node->value=value;
  node->next=NULL;
  pthread_spin_lock(&Q->T_lock);
    Q->Tail->next=node;
    Q->Tail=node;
  pthread_spin_unlock(&Q->T_lock);
}

_Bool dequeue(queue_t* Q, data_t* pvalue) {
  pthread_spin_lock(&Q->H_lock);
    node_t* node=Q->Head;
    node_t* new_head=node->next;
    if(new_head==NULL) {
      pthread_spin_unlock(&Q->H_lock);
      return FALSE;
    }
    *pvalue=new_head->value;
    Q->Head=new_head;
  pthread_spin_unlock(&Q->H_lock);
  free(node);
  return TRUE;
}

void* leftThread(void * arg) {
  int i;
  for(i=0; i<ROUNDS; ++i) {
    enqueue(&queue, nondet());
  }
}

void* rightThread(void * arg) {
  int i;
  for(i=0; i<ROUNDS; ++i) {
    data_t val=0;
    _Bool rc=dequeue(&queue, &val);
  }
}

int main () {
  pthread_t pt;
  initialize(&queue);
  pthread_create(&pt, 0, leftThread, 0);
  rightThread(0);
  return 0;
}

