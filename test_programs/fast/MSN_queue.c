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

typedef struct _pointer_t {
  struct _node_t* ptr;
  unsigned count;
} pointer_t;

typedef struct _node_t {
  data_t value;
  pointer_t next;
} node_t;

typedef struct _queue_t {
  pointer_t Head;
  pointer_t Tail;
} queue_t;

/* shared structures */
queue_t queue;
node_t shared_nodes[ROUNDS];
size_t counter=0;

/* CAS */
_Bool inline CAS(pointer_t* addr, pointer_t old, pointer_t new) 
{
  __CPROVER_atomic_begin();
  const _Bool cond=(addr->ptr==old.ptr && addr->count==old.count);
  if(cond) {
    *addr=new;
  }
  __CPROVER_atomic_end();
  return cond;
}

node_t* new_node() {
  if(counter<ROUNDS)
    return shared_nodes+counter++;
  else
    return NULL;
}

void initialize(queue_t* Q) {
  node_t* node=new_node();
  node->next.ptr=NULL;
  Q->Head.ptr=Q->Tail.ptr=node;
}

void enqueue(queue_t* Q, data_t value) {
  pointer_t tail;
  node_t* node=new_node();
  node->value=value;
  node->next.ptr=NULL;
  while(1) {
    tail=Q->Tail;
    const pointer_t next=tail.ptr->next;
    if(tail.ptr==Q->Tail.ptr && tail.count==Q->Tail.count) {
      if(next.ptr==NULL) {
        const pointer_t anonym_0={.ptr=node, .count=next.count+1};
        if(CAS(&tail.ptr->next, next, anonym_0))
          break;
      }
      else {
        const pointer_t anonym_1={.ptr=next.ptr, .count=tail.count+1};
        CAS(&Q->Tail, tail, anonym_1);
      }
    }
  }
  const pointer_t anonym_2={.ptr=node, .count=tail.count+1};
  CAS(&Q->Tail, tail, anonym_2);
}

_Bool dequeue(queue_t* Q, data_t* pvalue) {
  pointer_t head;
  while(1) {
    head=Q->Head;
    const pointer_t tail=Q->Tail;
    const pointer_t next=head.ptr->next;
    if(head.ptr==tail.ptr) {
      if(next.ptr==NULL)
        return FALSE;
      const pointer_t anonym_3={.ptr=next.ptr, .count=tail.count+1};
      CAS(&Q->Tail, tail, anonym_3);
    }
    else {
      *pvalue=next.ptr->value;
      const pointer_t anonym_4={.ptr=next.ptr, .count=head.count+1};
      if(CAS(&Q->Head, head, anonym_4))
        break;
    }
  }
  free(head.ptr);
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

