
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

int f(int x, int y) {
  return x+y;
}

int main() {
  putchar(f('A', 2));
}
