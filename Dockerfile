FROM gavinjonespf/docker-croney:latest

#Minio client
RUN			curl -L https://dl.minio.io/client/mc/release/linux-amd64/mc > /usr/local/bin/mc && \
				chmod +x /usr/local/bin/mc

COPY        ./scripts /scripts
RUN         chmod a+x /scripts/*

ENTRYPOINT [ "/app/scripts/start.sh" ]
