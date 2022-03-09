#!/usr/bin/env bash

function ctrlc {
  set +o errexit

  echo ""
  echo "cleanup..."
  for pid in "${pids[@]}"; do
    kill "${pid}"
  done

  echo "bye bye :)"
  exit 0
}

main() {

  set -o errexit
  set -o pipefail

  local -r __dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  local -r __filename="${__dirname}/$(basename "${BASH_SOURCE[0]}")"

  unset pids
  declare -Ag pids=()

  trap ctrlc SIGINT

  total_cpu="$(nproc)"
  upper=$((total_cpu-1))
  for i in $(seq 0 "${upper}"); do
    taskset --cpu-list "${i}" ./build/hook "${i}" 4000 &
    # echo "test "${i}"" &
    pids["${i}"]+=$!
  done

  while :
  do
    sleep 1
  done
}

main "$@"
