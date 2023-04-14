#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

int x = 0;  // shared variable
int y = 0;  // shared variable
int z = 0;  // shared variable

void* thread1(void* arg) {
    int r1;
    x = 3;
    for(int i = 0; i < 10; i++) {
        r1 += z;
    }
    return NULL;
}

void* thread2(void* arg) {
    int r2, r3, r4;
    r2 = y;
    r3 = z;
    r4  = x;
    return NULL;
}

int main() {
    pthread_t t1, t2;
    pthread_create(&t1, NULL, thread1, NULL);
    pthread_create(&t2, NULL, thread2, NULL);
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    return 0;
}
