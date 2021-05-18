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
#!/bin/sh

apk update && apk upgrade
apk add gcc musl-dev

cd /opt/

gcc -std=gnu99 -Os -Wall -Wextra -pedantic -s -o su-exec-musl-static su-exec.c -static

du -ks su-exec-musl-*
EOF

docker run --rm -it -e 'LC_ALL=en_US.UTF-8' -e 'TZ=Etc/UTC' \
    -v ${GIT_ROOT}:/opt alpine:3.2 /opt/vendor/`basename "${TMP_SCRIPT}"`
