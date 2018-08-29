FROM alpine:3.7

RUN apk add --no-cache mongodb-tools py2-pip pv && \
  pip install --no-cache-dir pymongo && \
  mkdir /backup

COPY entrypoint.sh /usr/local/bin/entrypoint
COPY restore.sh /usr/local/bin/restore
COPY mongouri.py /usr/local/bin/mongouri

VOLUME /backup

CMD /usr/local/bin/entrypoint
