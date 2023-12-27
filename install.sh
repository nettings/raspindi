#!/usr/bin/env sh

INSTALL_DIR="/opt/raspindi"
BIN_DIR="$INSTALL_DIR/bin"
LIB_DIR="$INSTALL_DIR/lib"

mkdir "$INSTALL_DIR"
mkdir "$LIB_DIR"
mkdir "$BIN_DIR"

if [ -d "lib-$(uname -m)" ]; then
  cp lib-$(uname -m)/ndi/* "$LIB_DIR"
else
  cp lib-armv7/ndi/* "$LIB_DIR"
fi

cp build/src/raspindi "$BIN_DIR"
cp build/src/libndioutput.so "$LIB_DIR"

if [ ! -e /etc/raspindi.conf ]; then
  cp etc/raspindi.conf.default /etc/raspindi.conf
fi

echo '#!/usr/bin/env sh
LD_LIBRARY_PATH="/opt/raspindi/lib" /opt/raspindi/bin/raspindi
' > "$INSTALL_DIR/raspindi.sh"
chmod +x "$INSTALL_DIR/raspindi.sh"
