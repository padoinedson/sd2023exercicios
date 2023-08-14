# Github

## 1 - Transparência:
A transparência do Github é muito perceptível visto que ele, sendo uma das maiores e mais utilizadas plataformas de hospedagem de código e de gerenciamento de versionamento, é um sistema distribuído extremamente complexo, tendo que lidar com enormes quantidades de dados e interações simultâneas de usuários em repositórios. Aos usuários todos os processos internos são transparentes, visto que não há necessidade de interagir diretamente com eles para se usar o serviço do Github por completo, podendo acessar diretamente a interface que os abstrai. Isso faz parecer ao usuário que o sistema, que é distribuído, funcione como um só. 

## 2 - Heterogeneidade:
A heterogeneidade está presente no sistema do Github. Em nível de hardware pode-se considerar o hardware dos servidores físicos utilizados, que são, provavelmente, muito distintos entre si. Em nível de sistemas operacionais há, por exemplo, o sistema utilizado pelos servidores, que na maioria das máquinas deve ser Linux, e os sistemas usados pelos usuários, que podem ser de qualquer tipo. Em nível de linguagens de programação essa heterogeneidade é muito presente já que há funcionalidades internas do Github e ferramentas programadas em mais de 10 linguagens diferentes.

## 3 - Flexibilidade:
Em questão da flexibilidade, o Github é expansível por ter a opção de alocar mais hardware de servidores caso haja uma demanda maior. Além disso, ele possui uma vasta documentação e um sistema modular em camadas. Também é possível haver interoperabilidade com outros sistemas, sendo o Git o mais notável deles.

## 4 - Segurança:
A segurança no Github é reforçada, principalmente graças a alguns recursos que foram implementados recentemente, que permitem a criação de chaves criptografadas para a realização de operações com repositórios e acesso a contas de usuário. Além disso, por ser uma plataforma muito grande, ele com certeza possui diversos sistemas e protocolos mais complexos que garantem a segurança em camadas mais profundas, que não sejam a de usuário, como firewalls, proteção à integridade e confidencialidade dos dados, autenticação por meio de certificados e assinaturas digitais e garantia de disponibilidade dos recursos.

## 5 - Escalabilidade:
Assim como em relação à flexibilidade, o sistema inteiro do Github é escalável e extensível.  O Github está a todo momento sofrendo flutuações na quantidade de acessos aos seus serviços, e ele precisa garantir que a experiência dos usuários não seja afetada nem mesmo em casos extremos com grandes quantidades de acessos simultâneos, como também que recursos não estejam sendo desperdiçados caso haja uma redução no número de acessos. Uma das principais formas para tornar um sistema escalável é hospedá-lo em nuvem já que os recursos utilizados serão variáveis e estarão constantemente se adaptando à demanda.

## 6 - Tolerância a Falhas:
Em relação à tolerância e ao tratamento de falhas, o Github deve fazer uso de mecanismos como o checksum, para a detecção de problemas, e RAID, para a redundância de dados, garantindo que mesmo que haja problemas isolados no hardware de armazenamento os dados não sejam perdidos, permitindo que as falhas sejam mascaradas. Caso não seja possível detectar ou mascarar alguma falha, o sistema deve ter métodos de recuperação para reduzir os danos, como uso de dados permanentes junto com algoritmos de rollback.

## 7 - Concorrência:
A concorrência pode ser considerada uma das principais características de um sistema distribuído. O sistema do Github é concorrente ao usar recursos compartilhados e sincronizados. Isso deve possibilitar múltiplas requisições simultâneas de usuários em todos os serviços disponíveis. Além disso, deve-se haver uma correta comunicação entre as diferentes camadas do sistema de forma síncrona, garantindo a execução concorrente das tarefas solicitadas.
