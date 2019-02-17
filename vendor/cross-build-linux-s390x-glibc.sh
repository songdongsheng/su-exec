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
apt-get install -y --no-install-recommends gcc-s390x-linux-gnu libc6-dev-s390x-cross

cd /opt/

s390x-linux-gnu-gcc -std=gnu99 -Os -Wall -Wextra -pedantic -s -o su-exec-glibc-static-s390x su-exec.c -static
s390x-linux-gnu-gcc -std=gnu99 -Os -Wall -Wextra -pedantic -s -o su-exec-glibc-shared-s390x su-exec.c

du -ks su-exec-glibc-*-s390x
EOF

docker run --rm -it -e 'LC_ALL=en_US.UTF-8' -e 'TZ=Asia/Shanghai' \
    -v ${GIT_ROOT}:/opt ubuntu:16.04 /opt/vendor/`basename "${TMP_SCRIPT}"`
