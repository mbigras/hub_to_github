FROM alpine:edge
RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
	&& apk --update --upgrade add \
		git \
		hub \
		openssh
RUN mkdir /root/.config /root/.ssh \
	&& ssh-keyscan github.com >> /root/.ssh/known_hosts
WORKDIR /workdir
