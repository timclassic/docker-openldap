.PHONY: all build image

define sshidpub
echo "Looking for RSA key" \
    && test -f ~/.ssh/id_rsa.pub \
    && cp -p ~/.ssh/id_rsa.pub sshid.pub \
    || ( echo "RSA key not found, trying DSA" \
         && cp -p ~/.ssh/id_dsa.pub sshid.pub )
endef

all: image

image:
	$(sshidpub)
	docker build -t "stoo/openldap:2.4.31-1" .

latest: image
	docker build -t "stoo/openldap:latest" .
