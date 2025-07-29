#! /bin/sh

say() {     echo "[1m$@[0m"   ; }
ok()  {     echo "[1;32m$@[0m"; }
ko()  { >&2 echo "[1;31m$@[0m"; }

case "${1:-2.4}" in
    2.2) version=2.2 ;;
    2.4) version=2.4 ;;
    *)   ko Unsupported version: $1 && exit 1 ;;
esac

ok Starting Apache $version
docker build -t apache-playground:$version --file Dockerfile-$version .
docker run --rm -it --name apache-playground-$version -p443:443 --publish 8888:80 apache-playground:$version
