# syntax=docker/dockerfile:1
FROM --platform=$TARGETPLATFORM centos:centos7.9.2009

ARG TARGETARCH

MAINTAINER actanble <actanble@gmail.com>
USER root

# TODO Set the time and lang
ENV LANG en_US.UTF-8
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ADD . /nfs_client
RUN sed -i 's/\r//' /nfs_client/${TARGETARCH}/01_${TARGETARCH}_inital_rpm_source.sh && \
    /bin/bash /nfs_client/${TARGETARCH}/01_${TARGETARCH}_inital_rpm_source.sh

RUN yum makecache && yum -y install fontconfig freetype which wget curl git make subversion
# docker
# RUN sed -i 's/TMOUT=300/TMOUT=0/g' /etc/bashrc

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh -o /tmp/script.rpm.sh \
  && os=el dist=7 bash /tmp/script.rpm.sh \
  && rm -f /tmp/script.rpm.sh \
  && yum install -y \
    git-lfs \
  && yum clean all \
  && git lfs install

# TODO Install Perl Commad
# Ref https://mirror.tuna.tsinghua.edu.cn/help/CPAN/
#RUN  yum install -y perl-CPAN && \
#     PERL_MM_USE_DEFAULT=1 \
#     perl -MCPAN -e 'CPAN::HandleConfig->edit("pushy_https", 0); CPAN::HandleConfig->edit("urllist", "unshift", "https://mirrors.aliyun.com/CPAN/"); mkmyconfig' || echo 'IGNORE CPAN CONFIG ERROR' && \
#     cpan install IPC/Cmd.pm

WORKDIR /root/

RUN yum -y clean all && \
        rm -rf /var/cache/yum /var/lib/yum/yumdb/* /usr/lib/udev/hwdb.d/* && \
        rm -rf /var/cache/dnf /etc/udev/hwdb.bin /root/.pki





