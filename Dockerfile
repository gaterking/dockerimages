FROM centos:6
MAINTAINER seasons.li

CMD [ "sh", "-c", "while true; do sleep 10; done"]
ENV JRE_VERSION 1.8.0
#    ZOO_USER zookeeper \
#    ZOO_CONF_DIR /conf \
#    ZOO_DATA_DIR /data \
#    ZOO_DATA_LOG_DIR /datalog \
#    ZOO_PORT 2181 \
#    ZOO_TICK_TIME 2000 \
#    ZOO_INIT_LIMIT 5 \
#    ZOO_SYNC_LIMIT 2

#WORKDIR /tmp
#更新yum源
RUN yum install -y wget
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup && \
    wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS6-Base-163.repo &&\
    yum clean all && \
    yum makecache && \
    yum update -y
#安装openssh
RUN yum install openssh-server -y && \
    service sshd start

#安装jre8
RUN yum install -y java-$JRE_VERSION-openjdk.x86_64

#安装zookeeper
RUN yum install -y zookeeper-server
#RUN mkdir -p /var/lib/zookeeper && \
#    chown -R zookeeper /var/lib/zookeeper/
#配置zoozooker
#COPY zoo.conf /opt/zookeeper/conf/zoo.cfg

#启动zookeeper
#RUN sudo service zookeeper-server init --myid=1 && \
#    sudo service zookeeper-server start
#COPY install.sh install.sh

#RUN chmod a+x install.sh && \
#    /bin/bash ./install.sh