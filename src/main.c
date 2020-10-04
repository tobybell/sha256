#include <sha256/sha256.h>

#include <unistd.h>

unsigned char buf[4096];

int main(int argc, const char* argv[]) {
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
