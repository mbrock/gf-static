build:; docker build -t gf . && \
docker run --rm gf cat /root/.cabal/bin/gf > gf && \
chmod +x gf
