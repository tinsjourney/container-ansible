FROM centos

MAINTAINER Tinsjourney <tintin@gnali.org>

RUN yum -y --setopt="tsflags=nodocs" update && \
	yum -y --setopt="tsflags=nodocs" install \
		git \
		which \
		python-setuptools \
		PyYAML \
		python-jinja2 \
	yum clean all && \
	rm -rf /var/cache/yum/*


RUN git clone git://github.com/ansible/ansible.git --recursive /opt/ansible
RUN source /opt/ansible/hacking/env-setup

RUN useradd -u 1000 ansible
USER ansible
ENV PATH /opt/ansible/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV PYTHONPATH /opt/ansible/lib:
ENV MANPATH /opt/ansible/docs/man:
RUN echo "localhost ansible_connection=local" > ~/ansible_hosts
ENV ANSIBLE_INVENTORY=~/ansible_hosts
WORKDIR /home/ansible
CMD ["/opt/ansible/bin/ansible"]
