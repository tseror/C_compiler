
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

int main() {
  int *p;
  p = malloc(5 * sizeof(int));
  p[0] = 1000;
}
