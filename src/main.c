#include <sha256/sha256.h>

#include <stdio.h>
#include <string.h>
#include <unistd.h>

unsigned char buf[4096];

int help() {
  printf(
    "Usage: sha256 [OPTIONS]\n\n"
    "Compute the SHA 256 digest of a message.\n\n"
    "The message will be read from standard input, and the binary\n"
    "digest will be written to standard output.\n\n"
    "Options:\n"
    "  --help / -h  Show this message and exit\n");
  return 0;
}

int usage() {
  printf(
    "Usage: sha256 [OPTIONS]\n"
    "See 'sha256 --help'.\n");
  return 1;
}

int hash() {
  sha256_ctx c;
  sha256_init(&c);
  while (1) {
    int n = read(STDIN_FILENO, buf, sizeof (buf));
    if (!n) break;
    sha256_update(&c, buf, n);
  }
  sha256_digest d;
  sha256_final(&d, &c);
  write(STDOUT_FILENO, &d, sizeof (d));
  return 0;
}

int main(int argc, const char* argv[]) {
  if (argc > 2) {
    return usage();
  }
  if (argc > 1 && (!strcmp(argv[1], "--help") || !strcmp(argv[1], "-h"))) {
    return help();
  }
  if (argc > 1) {
    return usage();
  }
  return hash();
}
