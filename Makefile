PREFIX = /usr

SHELL := sh

.PHONY: \
	install uninstall setup remove all \
	setup-crypto-part remove-crypto


install: setup
uninstall: remove
remove: remove-crypto
setup-crypto: setup-crypto-part
setup: setup-crypto-part
all: setup

setup-crypto-part:
	install -m750 bin/dystopian-crypto $(PREFIX)/bin/dystopian-crypto
	install -dm750 /etc/dystopian/crypto
	install -dm750 /etc/dystopian/crypto/ca
	install -dm700 /etc/dystopian/crypto/ca/private
	install -dm750 /etc/dystopian/crypto/cert
	install -dm700 /etc/dystopian/crypto/cert/private
	install -dm750 /etc/dystopian/crypto/old
	install -dm750 /etc/dystopian/crypto/gnupg
	install -dm755 /etc/dystopian/crypto/crl
	install -dm755 /var/lib/dystopian || true
	install -dm700 /var/lib/dystopian/crypto
	install -Dm600 conf/data.json /var/lib/dystopian/crypto/data.json

remove-crypto:
	rm -f $(PREFIX)/bin/dystopian-crypto
	rm -f /var/lib/dystopian/crypto/data.json
	rmdir /etc/dystopian/crypto/ca/private || true
	rmdir /etc/dystopian/crypto/ca || true
	rmdir /etc/dystopian/crypto/cert/private || true
	rmdir /etc/dystopian/crypto/cert || true
	rmdir /etc/dystopian/crypto/old || true
	rm -f /etc/dystopian/crypto/gnupg/*
	rmdir /etc/dystopian/crypto/gnupg || true
	rmdir /etc/dystopian/crypto/crl || true
	rmdir /etc/dystopian/crypto || true
