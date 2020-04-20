FROM debian:buster

COPY ./srcs .

RUN chmod +x ./deploy.sh \
&& chmod +x ./entrypoint.sh

RUN ./deploy.sh

ENTRYPOINT ["./entrypoint.sh"]
