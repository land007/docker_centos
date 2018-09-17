FROM centos:7.5.1804
MAINTAINER Yiqiu Jia <yiqiujia@hotmail.com>

#RUN ldd --version
#glibc2.12

RUN yum update -y \
	&& yum install -y initscripts net-tools vim*  curl wget unzip screen openssh-server git subversion locales \
#	&& yum groupinstall -y Chinese-support \
	&& yum clean all
#RUN locale -a
#ENV LC_ALL zh_CN.UTF-8
#RUN sed -i 's/en_US.UTF-8/zh_CN.UTF-8/g' /etc/sysconfig/i18n

RUN sed -i 's/#Port 22/Port 20022/g' /etc/ssh/sshd_config

RUN useradd -s /bin/bash -m land007
RUN echo "land007:1234567" | /usr/sbin/chpasswd
#land007:x:1000:1000::/home/land007:/bin/bash
RUN sed -i "s/^land007:x.*/land007:x:0:1000::\/home\/land007:\/bin\/bash/g" /etc/passwd

#CMD (nohup /usr/sbin/init > /tmp/service.out 2>&1 &) && bash
#CMD /usr/sbin/init
#[FAILED] Failed to start LSB: Bring up/down networking.
CMD /etc/init.d/sshd start && bash

EXPOSE 20022/tcp

#latest
#docker stop centos ; docker rm centos ; docker run -it --privileged -p 20022:20022 --name centos land007/centos:latest
#7.5.1804
#docker stop centos ; docker rm centos ; docker run -it --privileged -p 20022:20022 --name centos land007/centos:7.5.1804
