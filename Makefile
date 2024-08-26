VERSION?=3.13.0rc1
IMAGE=py3-next-openstack:${VERSION}

WORKDIR=/usr/src/app
WHEELDIR=/usr/src/wheels
TOX_CONSTRAINTS_FILE=https://opendev.org/openstack/requirements/raw/branch/master/global-requirements.txt

build-py3-next-openstack:
	podman build \
		--build-arg VERSION=${VERSION} \
		-t ${IMAGE} -f py3-next-openstack.Containerfile

# Check whether PROJECT is defined
check-project:
ifndef PROJECT
	$(error PROJECT is undefined. It must be set to the path to your project)
endif

wheel: check-project
	podman run --rm \
		-v ${PROJECT}:${WORKDIR} \
		${IMAGE} python -m build -w

tox: check-project
	podman run --rm \
		-v ${PROJECT}:${WORKDIR} \
		$(if ${WHEELS},-v ${WHEELS}:${WHEELDIR},) \
		-e PIP_FIND_LINKS=${WHEELDIR} \
		-e PIP_NO_CACHE_DIR=1 \
		-e TOX_CONSTRAINTS_FILE=${TOX_CONSTRAINTS_FILE} \
		${IMAGE}

debug: check-project
	podman run -it --rm \
		-v ${PROJECT}:${WORKDIR} \
		$(if ${WHEELS},-v ${WHEELS}:${WHEELDIR},) \
		-e PIP_FIND_LINKS=${WHEELDIR} \
		-e PIP_NO_CACHE_DIR=1 \
		-e TOX_CONSTRAINTS_FILE=${TOX_CONSTRAINTS_FILE} \
		${IMAGE} /bin/bash
