FROM centos

WORKDIR /

ADD apache-maven-3.3.9-bin.tar.gz .
ADD jdk-8u201-linux-x64.tar.gz .
ADD spark-2.1.0-bin-hadoop2.7.tgz .

#RUN ls -la
#RUN tar -xzf /apache-maven-3.3.9-bin.tar.gz
#RUN tar -xzf /jdk-8u201-linux-x64.tar.gz
#RUN tar -xzf /spark-2.1.0-bin-hadoop2.7.tgz

#Install random stuff
RUN yum install -y unzip curl git which

#Setup environment vars
ENV JAVA_HOME=/jdk1.8.0_201
ENV MAVEN_HOME=/apache-maven-3.3.9
ENV SPARK_HOME=/spark-2.1.0-bin-hadoop2.7
ENV PATH=$JAVA_HOME/bin:$PATH
ENV PATH=$MAVEN_HOME/bin:$PATH
ENV PATH=$SPARK_HOME/bin:$PATH

#Get benchmark code + set it up
#RUN env
#RUN ls -la
#RUN ls -la apache-maven-3.3.9
#RUN which mvn
#RUN which mvn 2>/dev/null | grep mvn | wc -l
RUN git clone https://github.com/qiuxin2012/BigDLNCF.git
RUN cd /BigDLNCF/ && ls -la && source /BigDLNCF/make-dist.sh

#Get Dataset
RUN cd /BigDLNCF && bash /BigDLNCF/download_dataset.sh && bash /BigDLNCF/verify_dataset.sh && unzip -o ml-20m.zip


#Finalize
ADD docker-entry.sh /
RUN chmod +x /docker-entry.sh
ENTRYPOINT /docker-entry.sh

# Ports
# EXPOSE
