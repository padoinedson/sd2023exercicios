
// 'id' serve apenas para identificação do consumer
const consumeMessages = async (consumer, topic, id) => {
    await consumer.connect();

    await consumer.subscribe({ topic: topic, fromBeginning: false });

    await consumer.run({
        eachMessage: async ({ topic, partition, message }) => {
            console.log(`Recebeu mensagem no tópico ${topic}: ${message.value} - ID ${id}`);
        },
    });
};

module.exports = { consumeMessages };
