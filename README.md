# Rocky Linux 8.6 Ansible Test Image

[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-blue.svg)](http://unlicense.org/)
[![Release](https://github.com/CHPC-UofU/container-rockylinux8.6-ansible/actions/workflows/release.yml/badge.svg)](https://github.com/CHPC-UofU/container-rockylinux8.6-ansible/actions/workflows/release.yml)

Rocky Linux 8.6 container for Ansible playbook and role testing.

## Image Tags

* `latest`: Latest stable version of Ansible (lightweight image for basic validation of Ansible playbooks).

## How to Build

This image is built on GitHub automatically any time a commit is made or merged to the `main` branch and tagged. But if you need to build the image on your own locally, do the following:

1. Install [Podman](https://podman.io/getting-started/installation) or [Docker](https://docs.docker.com/get-docker/).
   * In the commands below, `podman` may be interchanged with `docker` depending on your choice.
2. `cd` into the directory containing this repository.
3. Build the image:

   ```shell
   podman build --file Containerfile --tag rockylinux8.6-ansible .   
   ```

## How to Use

1. Install [Podman](https://podman.io/getting-started/installation) or [Docker](https://docs.docker.com/get-docker/).
   * In the commands below, `podman` may be interchanged with `docker` depending on your choice.
2. Pull this image from GitHub (or use the image you built above `rockylinux8.6-ansible:latest`):

   ```shell
   podman pull ghcr.io/chpc-uofu/container-rockylinux8.6-ansible:latest
   ```
3. Run a container from the image:

   ```shell
   podman run --detach --privileged --volume=/sys/fs/cgroup:/sys/fs/cgroup:ro ghcr.io/chpc-uofu/container-rockylinux8.6-ansible:latest
   ```
   
   To test Ansible roles it is helpful to add in a volume from the current working directory with the following option:

   ```shell
   --volume=${PWD}:/etc/ansible/roles/role_under_test:ro
   ```
   
4. Use Ansible inside the container. Here are a few examples.

   Check Ansible's version:

   ```shell
   podman exec --tty [container_id] env TERM=xterm ansible --version
   ```
   
   Check the syntax of an Ansible playbook:

   ```shell
   podman exec --tty [container_id] env TERM=xterm ansible-playbook /path/to/ansible/playbook.yml --syntax-check
   ```

## How to Contribute

1. Submit a pull request against `main`.
2. Once the automated status checks pass, complete the pull request by squash-merging with `main`.
3. Apply a [semantic version](https://semver.org/) tag to the resulting commit (e.g. `v1.0.1`).
4. At this point the automatic image build on GitHub will trigger, tagging the new image with the semantic version and `latest`.

## Author

Derived from [geerlingguy/docker-rockylinux8-ansible](https://github.com/geerlingguy/docker-rockylinux8-ansible).
