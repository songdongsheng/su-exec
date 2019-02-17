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
+ If you use glibc distribution, e.g. CentOS/Debian/Ubuntu/RHEL Linux, use shared glibc version: su-exec-glibc-shared (7 KiB).

### Linux distribution and version support matrix

| Linux distribution | su-exec-glibc-shared (7 KiB)| su-exec-glibc-static (746 KiB) | su-exec-musl-shared (10 KiB) | su-exec-musl-static (38 KiB) |
| ------------------ | -------------------- | -------------------- | ------------------- | ------------------- |
| alpine:3.2         | XX                   | XX                   | OK                  | OK                  |
| alpine:3.3         | XX                   | XX                   | OK                  | OK                  |
| alpine:3.4         | XX                   | XX                   | OK                  | OK                  |
| alpine:3.5         | XX                   | XX                   | OK                  | OK                  |
| alpine:3.6         | XX                   | XX                   | OK                  | OK                  |
| alpine:3.7         | XX                   | XX                   | OK                  | OK                  |
| alpine:3.8         | XX                   | XX                   | OK                  | OK                  |
| alpine:3.9         | XX                   | XX                   | OK                  | OK                  |
| centos:5           | OK                   | XX                   | XX                  | OK                  |
| centos:6           | OK                   | OK                   | XX                  | OK                  |
| centos:7           | OK                   | OK                   | XX                  | OK                  |
| debian:6           | OK                   | OK                   | XX                  | OK                  |
| debian:7-slim      | OK                   | OK                   | XX                  | OK                  |
| debian:8-slim      | OK                   | OK                   | XX                  | OK                  |
| debian:9-slim      | OK                   | OK                   | XX                  | OK                  |
| debian:buster-slim | OK                   | OK                   | XX                  | OK                  |
| ubuntu:10.04       | OK                   | OK                   | XX                  | OK                  |
| ubuntu:12.04       | OK                   | OK                   | XX                  | OK                  |
| ubuntu:14.04       | OK                   | OK                   | XX                  | OK                  |
| ubuntu:16.04       | OK                   | OK                   | XX                  | OK                  |
| ubuntu:18.04       | OK                   | OK                   | XX                  | OK                  |

## Download

### Binary file size

``` shell
# touch -d "1970-01-01 00:00:00" su-exec-*

# ls -la su-exec-*
-rwxr-xr-x 1 dongsheng dongsheng   6912 Jan  1  1970 su-exec-glibc-shared
-rwxr-xr-x 1 dongsheng dongsheng 763616 Jan  1  1970 su-exec-glibc-static
-rwxr-xr-x 1 dongsheng dongsheng   9880 Jan  1  1970 su-exec-musl-shared
-rwxr-xr-x 1 dongsheng dongsheng  38648 Jan  1  1970 su-exec-musl-static
```

### Binary file signature

```
Primary key fingerprint: 3DA8 ECBB 5757 2D64 9F3C  0811 0401 AA20 46D3 97FF
     Subkey fingerprint: 4073 E993 3572 FC25 1915  5A19 D256 8959 D1DA A566

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

SHA256 (su-exec-glibc-shared) = 3f365c3d162ac2b8d343b8674c674bb5dc31a4eb968647910a25edb177638de9
SHA256 (su-exec-glibc-static) = 5cf255f38092c3f7ba3b89f4840825c9f07ae778cb27ec83ba2d66a4c04b0b12
SHA256 (su-exec-musl-shared) = ed6e097a0122d4027238c6927f634b5ac13691c3116ed693cfb7b982b41a48e6
SHA256 (su-exec-musl-static) = 79dd71246b7a6aa1867df1ac0ccde9b9771995fa2bd86e74a0e110244512e67f
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEQHPpkzVy/CUZFVoZ0laJWdHapWYFAlxoKXgACgkQ0laJWdHa
pWa82gf/QzjTzcToMr7U2UNxt3C8C9m0DEar4Y53XuqWyxUF2lNfNwDxMszHxeag
Mm9eWephbyGayy+5si31t59nVE/KVNzse6RT4wBVKt0HakySvWTxR+0EtCER8gjD
3htjWUtlCI7HORq4TyyMPYUpxf7Xu5CcZWcfK5N2Deeo8QuTFk7F4qMzJ+VHfNFr
YAC8hMyHFtah1GWVrTNiWiiaCcrSwvWSQqVIXxKqW7BdbLUDQTF5AbFXtMeJO955
HlZdO114KQ9uQVqcXJxmzbHgGemunPPoUSp3Lap9O8xi1azj8IHvsqfIHbBxfSBd
ZscIeQm8yMGiInLsLZCOtYraB+E21Q==
=X9yf
-----END PGP SIGNATURE-----
```

### Download from GitHub

+ [su-exec-1.2.tar.gz](https://github.com/songdongsheng/su-exec/releases/download/1.2/su-exec-1.2.tar.gz)
+ [su-exec-1.2.tar.gz.asc](https://github.com/songdongsheng/su-exec/releases/download/1.2/su-exec-1.2.tar.gz.asc)
+ [su-exec-glibc-shared](https://github.com/songdongsheng/su-exec/releases/download/1.2/su-exec-glibc-shared)
+ [su-exec-glibc-static](https://github.com/songdongsheng/su-exec/releases/download/1.2/su-exec-glibc-static)
+ [su-exec-musl-shared](https://github.com/songdongsheng/su-exec/releases/download/1.2/su-exec-musl-shared)
+ [su-exec-musl-static](https://github.com/songdongsheng/su-exec/releases/download/1.2/su-exec-musl-static)

### Download from IPFS

```shell
ipfs get -o su-exec-glibc-shared QmXfKbr1qDvvoEVd3mksRrbnVQsawMPxNq22GQNTDCBzTa
ipfs get -o su-exec-glibc-static QmcAkDw6iEg3ktXWkYWiHj8tJqnGaFWBSA8dgPTkj2uDnX
ipfs get -o su-exec-musl-shared  QmdEvCUAUnnaTD4ffwDuanS43FPZZgoCF55DtBgpuoqFQR
ipfs get -o su-exec-musl-static  QmbB7MKHgsx2ZPSmnJJAiu4qDB19v5TtZPhYcfVZydG8Mk
```

### Download from IPFS gateway

#### cloudflare-ipfs.com

```shell
curl -o su-exec-glibc-shared https://cloudflare-ipfs.com/ipfs/QmXfKbr1qDvvoEVd3mksRrbnVQsawMPxNq22GQNTDCBzTa
curl -o su-exec-glibc-static https://cloudflare-ipfs.com/ipfs/QmcAkDw6iEg3ktXWkYWiHj8tJqnGaFWBSA8dgPTkj2uDnX
curl -o su-exec-musl-shared  https://cloudflare-ipfs.com/ipfs/QmdEvCUAUnnaTD4ffwDuanS43FPZZgoCF55DtBgpuoqFQR
curl -o su-exec-musl-static  https://cloudflare-ipfs.com/ipfs/QmbB7MKHgsx2ZPSmnJJAiu4qDB19v5TtZPhYcfVZydG8Mk
```

#### ipfs.io

```shell
curl -o su-exec-glibc-shared https://ipfs.io/ipfs/QmXfKbr1qDvvoEVd3mksRrbnVQsawMPxNq22GQNTDCBzTa
curl -o su-exec-glibc-static https://ipfs.io/ipfs/QmcAkDw6iEg3ktXWkYWiHj8tJqnGaFWBSA8dgPTkj2uDnX
curl -o su-exec-musl-shared  https://ipfs.io/ipfs/QmdEvCUAUnnaTD4ffwDuanS43FPZZgoCF55DtBgpuoqFQR
curl -o su-exec-musl-static  https://ipfs.io/ipfs/QmbB7MKHgsx2ZPSmnJJAiu4qDB19v5TtZPhYcfVZydG8Mk
```
