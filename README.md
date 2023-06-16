# aptly

[![CD](https://github.com/tumichnix/aptly/actions/workflows/cd.yml/badge.svg)](https://github.com/tumichnix/aptly/actions/workflows/cd.yml)

aptly in a container

## Build

```bash
docker buildx build --platform linux/amd64 -t tumichnix/aptly:latest .
```

## Run

```bash
docker run -it \
  -v /mnt/aptly:/opt/aptly \
  -v /mnt/gnupg:/root/.gnupg \
  -p 80:80 \
  -p 8080:8080 \
  --name=aptly \
  tumichnix/aptly:latest
```