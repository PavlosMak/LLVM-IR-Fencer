/**
Lamport's fast mutex algorithm.
Adapted from the "classic" benchmarks by Algalve et.al 2017.
**/
#include <stdio.h>
#include <pthread.h>

int x;
int y;
int b1, b2; // N boolean flags

void* thr1(void * arg) {
  L0:
    b1 = 1;
    x = 1;
    if (y != 0) {
      b1 = 0;
      goto L0;
    }
    y = 1;
    if (x != 1) {
      b1 = 0;
      if (y != 1) {
	goto L0;
      }
    }
  y = 0;
  b1 = 0;
  return NULL;
}

void* thr2(void * arg) {
  L1:
    b2 = 1;
    x = 2;
    if (y != 0) {
      b2 = 0;
      goto L1;
    }
    y = 2;
    if (x != 2) {
      b2 = 0;
      if (y != 2) {
	goto L1;
      }
    }
  y = 0;
  b2 = 0;
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
