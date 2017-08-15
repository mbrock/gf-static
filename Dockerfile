FROM mitchty/alpine-ghc:large
ADD https://github.com/lalyos/docker-upx/releases/download/v3.91/upx /bin/upx
RUN chmod +x /bin/upx
RUN sed -i -e 's/v3\.5/v3.6/g' /etc/apk/repositories
RUN apk add --update bzip2-dev readline-dev readline-static \
&& ln -s /usr/lib/libncursesw.so.6.0 /usr/lib/libncurses.so \
&& ln -s /usr/lib/libncursesw.so.6.0 /usr/lib/libncursesw.so
RUN cabal update && cabal install alex happy
RUN apk add --update ncurses-static \
&& ln -s /usr/lib/libncursesw.a /usr/lib/libncurses.a
ADD http://www.grammaticalframework.org/download/gf-3.9.tar.gz /root/gf
WORKDIR /root/gf/gf-3.9
RUN cabal install --disable-executable-dynamic --ghc-option=-optl-static --ghc-option=-optl-pthread
RUN upx /root/.cabal/bin/gf
RUN cabal build && mkdir gf-3.9-static && mv ~/.cabal/bin/gf gf-3.9-static && \
mv dist/build/rgl gf-3.9-static && tar czf gf-3.9-static.tar.gz gf-3.9-static
