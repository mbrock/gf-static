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
RUN cabal install --disable-executable-dynamic --ghc-option=-optl-static --ghc-option=-optl-pthread gf
RUN upx /root/.cabal/bin/gf
