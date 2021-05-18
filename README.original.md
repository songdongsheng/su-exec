# su-exec

switch user and group, then exec.

[`su-exec`](https://github.com/songdongsheng/su-exec) is a very minimal re-write of
[`gosu`](https://github.com/tianon/gosu) in C, making for a much smaller binary.

## Purpose

This is a simple tool that will simply execute a program with different
privileges. The program will be executed directly and not run as a child,
like su and sudo does, which avoids TTY and signal issues.

Notice that su-exec depends on being **run by the root user**, non-root
users do not have permission to change uid/gid.

## Usage

```shell
su-exec user-spec command [ arguments... ]
```

`user-spec` is either a user name (e.g. `nobody`) or user name and group
name separated with colon (e.g. `ftp:ftp`). Numeric uid/gid values
can be used instead of names.

```shell
su-exec nginx:122 /usr/sbin/nginx -c /etc/nginx/nginx.conf
```

## Why reinvent gosu/su-exec ?

This does more or less exactly the same thing as [gosu](https://github.com/tianon/gosu)
but it is only 38 KB (7 KB for shared version) instead of 2.2 MB.
In particular, the simple C program has a smaller attack plane.

The [`ncopa's su-exec`](https://github.com/ncopa/su-exec) have critical bugs (or features),
it will **use root permission silently** if invalid user-spec given !

## Linux distribution compatibility

### Summary

+ The easiest way is to keep using the static musl version: su-exec-musl-static (38 KiB).
+ If you use musl distribution, e.g. Alpine Linux, use shared musl version: su-exec-musl-shared (10 KiB).
+ If you use glibc distribution, e.g. SUSE/Debian/Ubuntu/RHEL/CentOS Linux, use shared glibc version: su-exec-glibc-shared (7 KiB).

### Linux distribution and version support matrix

| Linux distribution | su-exec-glibc-shared (7 KiB)| su-exec-glibc-static (659 KiB) | su-exec-musl-shared (10 KiB) | su-exec-musl-static (38 KiB) |
| ------------------ | -------------------- | -------------------- | ------------------- | ------------------- |
| alpine:3.2         | XX                   | XX                   | OK                  | OK                  |
| alpine:3.3         | XX                   | XX                   | OK                  | OK                  |
| alpine:3.4         | XX                   | XX                   | OK                  | OK                  |
| alpine:3.5         | XX                   | XX                   | OK                  | OK                  |
| alpine:3.6         | XX                   | XX                   | OK                  | OK                  |
| alpine:3.7         | XX                   | XX                   | OK                  | OK                  |
| alpine:3.8         | XX                   | XX                   | OK                  | OK                  |
| alpine:3.9         | XX                   | XX                   | OK                  | OK                  |
| alpine:3.10        | XX                   | XX                   | OK                  | OK                  |
| alpine:3.11        | XX                   | XX                   | OK                  | OK                  |
| centos:5           | OK                   | XX                   | XX                  | OK                  |
| centos:6           | OK                   | OK                   | XX                  | OK                  |
| centos:7           | OK                   | OK                   | XX                  | OK                  |
| debian:6           | OK                   | OK                   | XX                  | OK                  |
| debian:7           | OK                   | OK                   | XX                  | OK                  |
| debian:8           | OK                   | OK                   | XX                  | OK                  |
| debian:9           | OK                   | OK                   | XX                  | OK                  |
| debian:10          | OK                   | OK                   | XX                  | OK                  |
| ubuntu:10.04       | OK                   | OK                   | XX                  | OK                  |
| ubuntu:12.04       | OK                   | OK                   | XX                  | OK                  |
| ubuntu:14.04       | OK                   | OK                   | XX                  | OK                  |
| ubuntu:16.04       | OK                   | OK                   | XX                  | OK                  |
| ubuntu:18.04       | OK                   | OK                   | XX                  | OK                  |
| ubuntu:20.04       | OK                   | OK                   | XX                  | OK                  |
| rhel6              | OK                   | OK                   | XX                  | OK                  |
| rhel7 or ubi7      | OK                   | OK                   | XX                  | OK                  |
| RHEL 8 (ubi8)      | OK                   | OK                   | XX                  | OK                  |
| sles12sp5          | OK                   | OK                   | XX                  | OK                  |
| sle15:15.1         | OK                   | OK                   | XX                  | OK                  |

## Download

### Binary file size

``` shell
# touch -d "1970-01-01 00:00:00" su-exec-{glibc,musl}-{shared,static}

# ls -l su-exec-{glibc,musl}-{shared,static}
-rwxr-xr-x 1 dongsheng dongsheng   7008 Jan  1  1970 su-exec-glibc-shared
-rwxr-xr-x 1 dongsheng dongsheng 673880 Jan  1  1970 su-exec-glibc-static
-rwxr-xr-x 1 dongsheng dongsheng   9880 Jan  1  1970 su-exec-musl-shared
-rwxr-xr-x 1 dongsheng dongsheng  38328 Jan  1  1970 su-exec-musl-static
```

### Binary file signature

```
Primary key fingerprint: 3DA8 ECBB 5757 2D64 9F3C  0811 0401 AA20 46D3 97FF
     Subkey fingerprint: 4073 E993 3572 FC25 1915  5A19 D256 8959 D1DA A566

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

SHA256 (su-exec-glibc-shared) = 0c1db1bfb7fbe5aa0b8ffb6e659a6a0d59a975811ebf405549bd7014e2593b21
SHA256 (su-exec-glibc-static) = 1e3b00833d5ef00758561a7120156c95ba7e3f4d570ac6279cd9b9a41a6898e0
SHA256 (su-exec-musl-shared) = 91940f8abfe758574dc5db6754e686210ad6154e78d8e367447dbf60c4613f42
SHA256 (su-exec-musl-static) = 958c060156cea98caeab5d6c63e5aecc870ab0aa93b7b72712f33ab398c605eb
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEQHPpkzVy/CUZFVoZ0laJWdHapWYFAlxqLr8ACgkQ0laJWdHa
pWbdtwgAkqxTbOLbDAHjGwc21vPbaTXpctgVGCA1TCPOQJwJIvI2A1JvcBURbBCY
l44v4g/C1iq5XAxNE1hfnyKZkmV4+cNNsE5E8rMLiN1sVSzqgaIrRsBHCrTWYylB
sROOIbvSIPM80QoYwq1WHxs7ixO3e1xbWRMUNWbZb4zY1uvDvf1ctOW6P8OSwsH9
6C9GdHCxUzyZ2X5oLldkceWnO7nQ2BAZZT3Syx4KY39SH20eXyv/Fn0tz/OrG+AY
LPqsU9aCUQSfLYKxGhK/MaoYOxJnNAxkVEYi4zucT4NuWKkbGkuNKZykdHx/1+fi
RmTv4PO/2TqrRQkvIaDUBiVNK9yXpw==
=2RqZ
-----END PGP SIGNATURE-----
```

### Download from GitHub

+ [su-exec-1.3.tar.gz](https://github.com/songdongsheng/su-exec/releases/download/1.3/su-exec-1.3.tar.gz)
+ [su-exec-1.3.tar.gz.asc](https://github.com/songdongsheng/su-exec/releases/download/1.3/su-exec-1.3.tar.gz.asc)
+ [su-exec-glibc-shared](https://github.com/songdongsheng/su-exec/releases/download/1.3/su-exec-glibc-shared)
+ [su-exec-glibc-static](https://github.com/songdongsheng/su-exec/releases/download/1.3/su-exec-glibc-static)
+ [su-exec-musl-shared](https://github.com/songdongsheng/su-exec/releases/download/1.3/su-exec-musl-shared)
+ [su-exec-musl-static](https://github.com/songdongsheng/su-exec/releases/download/1.3/su-exec-musl-static)

### Download from IPFS

```shell
ipfs get -o su-exec-glibc-shared QmbZg6fdbZzDyb4GgLBUD2qrHyYuhHL1qyxG1Dc2WgTydK
ipfs get -o su-exec-glibc-static QmNifPZSx4sVErXLjVwRhvC5TuqguaJbQLv4cBMU2epNTW
ipfs get -o su-exec-musl-shared  QmaycfnnaFr5GXP7xabQYmfqWfbo6faGYu3kKjrWXyhTnx
ipfs get -o su-exec-musl-static  QmXqdbCyW7w4arHKCW1hGmrJUL6hy8Lw4PKaH5Crq9ta6Y

chmod +x su-exec-{glibc,musl}-{shared,static}
```

### Download from IPFS gateway

#### cloudflare-ipfs.com

```shell
curl -o su-exec-glibc-shared https://cloudflare-ipfs.com/ipfs/QmbZg6fdbZzDyb4GgLBUD2qrHyYuhHL1qyxG1Dc2WgTydK
curl -o su-exec-glibc-static https://cloudflare-ipfs.com/ipfs/QmNifPZSx4sVErXLjVwRhvC5TuqguaJbQLv4cBMU2epNTW
curl -o su-exec-musl-shared  https://cloudflare-ipfs.com/ipfs/QmaycfnnaFr5GXP7xabQYmfqWfbo6faGYu3kKjrWXyhTnx
curl -o su-exec-musl-static  https://cloudflare-ipfs.com/ipfs/QmXqdbCyW7w4arHKCW1hGmrJUL6hy8Lw4PKaH5Crq9ta6Y

chmod +x su-exec-{glibc,musl}-{shared,static}
```

#### ipfs.io

```shell
curl -o su-exec-glibc-shared https://ipfs.io/ipfs/QmbZg6fdbZzDyb4GgLBUD2qrHyYuhHL1qyxG1Dc2WgTydK
curl -o su-exec-glibc-static https://ipfs.io/ipfs/QmNifPZSx4sVErXLjVwRhvC5TuqguaJbQLv4cBMU2epNTW
curl -o su-exec-musl-shared  https://ipfs.io/ipfs/QmaycfnnaFr5GXP7xabQYmfqWfbo6faGYu3kKjrWXyhTnx
curl -o su-exec-musl-static  https://ipfs.io/ipfs/QmXqdbCyW7w4arHKCW1hGmrJUL6hy8Lw4PKaH5Crq9ta6Y

chmod +x su-exec-{glibc,musl}-{shared,static}
```
