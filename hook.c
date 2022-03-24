#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

int hook(const char *data, uint32_t size) {
    //printf("data: %s\n", data);
}

int main(int argc, char const *argv[])
{
  if(argc <= 1){
    printf("Usage: taskset --cpu-list <cpu-id> %s <cpu-id> <frequency> \n\n", argv[0]);
    printf("Description: Call hook function with frequency.\nThe taskset is used to setup the binary affinity.\n", argv[0]);
    exit(1);
  }
  int cpu = atoi(argv[1]);
  uint64_t freq = atoi(argv[2]);
  unsigned int periodInMicroSeconds = 1000000/freq;
  printf("cpu: %d\tfreq: %d\tperiod: %d us\n", cpu, freq, periodInMicroSeconds);
  const char *data = "12345";

  while(1) {
    hook(data, 6);
    usleep(periodInMicroSeconds);
  }

  return 0;
}
