FROM stoo/baseimage:0.9.12

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y curl

# Install additional packages
RUN apt-get install -y less
RUN apt-get install -y man
RUN apt-get install -y slapd
RUN apt-get install -y ldap-utils
RUN apt-get install -y libsasl2-modules
RUN apt-get install -y libsasl2-modules-gssapi-mit
RUN apt-get install -y db4.8-util

# Configure application startup
RUN mkdir /etc/service/openldap
ADD openldap.sh /etc/service/openldap/run

# Include an SSH key
ADD sshid.pub /tmp/sshid.pub
RUN mkdir -m 0700 /root/.ssh
RUN cat /tmp/sshid.pub >>/root/.ssh/authorized_keys
RUN rm -f /tmp/sshid.pub

# Start baseimage init by default
CMD ["/sbin/my_init"]
