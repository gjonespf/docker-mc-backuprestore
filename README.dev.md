Testing builds


```
docker build -t gavinjonespf/docker-mc-backuprestore:dev .

docker run -it --entrypoint /bin/bash gavinjonespf/docker-mc-backuprestore:dev

```

```
/app/scripts/start.sh /app/files/default-crontab
```

```
/app/scripts/init/0-build-crontab.sh
/app/scripts/start.sh /app/files/generated-crontab
```

```
docker run -it gavinjonespf/docker-mc-backuprestore:dev /app/files/generated-crontab
```
