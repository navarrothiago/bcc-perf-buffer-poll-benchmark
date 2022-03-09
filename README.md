Analysis of the BCC perf_poll API.

The goal is to stress the CPU by triggering the BPF program (kprobe) attached in the tcp connect (`tcpconnect-test`) or hook (`hook`) functions.


# Hook Application

Term1:

```
taskset --cpu-list <cpu-id> ./build/hook <cpu-id> <frequency>
```

Term2:

```
sudo ./hook_uprobe -s /usr/lib/libreadline.so --pid $(pgrep hook) --exepath /work/mantisnet/bcc-perf-buffer-poll-benchmark/build/hook
```

# TCP Connect

## Steps

> Make sure you have followed the [BCC installation guide](https://github.com/iovisor/bcc/blob/master/INSTALL.md).

Run the nginx:
```
docker run -d nginx
```

And just run the benchmark:

```
./run.sh 10 10
```

> arg1: the total of iterations. Each iteraction executes 500 curl.
> arg2: upper bound of wakeup_event. Starts with 1 and increase 10 for each interaction.

In the end, the program generates a report for each execution. The report will be located in the [reports](./reports/) folder.

## Manually

You can also execute manually the test with you want to have more control.

Term1:

```
sudo ./tcpconnect-test -w 1
```

> `w`: wakeup_events of the `perf_event_attr` API - https://man7.org/linux/man-pages/man2/perf_event_open.2.html.

Term2:

```
htop
```

Term3:

```
./test.sh 1 100
```
> In this case, arg1 is the target cpu and 100 is the total of iterations. Each iteraction execute 500 curl.
> This `test.sh` is based on https://github.com/weaveworks/scope/issues/2650#issuecomment-314788229

After the execution, press `Ctrl + C`

