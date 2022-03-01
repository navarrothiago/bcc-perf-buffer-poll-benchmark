#!/usr/bin/env bash

send_curl() {
  sleep 3
  "${dirname}"/test.sh 0 $1 &>/dev/null
  sudo pkill -2 tcpconnect-test
}

run() {
  local it=$1
  local wakeup_events=$2

  send_curl $it &
  # echo -e "$(sudo "${dirname}"/tcpconnect-test -w $wakeup_events)" | grep perf_buffer_poll | tee "${dump_file}"
  echo -e "$(sudo "${dirname}"/tcpconnect-test -w $wakeup_events)" | tee -a "${dump_file}"
}

main() {

  set -o errexit
  set -o pipefail
  set -o nounset

  local dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local filename="${dirname}/$(basename "${BASH_SOURCE[0]}")"
  local now=$(date +"%Y-%m-%d_%H%M%S")

  local it=${1:-1}
  local wakeup_events=${2:-2}
  local dump_file="${dirname}/reports/"report-it"${it}"-wakeup"${wakeup_events}"-"${now}".dump

  #for ((i=1; i<=$it; i++)); do
  for ((w = 1; w <= $wakeup_events; w = w * 10)); do
    echo -e "Running i=$it and w=$w" | tee -a "${dump_file}"
    run $it $w
    echo "" | tee -a "${dump_file}"
    echo "" | tee -a "${dump_file}"
  done
  #done

  exit 0
}
main "$@"
