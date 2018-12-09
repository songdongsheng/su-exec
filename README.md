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
but it is only 0.6MB (7KB for shared version) instead of 2.2MB.
In particular, the simple C program has a smaller attack plane.

The [`ncopa's su-exec`](https://github.com/ncopa/su-exec) have critical bugs (or features),
it will **use root permission silently** if given invalid user-spec !

# Download from IPFS (InterPlanetary File System)
## IPFS hash
```
# touch -d "1970-01-01 00:00:00" su-exec-shared su-exec-static

# ls -la su-exec-shared su-exec-static
-rwxr-xr-x 1 root root   6960 Jan  1  1970 su-exec-shared
-rwxr-xr-x 1 root root 609376 Jan  1  1970 su-exec-static

# ipfs add su-exec-shared su-exec-static
added QmWcck5mQqbzcEx8mM6bdDestYwqiwsXkCVa97odggk9Vy su-exec-shared
added QmX3bzvCM3cxFFWGGMhQnMV214HLzyFceD6Vyf2aRYW7NB su-exec-static
```

## Download from IPFS
```
# ipfs get -o su-exec-shared QmWcck5mQqbzcEx8mM6bdDestYwqiwsXkCVa97odggk9Vy
# ipfs get -o su-exec-static QmX3bzvCM3cxFFWGGMhQnMV214HLzyFceD6Vyf2aRYW7NB
```

## Download from IPFS gateway
### cloudflare-ipfs.com
```
curl -o su-exec-shared https://cloudflare-ipfs.com/ipfs/QmWcck5mQqbzcEx8mM6bdDestYwqiwsXkCVa97odggk9Vy
curl -o su-exec-static https://cloudflare-ipfs.com/ipfs/QmX3bzvCM3cxFFWGGMhQnMV214HLzyFceD6Vyf2aRYW7NB
```
