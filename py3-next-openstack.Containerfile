ARG VERSION
FROM python:${VERSION}

WORKDIR /usr/src/app

RUN apt update -y
# libldap-dev: Keystone needs it to build python-ldap
# libsasl2-dev: Keystone needs it to build python-ldap
# librdkafka-dev: oslo.messaging needs it to build confluent-kafka
RUN apt install -y libldap-dev librdkafka-dev libsasl2-dev qemu-utils
RUN pip install --no-cache-dir tox build

CMD tox -repy3
