const produceMessage = async (producer, topic, message) => {
  try {
    await producer.connect();

    await producer.send({
      topic: topic,
      messages: message,
    });

  } catch (err) {
    console.error(`Erro ao publicar no tópico ${topic}`);
  } finally {
    await producer.disconnect();
  }
};

module.exports = { produceMessage }
