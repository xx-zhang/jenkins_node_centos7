#!//bin/bash
releasever=7
#basearch=x86_64
basearch=aarch64

echo "Writing Centos Base Repo..."
cat > /etc/yum.repos.d/Centos7-Base.repo <<- EOF
# CentOS-Base.repo
#
# The mirror system uses the connecting IP address of the client and the
# update status of each mirror to pick mirrors that are updated to and
# geographically close to the client.  You should use this for CentOS updates
# unless you are manually picking other mirrors.
#
# If the mirrorlist= does not work for you, as a fall back you can try the
# remarked out baseurl= line instead.
#
#

[base]
name=CentOS-$releasever - Base
baseurl=https://repo.huaweicloud.com/centos-altarch/$releasever/os/$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os
enabled=1
gpgcheck=0
gpgkey=https://repo.huaweicloud.com/centos-altarch/7/os/aarch64/RPM-GPG-KEY-CentOS-7

#released updates
[updates]
name=CentOS-$releasever - Updates
baseurl=https://repo.huaweicloud.com/centos-altarch/$releasever/updates/$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=updates
enabled=1
gpgcheck=0
gpgkey=https://repo.huaweicloud.com/centos-altarch/7/os/aarch64/RPM-GPG-KEY-CentOS-7



#additional packages that may be useful
[extras]
name=CentOS-$releasever - Extras
baseurl=https://repo.huaweicloud.com/centos-altarch/$releasever/extras/$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=extras
enabled=1
gpgcheck=0
gpgkey=https://repo.huaweicloud.com/centos-altarch/$releasever/os/aarch64/RPM-GPG-KEY-CentOS-7



#additional packages that extend functionality of existing packages
[centosplus]
name=CentOS-$releasever - Plus
baseurl=https://repo.huaweicloud.com/centos-altarch/$releasever/centosplus/$basearch/
#mirrorlist=http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus
gpgcheck=0
enabled=0
gpgkey=https://repo.huaweicloud.com/centos-altarch/7/os/aarch64/RPM-GPG-KEY-CentOS-7


EOF

echo "Writing Centos Epel Repo..."
cat  > /etc/yum.repos.d/epel7.repo <<- EOF
[epel]
name=Extra Packages for Enterprise Linux 7 - $basearch
baseurl=https://repo.huaweicloud.com/epel/7/$basearch
#mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
failovermethod=priority
enabled=1
gpgcheck=1
gpgkey=https://repo.huaweicloud.com/epel/RPM-GPG-KEY-EPEL-7


[epel-debuginfo]
name=Extra Packages for Enterprise Linux 7 - $basearch - Debug
baseurl=https://repo.huaweicloud.com/epel/7/$basearch/debug
#mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-debug-7&arch=$basearch
failovermethod=priority
enabled=0
gpgkey=https://repo.huaweicloud.com/epel/RPM-GPG-KEY-EPEL-7

gpgcheck=1

[epel-source]
name=Extra Packages for Enterprise Linux 7 - $basearch - Source
baseurl=https://repo.huaweicloud.com/epel/7/SRPMS
#mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-source-7&arch=$basearch
failovermethod=priority
enabled=0
gpgkey=https://repo.huaweicloud.com/epel/RPM-GPG-KEY-EPEL-7
gpgcheck=1


EOF

echo "Writing Centos Docker Repo..."
cat <<- EOF  > /etc/yum.repos.d/docker-ce.repo
[docker-ce-stable]
name=Docker CE Stable - $basearch
baseurl=https://repo.huaweicloud.com/docker-ce/linux/centos/$releasever/$basearch/stable
enabled=1
gpgcheck=1
gpgkey=https://repo.huaweicloud.com/docker-ce/linux/centos/gpg

[docker-ce-stable-debuginfo]
name=Docker CE Stable - Debuginfo $basearch
baseurl=https://repo.huaweicloud.com/docker-ce/linux/centos/$releasever/debug-$basearch/stable
enabled=0
gpgcheck=1
gpgkey=https://repo.huaweicloud.com/docker-ce/linux/centos/gpg

[docker-ce-stable-source]
name=Docker CE Stable - Sources
baseurl=https://repo.huaweicloud.com/docker-ce/linux/centos/$releasever/source/stable
enabled=0
gpgcheck=1
gpgkey=https://repo.huaweicloud.com/docker-ce/linux/centos/gpg

[docker-ce-test]
name=Docker CE Test - $basearch
baseurl=https://repo.huaweicloud.com/docker-ce/linux/centos/$releasever/$basearch/test
enabled=0
gpgcheck=1
gpgkey=https://repo.huaweicloud.com/docker-ce/linux/centos/gpg

[docker-ce-test-debuginfo]
name=Docker CE Test - Debuginfo $basearch
baseurl=https://repo.huaweicloud.com/docker-ce/linux/centos/$releasever/debug-$basearch/test
enabled=0
gpgcheck=1
gpgkey=https://repo.huaweicloud.com/docker-ce/linux/centos/gpg

[docker-ce-test-source]
name=Docker CE Test - Sources
baseurl=https://repo.huaweicloud.com/docker-ce/linux/centos/$releasever/source/test
enabled=0
gpgcheck=1
gpgkey=https://repo.huaweicloud.com/docker-ce/linux/centos/gpg

[docker-ce-nightly]
name=Docker CE Nightly - $basearch
baseurl=https://repo.huaweicloud.com/docker-ce/linux/centos/$releasever/$basearch/nightly
enabled=0
gpgcheck=1
gpgkey=https://repo.huaweicloud.com/docker-ce/linux/centos/gpg

[docker-ce-nightly-debuginfo]
name=Docker CE Nightly - Debuginfo $basearch
baseurl=https://repo.huaweicloud.com/docker-ce/linux/centos/$releasever/debug-$basearch/nightly
enabled=0
gpgcheck=1
gpgkey=https://repo.huaweicloud.com/docker-ce/linux/centos/gpg

[docker-ce-nightly-source]
name=Docker CE Nightly - Sources
baseurl=https://repo.huaweicloud.com/docker-ce/linux/centos/$releasever/source/nightly
enabled=0
gpgcheck=1
gpgkey=https://repo.huaweicloud.com/docker-ce/linux/centos/gpg


EOF

yum makecache