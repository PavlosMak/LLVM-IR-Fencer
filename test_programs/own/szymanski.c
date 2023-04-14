/**
Szymanski’s mutex algorithm.
Adapted from the "classic" benchmarks by Algalve et.al 2017.
**/

#include <stdio.h>
#include <pthread.h>

int flag1 = 0, flag2 = 0; // (shared) N integer flags

void* thr1(void * arg) {
  while (1) {
    flag1 = 1;
    flag1 = 3;
    if (flag2 == 1) {
      flag1 = 2;
    }
    flag1 = 4;
    flag1 = 0;
  }
  return NULL;
}

void* thr2(void * arg) {
  while (1) {
    flag2 = 1;
    flag2 = 3;
    if (flag1 == 1) {
      flag2 = 2;
    }
    flag2 = 4;
    flag2 = 0;
  }
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
