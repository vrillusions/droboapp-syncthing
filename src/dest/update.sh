#!/usr/bin/env sh

prog_dir="$(dirname "$(realpath "${0}")")"
/bin/sh "${prog_dir}/service.sh" stop
