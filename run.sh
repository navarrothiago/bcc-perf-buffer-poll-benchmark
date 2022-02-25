#!/usr/bin/env bash

send_curl(){
  sleep 2
  "${dirname}"/test.sh 0 $1 &> /dev/null
  sudo pkill -2 tcpconnect-test
}

run(){
  local it=$1
  local wakeup_events=$2

  send_curl $it &
  sudo "${dirname}"/tcpconnect-test -w $wakeup_events | grep perf_buffer_poll
}

main() {

  set -o errexit
  set -o pipefail
  set -o nounset

  local -r dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local -r filename="${dirname}/$(basename "${BASH_SOURCE[0]}")"

  local it=${1:-1}
  local wakeup_events=${2:-2}

  #for ((i=1; i<=$it; i++)); do
      for ((w=1; w<$wakeup_events; w++)); do
          echo "Running i=$it and w=$w"
          run $it $w
          echo ""
      done
  #done


  exit 0
}
main "$@"
