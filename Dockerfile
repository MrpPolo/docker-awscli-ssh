FROM alpine:latest

LABEL maintainer="Polo Chang"

ENV ROOT_PASSWORD root

RUN apk update	&& apk upgrade && apk add openssh \
		python \
		py-pip \
		groff \
		&& sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
		&& sed -ri "s/^#[[:space:]]*StrictHostKeyChecking .*$/StrictHostKeyChecking no\nLogLevel quiet/g;/GSS/s/yes/no/g;" /etc/ssh/ssh_config \
		&& echo "root:${ROOT_PASSWORD}" | chpasswd \
		&& python \
		&& pip install awscli \
		&& apk -v --purge del py-pip \
		&& rm -rf /var/cache/apk/* /tmp/*
 
 