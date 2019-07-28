#!/usr/bin/env sh
#
# SyncThing service

# import DroboApps framework functions
. /etc/service.subr

framework_version="2.1"
name="syncthing"
version="1.2.1"
description="Syncthing"
depends=""
webui=":8384/"

prog_dir="$(dirname "$(realpath "${0}")")"
data_dir="${prog_dir}/var"
daemon="${prog_dir}/app/syncthing"
tmp_dir="/tmp/DroboApps/${name}"
pidfile="${tmp_dir}/pid.txt"
logfile="${tmp_dir}/log.txt"
statusfile="${tmp_dir}/status.txt"
errorfile="${tmp_dir}/error.txt"

# backwards compatibility
if [ -z "${FRAMEWORK_VERSION:-}" ]; then
  framework_version="2.0"
  . "${prog_dir}/libexec/service.subr"
fi

start() {
  export HOME="${data_dir}"
  export STNODEFAULTFOLDER='true'
  start-stop-daemon -S -m -b -x "${daemon}" -p "${pidfile}" -- \
    -gui-address="0.0.0.0:8384" \
    -home "${data_dir}" \
    -logfile "${logfile}" \
    -logflags=3 \
    -no-browser
  rm -f "${errorfile}"
  echo "Syncthing is configured." >"${statusfile}"
}

# boilerplate
if [ ! -d "${tmp_dir}" ]; then mkdir -p "${tmp_dir}"; fi
exec 3>&1 4>&2 1>> "${logfile}" 2>&1
STDOUT=">&3"
STDERR=">&4"
echo "$(date +"%Y-%m-%d %H-%M-%S"):" "${0}" "${@}"
set -o errexit  # exit on uncaught error code
set -o nounset  # exit on unset variable
set -o pipefail # propagate last error code on pipe
set -o xtrace   # enable script tracing

main "${@}"
