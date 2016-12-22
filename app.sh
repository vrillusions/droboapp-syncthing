
### syncthing ###
_build_syncthing() {
local VERSION="0.14.16"
local FOLDER="syncthing-linux-arm-v${VERSION}"
local FILE="${FOLDER}.tar.gz"
local URL="https://github.com/syncthing/syncthing/releases/download/v${VERSION}/${FILE}"

_download_tgz "${FILE}" "${URL}" "${FOLDER}"
pushd "target/${FOLDER}"
mkdir -vp "${DEST}/app"
mv -v ./* "${DEST}/app/"
popd
}

### BUILD ###
_build() {
  _build_syncthing
  _package
}
