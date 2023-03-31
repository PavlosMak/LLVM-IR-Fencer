int globvar = 12;

int add(int a) {
    return globvar + a;
}

int main() {
    int b = add(12);
    return b;
}
