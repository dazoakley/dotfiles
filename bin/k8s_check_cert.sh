#!/bin/bash

# A quick and dirty bash script to pull out a cert chain from a k8s secret,
# split it and output the text details of each cert in the chain.

kubectl view-secret "${1}" tls.crt |
	awk '
    split_after == 1 {n++;split_after=0} 
    /-----END CERTIFICATE-----/ {split_after=1} 
    {print > "/tmp/cert" n ".pem"}' &&
	for f in /tmp/cert*; do
		echo -e "${f}:\n\n"
		openssl x509 -text -noout -in "${f}"
		echo -e "---\n---\n---\n"
	done &&
	rm -f /tmp/cert*
