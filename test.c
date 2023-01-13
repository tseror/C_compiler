
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

void f(int x) {
  putchar(x);
}

int main() {
  f('A');
  putchar(10);
}
