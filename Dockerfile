# [gitolite](http://gitolite.com/gitolite/install.html)

FROM centos:7

MAINTAINER King-On Yeung <koyeung@gmail.com>

RUN yum install -y deltarpm yum-utils && \
    yum install -y git perl-Data-Dumper openssh-server && \
    yum clean all

RUN /usr/sbin/useradd --comment "Git" --shell /bin/bash git

USER git
WORKDIR /home/git
RUN mkdir -p /home/git/bin && \
    git clone git://github.com/sitaramc/gitolite  && \
    gitolite/install -ln /home/git/bin && \
    mkdir -p /home/git/repositories

USER root
EXPOSE 22

# patch sshd_config for fast login
RUN echo "UseDNS no" >> /etc/ssh/sshd_config

VOLUME ["/home/git/repositories"]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/sbin/sshd", "-D"]

COPY entrypoint.sh /entrypoint.sh
COPY setup.sh /setup.sh
