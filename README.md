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
$ su-exec nginx:122 /usr/sbin/nginx -c /etc/nginx/nginx.conf
```

## Why reinvent gosu/su-exec ?

This does more or less exactly the same thing as [gosu](https://github.com/tianon/gosu)
but it is only 40KB (7KB for shared version) instead of 2.2MB.
In particular, the simple C program has a smaller attack plane.

The [`ncopa's su-exec`](https://github.com/ncopa/su-exec) have critical bugs (or features),
it will **use root permission silently** if invalid user-spec given !

# Download from IPFS (InterPlanetary File System)
## IPFS hash
```
# touch -d "1970-01-01 00:00:00" su-exec-*

# ls -la su-exec-*
-rwxr-xr-x 1 dongsheng dongsheng   6960 Jan  1  1970 su-exec-glibc-shared
-rwxr-xr-x 1 dongsheng dongsheng 609376 Jan  1  1970 su-exec-glibc-static
-rwxr-xr-x 1 dongsheng dongsheng   9880 Jan  1  1970 su-exec-musl-shared
-rwxr-xr-x 1 dongsheng dongsheng  38648 Jan  1  1970 su-exec-musl-static

# ipfs add su-exec-shared su-exec-static
added QmWcck5mQqbzcEx8mM6bdDestYwqiwsXkCVa97odggk9Vy su-exec-glibc-shared
added QmX3bzvCM3cxFFWGGMhQnMV214HLzyFceD6Vyf2aRYW7NB su-exec-glibc-static
added QmdEvCUAUnnaTD4ffwDuanS43FPZZgoCF55DtBgpuoqFQR su-exec-musl-shared
added QmbB7MKHgsx2ZPSmnJJAiu4qDB19v5TtZPhYcfVZydG8Mk su-exec-musl-static
```
## GnuPG / OpenPGP sign
```
Primary key fingerprint: 3DA8 ECBB 5757 2D64 9F3C  0811 0401 AA20 46D3 97FF
     Subkey fingerprint: 4073 E993 3572 FC25 1915  5A19 D256 8959 D1DA A566

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

SHA256 (su-exec-glibc-shared) = fed1ba22bb0e5b933efb25f2f9e57e7b3069715423ef693a162d9a01bcb040d7
SHA256 (su-exec-glibc-static) = 59382e38117fc5c001b7d716e53f376cffa50de63c218c03bd213bce4bca5f73
SHA256 (su-exec-musl-shared) = ed6e097a0122d4027238c6927f634b5ac13691c3116ed693cfb7b982b41a48e6
SHA256 (su-exec-musl-static) = 79dd71246b7a6aa1867df1ac0ccde9b9771995fa2bd86e74a0e110244512e67f
-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEQHPpkzVy/CUZFVoZ0laJWdHapWYFAlxmrUQACgkQ0laJWdHa
pWaDMAgAuQQ05YcSotSnSkiq7k58gCJX/CGd1LV8bkajfGvyhAqD3YQuaB2/IS2o
QjKqSOKnxj7JLde9/O2elnEHhRgs8u6U2a8yK0NcpY8QgOdglMhydiz4CrXBVe9Q
XdYpHwVZalAnfpSFxq7x3JtQkpeXEteL/8mMBtandc24CVoWkr+A0RjdAzkMOm+l
vd4htpnn1ZspoUHLUSt5WtXbHtXRHC230Zh+h3sw2rig7+1c6hf/aELz+Z5MYKEN
rf1w0X5otySN+yINBp21PquM1vXw0KxVj/rGkBeY0Y+mKOkToNYRsiKqDubmtKL0
Bqm4QcWjSnZxitwI1MLZUO0a2Do1ag==
=/Qr+
-----END PGP SIGNATURE-----
```

## Download from IPFS
```
ipfs get -o su-exec-glibc-shared QmWcck5mQqbzcEx8mM6bdDestYwqiwsXkCVa97odggk9Vy
ipfs get -o su-exec-glibc-static QmX3bzvCM3cxFFWGGMhQnMV214HLzyFceD6Vyf2aRYW7NB
ipfs get -o su-exec-musl-shared  QmdEvCUAUnnaTD4ffwDuanS43FPZZgoCF55DtBgpuoqFQR
ipfs get -o su-exec-musl-static  QmbB7MKHgsx2ZPSmnJJAiu4qDB19v5TtZPhYcfVZydG8Mk
```

## Download from IPFS gateway
### cloudflare-ipfs.com
```
curl -o su-exec-glibc-shared https://cloudflare-ipfs.com/ipfs/QmWcck5mQqbzcEx8mM6bdDestYwqiwsXkCVa97odggk9Vy
curl -o su-exec-glibc-static https://cloudflare-ipfs.com/ipfs/QmX3bzvCM3cxFFWGGMhQnMV214HLzyFceD6Vyf2aRYW7NB
curl -o su-exec-musl-shared  https://cloudflare-ipfs.com/ipfs/QmdEvCUAUnnaTD4ffwDuanS43FPZZgoCF55DtBgpuoqFQR
curl -o su-exec-musl-static  https://cloudflare-ipfs.com/ipfs/QmbB7MKHgsx2ZPSmnJJAiu4qDB19v5TtZPhYcfVZydG8Mk
```
