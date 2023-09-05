# Comparação de Algoritmos para Sincronização e Eleição de Líder em Sistemas Distribuídos - por Eduardo Fockink Silva

## Algoritmo de Berkeley para Sincronização

### Problema Resolvido
Este algoritmo aborda a sincronização de tempo em sistemas distribuídos.

### Funcionamento
Um mestre é escolhido para coordenar a sincronização. Ele consulta todos os outros servidores para obter seus tempos locais, calcula uma média e então informa cada servidor sobre quanto deve ajustar seu relógio.

### Vantagens
- Eficácia na sincronização com um número mínimo de ciclos de comunicação.
- Robustez contra servidores com relógios muito desviados, graças à média.

### Desvantagens
- Ponto único de falha no mestre.
- Não é ideal para sistemas sem um nó claramente mais confiável para atuar como mestre.

### Alternativa: Algoritmo de Cristian

#### Problema Resolvido
Também aborda a sincronização de tempo, mas é frequentemente utilizado em um contexto cliente-servidor.

#### Funcionamento
Um servidor de tempo confiável responde às solicitações dos clientes com o tempo atual. Os clientes ajustam seus relógios com base nessa informação.

#### Vantagens
- Menor complexidade e adequado quando um servidor de tempo externo e confiável está disponível.

#### Desvantagens
- Vulnerável a latência de rede e não adequado para sistemas verdadeiramente distribuídos onde não existe um servidor de tempo confiável.

---

## Algoritmo de Bully para Eleição de Líder

### Problema Resolvido
Eleição de um novo líder em um sistema distribuído.

### Funcionamento
Quando um nó percebe que o líder falhou, ele inicia uma eleição. Cada nó tenta "intimidar" nós com IDs menores, enviando uma mensagem de eleição. O nó com o maior ID se torna o líder.

### Vantagens
- Rapidez na eleição de um novo líder.
- Determinístico, o nó com o maior ID será sempre o líder.

### Desvantagens
- Alto tráfego de rede durante o processo de eleição.
- Ineficiente se o sistema tiver um alto nível de partição ou latência de rede.

### Alternativa: Algoritmo de Anel

#### Problema Resolvido
Também utilizado para eleição de líder, mas de forma mais eficiente em termos de mensagens.

#### Funcionamento
Um token circula pelo anel (rede organizada em topologia de anel). Quando um nó recebe o token e não encontra um líder, ele se declara líder.

#### Vantagens
- Mais eficiente em termos de uso de rede.

#### Desvantagens
- Mais lento para convergir para um líder e pode ser interrompido por falhas de nó.

---

## Conclusão
Ambos os algoritmos, Berkeley e Bully, são fortes candidatos para resolver problemas de sincronização de tempo e eleição de líder, respectivamente. Eles se destacam em termos de eficácia e rapidez, mas têm suas próprias desvantagens em cenários específicos. Em tais casos, os algoritmos alternativos, Cristian e Anel, podem ser mais adequados. A escolha do algoritmo deve ser feita com base em um entendimento claro dos requisitos do sistema e das limitações operacionais.
