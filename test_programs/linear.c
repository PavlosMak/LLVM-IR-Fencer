#include <stdio.h>
#include <pthread.h>

int x = 0;  // shared variable

int main() {
    int temp = x;

    x = 3;
    return 0;
}