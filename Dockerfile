ARG WORKDIR=/app
ARG MICRODIR=/microdir
ARG PKGS="python3 python3-pip gawk"
FROM registry.access.redhat.com/ubi9/ubi AS builder

ARG WORKDIR PKGS MICRODIR
RUN yum install \
  --installroot ${MICRODIR} \
  --releasever 9 \
  --setop install_weak_deps=false \
  -y \
  ${PKGS}
RUN yum clean all \
  --installroot ${MICRODIR}

# RUN microdnf --noplugins --config=/etc/dnf/dnf.conf --setopt=cachedir=/var/cache/microdnf \
# --setopt=reposdir=/etc/yum.repos.d --setopt=varsdir=/etc/dnf --installroot=/microdir --releasever 9 \
# install -y ${PKGS}
# RUN microdnf --noplugins --config=/etc/dnf/dnf.conf --setopt=cachedir=/var/cache/microdnf \
# --setopt=reposdir=/etc/yum.repos.d --setopt=varsdir=/etc/dnf --installroot=/microdir --releasever 9 \
# clean all

FROM scratch AS image
ARG WORKDIR
ARG MICRODIR
COPY --from=builder ${MICRODIR}/ .
#RUN groupadd -g 101 app && useradd -ms /usr/bin/bash -u101 -g101 app && chown app:app ${WORKDIR}
RUN echo "app:x:101:" >> /etc/group && echo "app:x:101:101::${WORKDIR}:/usr/bin/bash" >> /etc/passwd && echo "app:!!:20104:0:99999:7:::" >> /etc/shadow && mkdir ${WORKDIR} && chown -R app:app ${WORKDIR}
COPY --chown=app:app . ${WORKDIR}
ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
USER app
WORKDIR ${WORKDIR}
RUN pip3 install --no-cache-dir -r requirements.txt
EXPOSE 5000
CMD ["/usr/bin/bash","entrypoint.sh"]