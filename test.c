
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

int main() {
  for (int n = 65; n < 91; n++) {
    putchar(n);
    if (n % 2 == 0) continue;
  }
  putchar(10);
}
