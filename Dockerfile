FROM alpine:3.22

LABEL maintainer="Alpine ISO Builder"
LABEL description="Baut ein benutzerdefiniertes Alpine 3.22 ISO mit F2FS- und Wyse3040-Unterstützung."

RUN apk add --no-cache alpine-sdk abuild git xorriso syslinux doas mtools dosfstools squashfs-tools \ 
        e2fsprogs f2fs-tools alpine-conf util-linux coreutils grub grub-efi f2fs-tools
ENV PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

RUN adduser -D -G wheel -s /bin/sh -g "Alpine Builder" abuild

RUN echo 'permit nopass abuild' > /etc/doas.d/doas.conf

USER abuild
WORKDIR /home/abuild
RUN git clone -b 3.22-stable --single-branch https://gitlab.alpinelinux.org/alpine/aports.git

RUN sed -i 's|export PATH="/usr/bin:/bin"|# &|' aports/scripts/mkimage.sh

RUN echo | abuild-keygen -a -i

WORKDIR /home/abuild/aports/scripts
COPY --chown=abuild:abuild mkimg.wyse3040.sh .
RUN chmod +x mkimg.wyse3040.sh

ENTRYPOINT ["sh", "-x", "./mkimage.sh", \
            "--outdir", "/out", \
            "--arch", "x86_64", \
            "--profile", "mkimg.wyse3040", \
            "--tag", "3.22-wyse3040-f2fs", \
            "--repository", "https://dl-cdn.alpinelinux.org/alpine/v3.22/main", \
            "--repository", "https://dl-cdn.alpinelinux.org/alpine/v3.22/community"]
