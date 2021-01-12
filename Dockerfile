FROM innovanon/doom-base as zlib
ARG LFS=/mnt/lfs
USER lfs
RUN tor --verify-config                 \
 && command -v strip.sh                 \
 && touch test                          \
 && rm -v test                           \
 && sleep 91 \
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
      # TODO
#"${CONFIG_OPTS[@]}"                 \

FROM scratch as final
COPY --from=zlib /tmp/zlib.txz /tmp/

