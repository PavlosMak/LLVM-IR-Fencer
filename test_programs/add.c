int globvar = 12;

int add(int a) {
    return globvar + a;
}

int main() {
    add(13);
    int b = add(12);
    return b;
}

int factorial(int n) {
    if (n == 0)
        return 1;
    return n*factorial(n-1);
}