#include <stdio.h>
#include <pthread.h>

int x = 0;  // shared variable
int y = 0;  // shared variable

void* thread1(void* arg) {
    x = 1;
//    __sync_synchronize();  // store barrier
    y = 1;
    return NULL;
}

void* thread2(void* arg) {
    int r1 = y;
//    __sync_synchronize();  // load barrier
    int r2 = x;
    printf("r1 = %d, r2 = %d\n", r1, r2);
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
