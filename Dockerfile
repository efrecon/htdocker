FROM efrecon/mini-tcl:3.7
MAINTAINER Emmanuel Frecon <emmanuel@sics.se>

# Ensure we have socat since nc on busybox does not support UNIX
# domain sockets.
RUN apk add --no-cache socat

COPY *.md /opt/htdocker/
COPY forwarder.tcl /opt/htdocker/
COPY tockler/*.tcl /opt/htdocker/tockler/

# Export where we will look for the Docker UNIX socket.
VOLUME ["/tmp/docker.sock"]

# Export the plugin directory to ease testing new plugins
VOLUME ["/opt/htdocker/exts"]

ENTRYPOINT ["tclsh8.6", "/opt/htdocker/forwarder.tcl", "-docker", "unix:///tmp/docker.sock"]
CMD ["-verbose", "4"]
