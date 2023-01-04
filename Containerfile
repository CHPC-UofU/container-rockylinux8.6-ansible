# Base image:
FROM docker.io/library/rockylinux:8.6
 
# Environmental variables:
ENV pip_packages "ansible"

# Install systemd:
# * See https://hub.docker.com/_/centos/
RUN rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# Package installs/updates:
RUN dnf -y install rpm dnf-plugins-core && \
    dnf -y update && \
    dnf -y config-manager --set-enabled powertools && \
    dnf -y install \
      epel-release \
      hostname \
      initscripts \
      libyaml-devel \
      python3 \
      python3-pip \
      python3-pyyaml \
      sudo \
      which && \
    dnf clean all

# Upgrade pip to latest version:
RUN pip3 install --upgrade pip

# Install Python packages:
RUN pip3 install $pip_packages

# Disable requiretty:
RUN sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers

# Install Ansible inventory file:
RUN mkdir -p /etc/ansible
RUN echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts

# Specify volumes:
VOLUME [ "/sys/fs/cgroup" ]

# Run once the container has started:
CMD [ "/usr/lib/systemd/systemd" ]
