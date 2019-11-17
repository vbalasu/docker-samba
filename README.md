# docker-samba

The following docker container exposes a folder through Samba (SMB)

You can run this container as follows:

```
docker pull vbalasu/samba
./run.sh
```

Be sure to allow network traffic on the SMB ports - 139 and 445


#### Dockerfile

```
FROM ubuntu:latest
RUN apt-get update -y && apt-get install -y samba cifs-utils vim
COPY smb.conf /etc/samba/smb.conf
RUN mkdir /myuser
RUN chmod 777 /myuser
RUN adduser --disabled-password --gecos "" myuser
RUN (echo myuser; echo myuser) | smbpasswd myuser -as
ENTRYPOINT /etc/init.d/smbd restart && tail -f /dev/null
```


#### build.sh

```
docker build -t vbalasu/samba .
```


#### run.sh

```
docker run --rm -d -p 139:139 -p 445:445 -v $(pwd)/myuser:/myuser vbalasu/samba 
```


### Update the default smb.conf to include the following:

```
[myuser]
   comment = My User's cloud directory
   path = /myuser
   read only = no
   guest ok = yes
;   browseable = no

```

### Connect from a client

On a Mac, you can use Finder and choose Go --> Connect to server (Command-K)

then enter the path as shown in the below example:

```
smb://myuser@192.168.86.144
```

Choose the username and password (myuser) to connect

