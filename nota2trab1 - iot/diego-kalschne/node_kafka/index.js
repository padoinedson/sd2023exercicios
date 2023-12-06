const { Kafka, logLevel } = require('kafkajs');

const { produceMessage } = require('./src/producer');
const { consumeMessages } = require('./src/consumer');

const BASE_HOST = '192.168.0.105'; //Endereço do host do broker do Kafka

// Configuração da instância do Kafka
const kafka = new Kafka({
    clientId: 'kafka-app',
    brokers: [`${BASE_HOST}:9092`], // Não precisa ser definido todas as portas aqui. Definindo apenas uma, as demais são reconhecidas automaticamente
    ssl: false,
    authenticationTimeout: 30000,
    connectionTimeout: 30000,
    requestTimeout: 30000,
    logLevel: logLevel.NOTHING,
});

// Inicializando um produtor
const producer1 = kafka.producer();

//Criação de 2 consumers com mesmo 'group'
const consumer1 = kafka.consumer({ groupId: 'groupString' });
const consumer2 = kafka.consumer({ groupId: 'groupString' });
consumeMessages(consumer1, 'usuarios', '1');
consumeMessages(consumer2, 'usuarios', '2');


// Delay com await
async function delay() {
    return new Promise(resolve => {
        setTimeout(() => {
            resolve();
        }, 1000);
    });
}

// Função com delay para publicar mensagem no tópico várias vezes
// Utilizado para testar o consumo de mensagens com um 'group' definido
async function publishWithDelay() {
    let x = 0;

    while (true) {
        produceMessage(producer1, 'usuarios', [{ value: `Mensagem número: ${x}` }]);
        x++;
        await delay();
    }
}

publishWithDelay();
