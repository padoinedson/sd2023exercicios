# T1 - Problemas Clássicos de Sistemas Distribuídos

## Melhor algoritmo de Sicronização: Algoritmo de Cristian
Em um contexto de sistemas distribuídos, o Algoritmo de Cristian pode ser considerado um dos melhores ao fornecer uma solução simples porém capaz de alcançar uma alta precisão. 
Esse algoritmo exige que exista um servidor de tempo para fazer a sincronização, o qual deve conter uma fonte temporal precisa, como um relógio atômico.
O principal objetivo desse algoritmo é anular a perda de precisão causada pela latência durante a transmissão da informação de tempo entre o servidor de tempo e os sistemas relacionados. 
Isso é alcançado ao se calcular o diferencial do tempo desde a requisição feita ao servidor até a chegada dos dados, somando esse tempo ao tempo universal recebido.
Apesar de tudo isso, esse algoritmo apresenta algumas desvantagens, as quais fazem com que ele não seja o mais utilizado para a maioria dos cenários computacionais atualmente, sendo superado por algoritmos mais completos, como NTP.

## Melhor algoritmo de Eleição de Líder: Algoritmo de Bully
Em relação aos algoritmos de eleição de líder, a escolha do melhor pode depender muito da aplicação em que ele será implementado.
Podem-se considerar como os dois principais algoritmos o Algoritmo de Anel e o Algoritmo de Bully. 
Ambos os algoritmos têm como objetivo escolher um nó principal como o responsável por uma rede com vários nós. Além disso, eles garantem que os outros nós da rede sejam candidatos a se tornarem líderes caso o nó principal fique indisponível.
O Algoritmo de Anel é geralmente utilizado para redes locais que são fisicamente dispostas em formato de anel. 
Ele pode não ser ideal em sistemas complexos, visto que caso um nó seja desconectado os nós que estão próximos das bordas acumularão uma grande latência na comunicação.
Por outro lado, o Algoritmo de Bully é disposto em forma de malha, sendo que cada nó está conectado com todos os outros. O nó líder a ser escolhido é sempre o que possui o maior valor, como o Process ID, dentro da rede. 
O problema dele está no fato de que um nó aleatório deve se eleger ao haver a necessidade de troca de líder. Caso esse nó tenha um valor muito baixo na rede, podem surgir problemas de performance ao haver a necessidade de se fazer diversos processos de eleição até se chegar a um acordo.
Nesse contexto, o Algoritmo de Bully se destaca por ser mais utilizável em sistemas embarcados e assíncronos ao possuir uma maior confiabilidade.
