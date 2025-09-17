# alpine322-f2fs
Build Scripts for Alpine 3.22 including F2FS Support

## Build ISO with Docker (PowerShell)

```pwsh
docker build -t alpine-iso .
docker run --rm -v ${PWD}:/out alpine-iso
```

## Build ISO with Docker (Linux)

```pwsh
docker build -t alpine-iso .
docker run --rm -v $pwd:/out alpine-iso
```
