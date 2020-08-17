
FROM ubuntu:18.04
RUN mkdir /directus
RUN cd /directus
RUN apt-get update
RUN apt-get install -y systemd
RUN apt-get install -y git
RUN git clone https://github.com/MAXPOL/directus.git
RUN chmod +x /directus/directusScript.sh
#RUN /directus/directusScript.sh // Run this it script by hand after create docker machine in inside docker machine.
