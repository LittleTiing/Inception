FROM	alpine:3.15

RUN		apk update && apk upgrade && \
		apk add mariadb mariadb-client

COPY    ./tools/run.sh /tmp/run.sh

EXPOSE  3306

CMD		["sh", "/tmp/run.sh"]
