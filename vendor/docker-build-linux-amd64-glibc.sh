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

cat > /etc/apt/apt.conf.d/zz-90-check-valid-until << EOF2
Acquire::Check-Valid-Until "false";
EOF2

cat > /etc/apt/sources.list << EOF2
deb http://archive.debian.org/debian squeeze main
deb http://archive.debian.org/debian squeeze-lts main
EOF2

apt-get update; apt-get dist-upgrade -y
apt-get install -y --force-yes --no-install-recommends gcc libc6-dev

cd /opt/

# warning: static version need seperate strip step due to gcc bug: unexpected reloc type in static binarySegmentation fault
gcc -std=gnu99 -Os -Wall -Wextra -pedantic -o su-exec-glibc-static su-exec.c -static
strip su-exec-glibc-static

gcc -std=gnu99 -Os -Wall -Wextra -pedantic -s -o su-exec-glibc-shared su-exec.c

du -ks su-exec-glibc-*
EOF

docker run --rm -it -e 'LC_ALL=en_US.UTF-8' -e 'TZ=Asia/Shanghai' \
    -v ${GIT_ROOT}:/opt debian:6 /opt/vendor/`basename "${TMP_SCRIPT}"`
