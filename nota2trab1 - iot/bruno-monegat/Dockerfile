FROM confluentinc/cp-kafka-connect:latest

COPY serviceAccountKey.json /home/appuser/serviceAccountKey.json

RUN confluent-hub install --no-prompt confluentinc/kafka-connect-firebase:latest