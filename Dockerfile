ARG WORKDIR=/app
ARG MICRODIR=/microdir
ARG PKGS="python3 python3-pip shadow-utils gawk"
FROM redhat/ubi9 AS builder
# FROM registry.access.redhat.com/ubi9/python-312 AS builder
ARG WORKDIR PKGS MICRODIR
#COPY --from=BASE / ${WORKDIR}
RUN yum install \
  --installroot ${MICRODIR} \
  --releasever 9 \
  --setop install_weak_deps=false \
  -y \
  ${PKGS}
RUN yum clean all \
  --installroot ${MICRODIR}

FROM scratch AS image
ARG WORKDIR
ARG MICRODIR
COPY --from=builder ${MICRODIR}/ .
WORKDIR ${WORKDIR}
RUN groupadd -g 101 app && useradd -ms /usr/bin/bash -u101 -g101 app && chown app:app ${WORKDIR}
COPY --chown=app:app . ${WORKDIR}
USER app
RUN pip3 install --no-cache-dir -r requirements.txt
EXPOSE 5000
CMD ["/usr/bin/bash","entrypoint.sh"]