#
# Dockerfile for building Mirth Connect
#

# Use Eclipse Temurin JRE for Java
FROM eclipse-temurin:23-jre

# Set environment variables for Mirth
# Get versions at mirthdownloadarchive.s3.amazonaws.com/connect-downloads.html
ENV MIRTH_HOME=/opt/mirthconnect
ENV MIRTH_DL=https://s3.amazonaws.com/downloads.mirthcorp.com/connect/4.5.2.b363/mirthconnect-4.5.2.b363-unix.tar.gz

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends wget unzip \
    && rm -rf /var/lib/apt/lists/*

# Download and extract Mirth Connect
RUN wget -qO- $MIRTH_DL | tar xz -C /opt/ \
    && mv /opt/Mirth* $MIRTH_HOME \
    && chmod +x $MIRTH_HOME/mcservice

# Set working directory
WORKDIR $MIRTH_HOME

# Expose required ports
EXPOSE 8080 8443

# Add entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Switch to non-root user (Optional)
RUN useradd -m mirth && chown -R mirth:mirth $MIRTH_HOME
USER mirth

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
