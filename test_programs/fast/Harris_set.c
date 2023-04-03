/* Even Better DCAS-Based Concurrent Deques
 * D. L. Detlefs, C. H. Flood, A. T. Gathwaite, 
 * P. A. Martin, N. N. Shavit, G. L. Steele Jr.
 * DISC'00
 */
#include <pthread.h>
#include <stdlib.h>

#ifndef CPROVER
#define __CPROVER_atomic_begin() 
#define __CPROVER_atomic_end()  
#define nondet() rand()%2
#endif

#define ROUNDS 10

#define FULL -3
#define EMPTY -2
#define OKAY -1

typedef struct _node_t {
  struct _node_t* R;
  struct _node_t* L;
  int V;
} node_t;

/* shared structures */
node_t Dummy={.R=&Dummy, .L=&Dummy, .V=0};
node_t* LeftHat=&Dummy;
node_t* RightHat=&Dummy;

node_t shared_nodes[ROUNDS];
size_t counter=0;

/* double CAS */
int inline DCAS(node_t** addr1, node_t** addr2, 
  node_t* old1, node_t* old2, node_t* new1, node_t* new2) 
{
  __CPROVER_atomic_begin();
  __asm__ __volatile__ ("mfence": : :"memory");
  int cond=(*addr1==old1 && *addr2==old2);
  if(cond) {
    *addr1=new1;
    *addr2=new2;
  }
  __asm__ __volatile__ ("mfence": : :"memory");
  return cond;
}

node_t* new_node() {
  if(counter<ROUNDS)
    return shared_nodes+counter++;
  else
    return NULL;
}

int pushRight(int v) {
  node_t* nd=new_node();
  if(nd==0)
    return FULL;
  nd->R=&Dummy;
  nd->V=v;
  while(1) {
    node_t* rh=RightHat;
    node_t* rhR=rh->R;
    if(rhR==rh) {
      nd->L=&Dummy;
      node_t* lh=LeftHat;
      if(DCAS(&RightHat, &LeftHat, rh, lh, nd, nd))
        return OKAY;
    }
    else {
      nd->L=rh;
      if(DCAS(&RightHat, &rh->R, rh, rhR, nd, nd))
        return OKAY;
    }
  }
} 

int popRight() {
  while(1) {
    node_t* rh=RightHat;
    node_t* lh=LeftHat;
    if(rh->R==rh)
      return EMPTY;
    if(rh==lh) {
      if(DCAS(&RightHat, &LeftHat, rh, lh, &Dummy, &Dummy))
        return rh->V;
    }
    else {
      node_t* rhL=rh->L;
      if(DCAS(&RightHat, &rh->L, rh, rhL, rhL, rh)) {
        int result=rh->V;
        rh->R=&Dummy;
        rh->V=0;
        return result;
      }
    }
  }
}

int pushLeft(int v) {
  node_t* nd=new_node();
  if(nd==NULL)
    return FULL;
  nd->L=&Dummy;
  nd->V=v;
  while(1) {
    node_t* lh=LeftHat;
    node_t* lhL=lh->L;
    if(lhL==lh) {
      nd->R=&Dummy;
      node_t* rh=RightHat;
      if(DCAS(&LeftHat, &RightHat, lh, rh, nd, nd))
        return OKAY;
    }
    else {
      nd->R=lh;
      if(DCAS(&LeftHat, &lh->L, lh, lhL, nd, nd))
        return OKAY;
    }
  }
}

int popLeft() {
  while(1) {
    node_t* lh=LeftHat;
    node_t* rh=RightHat;
    if(lh->L==lh)
      return EMPTY;
    if(lh==rh) {
      if(DCAS(&LeftHat, &RightHat, lh, rh, &Dummy, &Dummy))
        return lh->V;
    }
    else {
      node_t* lhR=lh->R;
      if(DCAS(&LeftHat, &lh->R, lh, lhR, lhR, lh)) {
        int result=lh->V;
        lh->L=&Dummy;
        lh->V=0;
        return result;
      }
    }
  }
}
 
void * leftThread(void * arg)
{
  int i;
  for(i=0; i<ROUNDS; ++i) {
    if(nondet()) {
      pushLeft(nondet());
    }
    else {
      popLeft();
    }
  }
}

void * rightThread(void * arg)
{
  int i;
  for(i=0; i<ROUNDS; ++i) {
    if(nondet()) {
      pushRight(nondet());
    }
    else {
      popRight();
    }
  }
}

int main ()
{
  //pthread_t pt;
  //pthread_create(&pt, 0, leftThread, 0);
  //rightThread(0);
  __CPROVER_ASYNC_0: leftThread(0);
  rightThread(0);
  return 0;
}

