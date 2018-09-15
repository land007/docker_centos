FROM centos:latest
#FROM centos:6.9
MAINTAINER Yiqiu Jia <yiqiujia@hotmail.com>

#RUN ldd --version
#glibc2.12
#RUN yum install glibc-headers 

RUN yum update -y \
	&& yum install -y initscripts net-tools vim*  curl wget unzip screen openssh-server git subversion locales \
#	gcc-c++ make openssl-devel \
	&&  yum clean all

RUN useradd -s /bin/bash -m land007
RUN echo "land007:1234567" | /usr/sbin/chpasswd
#land007:x:1000:1000::/home/land007:/bin/bash
RUN sed -i "s/^land007:x.*/land007:x:0:1000::\/home\/land007:\/bin\/bash/g" /etc/passwd

#CMD (nohup /usr/sbin/init > /tmp/service.out 2>&1 &) && bash
CMD /usr/sbin/init
#[FAILED] Failed to start LSB: Bring up/down networking.

EXPOSE 22/tcp

#docker stop centos ; docker rm centos ; docker run -it --privileged -p 20000:22 --name centos land007/centos:latest
