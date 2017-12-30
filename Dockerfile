FROM lsiobase/alpine.python3:3.7

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

RUN \
 echo "**** install gazee ****" && \
 git clone --depth 1 https://github.com/hubbcaps/gazee.git /app/gazee && \
 sed -i \
	'/^CherryPy/!s/==/>=/g' \
	/app/gazee/requirements.txt && \
 pip install --no-cache-dir -U \
	-r /app/gazee/requirements.txt && \
 echo "**** clean up ****" && \
 rm -rf \
	/root/.cache \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 4242
VOLUME /certs /comics /config /mylar
