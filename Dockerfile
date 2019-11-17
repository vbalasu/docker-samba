FROM ubuntu:latest
RUN apt-get update -y && apt-get install -y samba cifs-utils vim
COPY smb.conf /etc/samba/smb.conf
RUN mkdir /myuser
RUN chmod 777 /myuser
RUN adduser --disabled-password --gecos "" myuser
RUN (echo myuser; echo myuser) | smbpasswd myuser -as
ENTRYPOINT /etc/init.d/smbd restart && tail -f /dev/null
