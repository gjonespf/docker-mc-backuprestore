FROM gavinjonespf/docker-croney:latest

#Minio client
RUN			curl -L https://dl.minio.io/client/mc/release/linux-amd64/mc > /usr/local/bin/mc && \
				chmod +x /usr/local/bin/mc

COPY        ./files /app/files
COPY        ./scripts /app/scripts
RUN         chmod a+x /app/scripts/*

ENTRYPOINT [ "/app/scripts/start.sh" ]
CMD [ "/app/files/generated-crontab" ]
