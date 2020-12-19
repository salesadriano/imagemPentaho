FROM advox/crontab-ui

RUN echo "deb http://ftp.de.debian.org/debian sid main" >> /etc/apt/sources.list

RUN apt -y update
RUN mkdir  /usr/share/man/man1
RUN apt -y remove libgcc-8-dev
RUN apt -y remove irc
RUN apt -y install openjdk-8-jdk
RUN apt -y install wget
RUN apt -y autoremove
