/* A Lazy Concurrent List-Based Set Algorithm
 * S. Heller, M. Herlihy, V. Luchangco, M. Moir, 
 * W. N. Scherer III, N. Shavit
 * OPODIS'05
 */
#include <pthread.h>
#include <stdlib.h>

#ifndef CPROVER
#define __CPROVER_atomic_begin() 
#define __CPROVER_atomic_end()  
#define _Bool int
#define nondet() rand()%2
#endif

#define FALSE 0
#define TRUE 1
#define ROUNDS 10

typedef struct _Entry_t {
  int key;
  struct _Entry_t* next;
  _Bool marked;
  pthread_spinlock_t lock;
} * Entry_t;

typedef struct _List_t {
  Entry_t elements;
  Entry_t head;
  Entry_t tail;
} List_t;

/* shared structures */
List_t this;
struct _Entry_t shared_nodes[ROUNDS];
size_t counter=0;

Entry_t new_element(int k) {
  if(counter<ROUNDS) {
    Entry_t new_entry=shared_nodes+counter++;
    new_entry->key=k;
    new_entry->next=NULL;
    new_entry->marked=FALSE;
    pthread_spin_init(&new_entry->lock, 0);
  }
  else
    return NULL;
}

void init(List_t* L) {
  L->elements=new_element(0);
  L->head=L->elements;
  L->tail=L->elements;
}

_Bool validate(Entry_t pred, Entry_t curr) {
  return !pred->marked && !curr->marked && pred->next==curr;
}

_Bool remove(int key, List_t* this) {
  while (TRUE) {
    Entry_t pred=this->head;
    Entry_t curr=this->head->next;
    while(curr->key<key) {
      pred=curr;
      curr=curr->next;
    }
    pthread_spin_lock(&pred->lock);
    /* try */
      pthread_spin_lock(&curr->lock);
      /* try */
        if(validate(pred, curr)) {
          if(curr->key!=key) {
            return FALSE;
          }
          else {
            curr->marked=TRUE;
            pred->next=curr->next;
            return TRUE;
          }
        }
      /* finally */
        pthread_spin_unlock(&curr->lock);
    /* finally */
    pthread_spin_unlock(&pred->lock);
  }
}

_Bool add(int key, List_t* this) {
  while (TRUE) {
    Entry_t pred=this->head;
    Entry_t curr=this->head->next;
    while(curr->key<key) {
      pred=curr;
      curr=curr->next;
    }
    pthread_spin_lock(&pred->lock);
    /* try */
      pthread_spin_lock(&curr->lock);
      /* try */
        if(validate(pred, curr)) {
          if(curr->key==key) {
            return FALSE;
          }
          else {
            Entry_t entry=new_element(key);
            entry->next=curr;
            pred->next=entry;
            return TRUE;
          }
        }
      /* finally */
        pthread_spin_unlock(&curr->lock);
    /* finally */
      pthread_spin_unlock(&pred->lock);
  }
}

_Bool contains(int key, List_t* this) {
  Entry_t curr=this->head;
  while(curr->key<key) {
    curr=curr->next;
  }
  return curr->key==key && !curr->marked;
}

void* leftThread(void* arg)
{
  int i;
  for(i=0; i<ROUNDS; ++i) {
    if(nondet()) {
      add(nondet(), &this);
    }
    else {
      contains(nondet(), &this);
    }
  }
}

void* rightThread(void* arg)
{
  int i;
  for(i=0; i<ROUNDS; ++i) {
    if(nondet()) {
      remove(nondet(), &this);
    }
    else {
      contains(nondet(), &this);
    }
  }
}

int main ()
{
  pthread_t pt;
  init(&this);
  pthread_create(&pt, 0, leftThread, 0);
  rightThread(0);
  return 0;
}

