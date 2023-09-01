Atividade da apresentação sobre os algoritmos

Sincronização

lamperd - Cada processo tem um contador (relógio lógico);
	  Um evento de envio de mensagem carrega seu marcador de hora;
	  Contador é atribuído a um evento como seu marcador de hora;

peterson -  Usado para exclusão mútua e permite que dois processos compartilhem um recurso de uso único sem conflito;
	    Ele usa apenas memória compartilhada para comunicação;
	    A fórmula de Peterson originalmente trabalhava apenas com dois processos, mas desde então foi generalizada por mais de dois;
	    
Qual é melhor: E dificil falar qual o melhor, basta saber qual o usuario e pra q o usuario deseja.


	    
Eleição de Lider

Anel - Muitas vezes não importa qual o processo é escolhido como líder, desde que alguém seja eleito;
       Todos os processos participantes devem concordar com a escolha do novo líder;
       Servidores que usam replicação passiva (Harp);
       Processo sequenciador em algoritmos de comunicação multicast (Amoeba);

Bully ou Ditador - Estes processos se comunicam apenas com seus vizinhos no sentido horário;
		   Quando um processo Pi percebe que o processo líder não responde mais à requisições de outros processos, ele inicia uma eleição;
		   Cada processo possui um identificador (ID) único, que funciona como sendo uma espécie de "força" que o processo possui, de modo que, aquele processo com a maior "força" pode ser 		 considerado o líder em uma eleição;

Qual é melhor: Tanto o Bully como o Anel possuim seus defeitos, se na topografia em anel um  nó danificar ou parar de funcionar ela vai fazer com que o processo nao continue e chega nele e trava nao deixando passar para outros, De outra forma, No bully nao vai acontecer isso, pois esta interconectados todos com todos, e se der erro em 1 nó sendo ele como lider, o rimeiro que senti falta deque o lider falhou, ele vai se candidatar pra ser o lider, so que se ele for um nó com o indicador for menor com os outros, ele vai fazer fizar num looping ate achar qual o nó com maior indicador.

A topografia em Anel e melhor pra sistemas grandes, porque o Bully ate eleger um novo lider, num sistema grande, vai perde muito tempo.

