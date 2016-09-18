FROM gavinjonespf/docker-toolbox:latest
COPY ./scripts /scripts
RUN chmod a+x /scripts/*

ENTRYPOINT [ "/scripts/mc-mirror-src2dest.sh" ]
