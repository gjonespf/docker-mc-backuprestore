FROM gavinjonespf/docker-toolbox:latest
COPY ./scripts /scripts
RUN chmod a+x /scripts/*

