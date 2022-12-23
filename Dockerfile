FROM centos:centos7.9.2009

MAINTAINER actanble <actanble@gmail.com>
USER root

# TODO Set the time and lang
ENV LANG en_US.UTF-8
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
    sed -i -e '/mirrors.cloud.aliyuncs.com/d' -e '/mirrors.aliyuncs.com/d' /etc/yum.repos.d/CentOS-Base.repo && \
    curl -o /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo
RUN yum makecache && yum -y install fontconfig freetype which wget openssh-server git make subversion
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
RUN  yum install -y perl-CPAN && \
     PERL_MM_USE_DEFAULT=1 \
     perl -MCPAN -e 'CPAN::HandleConfig->edit("pushy_https", 0); CPAN::HandleConfig->edit("urllist", "unshift", "https://mirrors.aliyun.com/CPAN/"); mkmyconfig' || echo 'IGNORE CPAN CONFIG ERROR' && \
     cpan install IPC/Cmd.pm

ADD ./ssh /etc/ssh
RUN chmod 600 -R /etc/ssh/ssh_host_*

WORKDIR /root/
ADD ./ssh/authorized_keys /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

RUN yum -y clean all && \
        rm -rf /var/cache/yum /var/lib/yum/yumdb/* /usr/lib/udev/hwdb.d/* && \
        rm -rf /var/cache/dnf /etc/udev/hwdb.bin /root/.pki

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]



