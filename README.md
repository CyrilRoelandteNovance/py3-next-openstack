# py3-next-openstack

An easy way to test an OpenStack project against the next version of Python.

## Building the container image

The following command will build the py3-next-openstack container image:

~~~console
$ make build-py3-next-openstack
~~~

One may also specify a specific version of Python to use in the container image,
using a valid tag from [the Docker Hub](https://hub.docker.com/_/python):

~~~console
$ VERSION=3.13.0rc1 make build-py3-next-openstack
~~~


## Testing a project inside a container

One can test an OpenStack project using the next version of Python by running
the following command:

~~~console
$ PROJECT=/path/to/git/directory make tox
~~~

This mounts the git repository into the container and runs `tox -repy3XX`.

Some dependencies may be broken with this version of Python. Their authors may
have fixed the issues but not released a new version on PyPI yet. In that case,
one can build the wheel by themselves, copy it to `/path/to/custom/wheels` and
instruct pip to use it:

~~~console
$ PROJECT=/path/to/git/directory WHEELS=/path/to/custom/wheels make tox
~~~

## Building a custom wheel

The following command will build a wheel for the given project:

~~~console
$ PROJECT=/path/to/git/directory make wheel
~~~

The wheel will be available in `/path/to/git/directory/dist`.

## Debugging

One may open a shell in the container by running:

~~~console
$ PROJECT=/path/to/git/directory WHEELS=/path/to/custom/wheels make debug
~~~
