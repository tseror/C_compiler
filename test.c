#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

int main() {
  int x;
  int *p;
  p = &x;
  x = 120;
  putchar(*p);
}
