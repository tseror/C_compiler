
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

int main() {
  int x;
  int *p;
  p = &x;
  *p = 'A';
  putchar(x);
  putchar(*p);
}
