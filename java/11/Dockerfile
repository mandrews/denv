FROM denv/base

ARG USER

USER root

# Install OpenJDK
RUN apk fetch openjdk11-jdk && \
    apk add openjdk11-jdk

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk
ENV PATH="$JAVA_HOME/bin:${PATH}"

# Install Maven
ENV MAVEN_VERSION 3.5.4
ENV MAVEN_HOME /usr/lib/mvn
ENV PATH $MAVEN_HOME/bin:$PATH
ENV M2_HOME /Users/$USER/.local

RUN wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  mv apache-maven-$MAVEN_VERSION /usr/lib/mvn

USER $USER
