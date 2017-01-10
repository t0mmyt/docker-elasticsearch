FROM t0mmyt/jre8:latest
MAINTAINER Tom Taylor <tom+dockerfiles@tomm.yt>

ENV ES_VER=2.4.3
EXPOSE 9200 9300

ENV ES_HOME=/opt/elasticsearch-${ES_VER}
ENV ES_DOWNLOAD_URL=https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${ES_VER}/elasticsearch-${ES_VER}.tar.gz

RUN useradd -d ${ES_HOME} elasticsearch && \
    curl -Ls ${ES_DOWNLOAD_URL} | tar zx -C /opt && chown -R elasticsearch:elasticsearch ${ES_HOME}

COPY elasticsearch.yml ${ES_HOME}/config/

WORKDIR ${ES_HOME}/bin

USER elasticsearch
ENTRYPOINT ["./elasticsearch"]
