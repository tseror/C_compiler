#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

int main() {
  putchar(65 + (1 && 2)); // 66, pas 67 !
}
