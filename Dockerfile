FROM advox/crontab-ui

VOLUME [ "/etl" ]

RUN mkdir  /usr/share/man/man1

RUN apt -y update && \ 
    apt -y install apt-transport-https \
          ca-certificates wget dirmngr \
          gnupg software-properties-common && \
    wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
    add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
    apt -y update
RUN apt -y remove libgcc-8-dev
RUN apt -y install adoptopenjdk-8-hotspot && \
    apt -y upgrade && \
    apt -y autoremove
RUN wget -O pentaho.zip https://sourceforge.net/projects/pentaho/files/latest/download
RUN unzip pentaho.zip && \
    mkdir /pentaho && \
    mv data-integration/* pentaho/ && \
    rm -Rf data-integration pentaho.zip
COPY ./drivers/* /pentaho/lib
