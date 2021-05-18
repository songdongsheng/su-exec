#!/bin/bash

GIT_ROOT=`dirname "$0"`
GIT_ROOT="$(cd -P -- "$GIT_ROOT/.." && pwd -P)"

TMP_SCRIPT=$(mktemp -p "${GIT_ROOT}/vendor")
function cleanup {
    rm -f "$TMP_SCRIPT"
    echo "done"
}
trap cleanup EXIT

chmod +x "$TMP_SCRIPT"
cat > "$TMP_SCRIPT" << EOF
#!/bin/bash

apt-get update; apt-get dist-upgrade -y
apt-get install -y --no-install-recommends gcc-aarch64-linux-gnu libc6-dev-arm64-cross

cd /opt/

aarch64-linux-gnu-gcc -std=gnu99 -Os -Wall -Wextra -pedantic -s -o su-exec-glibc-static-arm64 su-exec.c -static

du -ks su-exec-glibc-*-arm64
EOF

docker run --rm -it -e 'LC_ALL=en_US.UTF-8' -e 'TZ=Etc/UTC' \
    -v ${GIT_ROOT}:/opt ubuntu:14.04 /opt/vendor/`basename "${TMP_SCRIPT}"`
