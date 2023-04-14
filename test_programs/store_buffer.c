#include <stdio.h>
#include <pthread.h>

int x = 0;  // shared variable
int y = 0;  // shared variable
int z = 0; // shared variable

void* thread1(void* arg) {
    x = 1;
//    __sync_synchronize();  // store barrier
    int r1 = y;
    int r3 = z;
    return NULL;
}

void* thread2(void* arg) {
    y = 1;
//    __sync_synchronize();  // load barrier
    int r2 = x;
    return NULL;
}

int main() {
//    int z = x;
    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    return 0;
}
