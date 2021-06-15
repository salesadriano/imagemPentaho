FROM nginx

ADD etl  /etl
ADD sources.list /etc/apt
ADD cron.list /
ADD todas.sh /

RUN mkdir  /usr/share/man/man1 && \
    apt -y update && \ 
    apt -y install apt-transport-https \
          ca-certificates wget dirmngr ntp \
          gnupg software-properties-common && \
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
    add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
    apt -y update && \
    apt -y remove libgcc-8-dev && \
    apt -y install adoptopenjdk-8-hotspot unzip cron && \
    apt -y upgrade && \
    apt -y autoremove && \
    wget -O pentaho.zip https://sourceforge.net/projects/pentaho/files/latest/download && \
    unzip pentaho.zip && \
    mkdir /pentaho && \
    mv data-integration/* pentaho/ && \
    rm -Rf data-integration pentaho.zip && \
    ln -sf /usr/share/zoneinfo/America/Rio_Branco /etc/localtime && \
    chmod 755 /todas.sh
ADD ./drivers/* /pentaho/lib/
