FROM	alpine:3.15

RUN		apk update && apk upgrade && \
		apk add nginx && \
		apk add openssl

COPY	conf/default.conf /etc/nginx/http.d/default.conf

RUN		openssl req -x509 -nodes -days 365 \
		-subj "/C=FR/ST=France/L=Paris" \
		-newkey rsa:2048 \
		-keyout /etc/ssl/certs/nginx-selfsigned.key \
		-out /etc/ssl/certs/nginx-selfsigned.crt

EXPOSE	443

CMD		["nginx", "-g", "daemon off;"]
