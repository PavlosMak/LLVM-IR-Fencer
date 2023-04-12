#include <stdio.h>
#include <pthread.h>

int x = 0;  // shared variable

int add_five() {
    x += 5;
    return 0;
}

int main() {
    int temp = x;

    x = 3;
    add_five();
    x -= 2;
    return 0;
}