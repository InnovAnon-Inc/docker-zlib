FROM innovanon/doom-base as zlib
ARG LFS=/mnt/lfs
USER lfs
RUN sleep 31 \
 && git clone --depth=1 --recursive       \
      https://github.com/madler/zlib.git    \
 && cd                        zlib        \
 && ./configure --64 --static --const     \
 && make                                  \
 && make DESTDIR=/tmp/zlib install        \
 && cd           /tmp/zlib                \
 && strip.sh .                            \
 && tar acf        ../zlib.txz .          \
 && rm -rf       $LFS/sources/zlib

FROM scratch as final
COPY --from=zlib /tmp/zlib.txz /tmp/

