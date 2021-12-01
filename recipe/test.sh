#!/usr/bin/env bash
# Run the tests for CA-Certificates

set -ex
#export PYTHON_MAJOR_VERSION=$(python -c "import sys; print(sys.version_info[0])")
#echo $PYTHON_MAJOR_VERSION

exists() {
	FULL_PATH="${PREFIX}/${1}"
	if [ -f "${FULL_PATH}" ]; then
		echo "Found ${1}"
	else
		echo "Could not find ${FULL_PATH}"
		exit 1
	fi
}

for i in ssl/{cacert,cert}.pem ; do
	exists $i
done
