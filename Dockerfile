FROM actanble/rhel7:latest

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



