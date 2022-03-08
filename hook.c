#include <stdint.h>
#include <stdio.h>

int hook(const char *data, uint32_t size) {
    printf("data: %s\n", data);
}

int main(int argc, char const *argv[])
{
  if(argc < 1){
    exit(1);
  }
  int cpu = atoi(argv[1]);
  const char *data = "12345";
  while(1) {
    hook(data, 6);
    sleep(1);
  }

  return 0;
}
