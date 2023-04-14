/**
Peterson's mutex algorithm.
Adapted from the "classic" benchmarks by Algalve et.al 2017.
**/

#include <stdio.h>
#include <pthread.h>


int turn; // integer variable to hold the ID of the thread whose turn is it
int flag1 = 0, flag2 = 0; // boolean flags

void* thr1(void * arg) { // frontend produces 12 transitions from this thread. It would be better if it would produce only 8!
  flag1 = 1;
  turn = 1;
  do {} while (flag2==1 && turn==1);
  // begin: critical section
  // end: critical section
  flag1 = 0;
  return NULL;
}

void* thr2(void * arg) {
  flag2 = 1;
  turn = 0;
  do {} while (flag1==1 && turn==0);
  // begin: critical section
  // end: critical section
  flag2 = 0;
  return NULL;
}
  
int main()
{
    pthread_t t1, t2;
    pthread_create(&t1, NULL, thr1, 0);
    pthread_create(&t2, NULL, thr2, 0);
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
}
