#!/bin/bash

# Create the directory to hold the certificates.
mkdir -p "${PREFIX}/ssl"

if [[ $(uname) == Darwin ]]; then
  curl http://anduin.linuxfromscratch.org/BLFS/other/certdata.txt > certdata.txt
else
  wget -c http://anduin.linuxfromscratch.org/BLFS/other/certdata.txt
fi
mkdir -p /tmp/ca-cerificates-$$
# conda-build introduced a bug in source filenames where the checksum gets added.
if [[ -f ./make-ca_c882ab8b5a.sh-20170514 ]]; then
  MAKE_CA_SH=./make-ca_c882ab8b5a.sh-20170514
else
  MAKE_CA_SH=./make-ca.sh-20170514
fi
bash ${MAKE_CA_SH} --destdir /tmp/ca-cerificates-$$/ --ssldir ssl --localdir /tmp/no_such_dir
echo "RESULT $?"
find ${PREFIX} -name "*.pem" -exec rm {} \;
mv /tmp/ca-cerificates-$$/ssl/ca-bundle.crt ${PREFIX}/ssl/cacert.pem
ln -fs "${PREFIX}/ssl/cacert.pem" "${PREFIX}/ssl/cert.pem"
