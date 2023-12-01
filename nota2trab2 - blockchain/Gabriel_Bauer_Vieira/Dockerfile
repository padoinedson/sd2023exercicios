FROM ethereum/client-go:v1.10.1

ARG ACCOUNT_PASSWORD

COPY ethereum/genesis.json /tmp

RUN geth init /tmp/genesis.json
RUN rm -f ~/.ethereum/geth/nodekey
RUN echo ${ACCOUNT_PASSWORD} > /tmp/password && geth account new --password /tmp/password && rm -f /tmp/password

ENTRYPOINT ["geth"]