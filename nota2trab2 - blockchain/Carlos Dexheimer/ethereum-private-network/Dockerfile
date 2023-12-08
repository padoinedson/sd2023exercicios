FROM ethereum/client-go:v1.10.1

COPY genesis.json /tmp

RUN geth init /tmp/genesis.json
RUN rm -f ~/.ethereum/geth/nodekey
RUN echo 123456789 > /tmp/password && geth account new --password /tmp/password && rm -f /tmp/password

ENTRYPOINT ["geth"]