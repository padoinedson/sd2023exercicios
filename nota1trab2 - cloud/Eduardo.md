# Análise de Provedores de Cloud

Os principais fornecedores de serviços de computação em nuvem são conhecidos por oferecer uma gama robusta de produtos e serviços que abrangem infraestrutura como serviço (IaaS), plataforma como serviço (PaaS) e software como serviço (SaaS). Estes são alguns dos principais players, juntamente com uma visão geral de suas ofertas e capacidades técnicas:

## Amazon Web Services (AWS)

- **Ofertas Principais**: EC2, S3, RDS, Lambda, VPC, entre outros.
- **Características Técnicas**: Alta disponibilidade, escalabilidade, uma ampla gama de serviços gerenciados, e uma rede global de data centers.
- **Casos de Uso**: Big Data, Machine Learning, DevOps, e aplicações empresariais.

## Google Cloud Platform (GCP)

- **Ofertas Principais**: Compute Engine, Cloud Storage, BigQuery, Kubernetes Engine, entre outros.
- **Características Técnicas**: Forte em análise de dados, machine learning, e serviços de contêinerização. Oferece infraestrutura baseada em SDN e hardware customizado para otimização de performance.
- **Casos de Uso**: Análise de dados, aplicações de alta performance, machine learning.

## Microsoft Azure

- **Ofertas Principais**: Azure VMs, Azure Kubernetes Service, Azure Functions, Azure DevOps, entre outros.
- **Características Técnicas**: Integração profunda com produtos Microsoft, suporte para uma ampla variedade de linguagens de programação e frameworks, e capacidades de IA e machine learning.
- **Casos de Uso**: Aplicações empresariais, soluções híbridas, IoT.

## Huawei Cloud

- **Ofertas Principais**: Elastic Cloud Server, Cloud Container Engine, Object Storage Service, entre outros.
- **Características Técnicas**: Oferece uma gama completa de serviços de IaaS, PaaS e SaaS. Tem uma forte presença na China e está expandindo globalmente. Suporte para tecnologias de ponta como 5G e AI.
- **Casos de Uso**: IoT, Big Data, aplicações empresariais e móveis.

---

Para esse trabalho, escolhi o AWS, pois tem um bom tier gratuito que me permitirá realizar a segunda parte da atividade inteiramente no ambiente de cloud.

### a) Vantagens e Desvantagens sobre outras empresas

#### Vantagens:

- **Maturidade e Abrangência**: AWS foi um dos primeiros players no espaço de cloud e tem uma gama completa de serviços que abrangem IaaS, PaaS e SaaS.
- **Ecossistema**: Grande número de parceiros, extenso marketplace e uma comunidade ativa.
- **Inovação**: Lançamento constante de novos serviços e recursos.

#### Desvantagens:

- **Complexidade**: Devido à sua ampla gama de serviços, pode ser complexo de gerenciar e otimizar.
- **Custo**: Embora flexível, o modelo de preços pode ser complicado e caro se não for bem gerenciado.

### b) Tipos de serviços oferecidos

#### Escalabilidade:

- **EC2 Auto Scaling**: Permite ajustar automaticamente o número de instâncias EC2 com base em métricas de desempenho e/ou um cronograma.
- **AWS Elastic Beanstalk**: Plataforma como serviço (PaaS) que automatiza o balanceamento de carga, auto scaling e aplicação de patches.
- **AWS Lambda**: Computação sem servidor que escala automaticamente a execução de código em resposta a eventos.

#### Máquinas Virtuais (VM):

- **Amazon EC2**: Oferece uma variedade de tipos de instâncias otimizadas para diferentes casos de uso, desde computação otimizada (C5, C6) até instâncias otimizadas para armazenamento (I3, D2).
- **Amazon Lightsail**: Simplifica o lançamento de uma VM, ideal para aplicações menores e desenvolvedores que preferem uma abordagem mais direta.

#### Container (Docker):

- **Amazon ECS (Elastic Container Service)**: Serviço de gerenciamento de contêineres altamente escalável e de alto desempenho.
- **AWS Fargate**: Oferece execução de contêineres sem a necessidade de gerenciar a infraestrutura subjacente.
- **Amazon EKS (Elastic Kubernetes Service)**: Serviço gerenciado de Kubernetes que facilita a execução de aplicações em contêineres em um cluster Kubernetes.

### c) Localização dos servidores

- **Regiões e Zonas de Disponibilidade**: AWS tem 25 regiões geográficas, cada uma com múltiplas zonas de disponibilidade (AZs) para redundância e failover. Isso permite uma estratégia de implantação global ou localizada.
- **Edge Locations**: Para serviços como Amazon CloudFront e AWS WAF, a AWS tem mais de 220 pontos de presença (PoPs) para otimização de entrega de conteúdo e latência.

### d) Custo

- **Modelo Pay-as-you-go**: Cobrança por hora ou por segundo, dependendo do tipo de instância EC2.
- **Instâncias Reservadas**: Oferecem descontos em troca de um compromisso de uso de longo prazo (1 ou 3 anos).
- **Instâncias Spot**: Permitem usar capacidade sobressalente com descontos de até 90% em relação aos preços sob demanda.
- **AWS Cost Explorer e AWS Budgets**: Ferramentas para monitoramento e planejamento de custos.
- **Free Tier**: Inclui 750 horas de instâncias EC2 t2.micro ou t3.micro por mês durante o primeiro ano, entre outros recursos.

### e) Empresas que utilizam/contratam os serviços

- **Grandes Corporações**: Empresas como Netflix, Airbnb e Samsung utilizam a AWS para suportar infraestruturas de grande escala e alta disponibilidade.
- **Startups**: Muitas startups optam pela AWS devido à sua flexibilidade e gama de serviços que facilitam o rápido crescimento.

### f) Tipos de Segurança - SLA

- **Segurança**: Várias camadas de segurança, incluindo firewalls, criptografia e controles de acesso.
- **SLA**: Compromissos de disponibilidade variam de acordo com o serviço, mas para EC2 e S3, por exemplo, é de 99,99%.

### g) Qual você contrataria? Justifique a sua escolha

Se eu estivesse em um ambiente empresarial com uma variedade de necessidades, desde computação e armazenamento até machine learning e análise de dados, eu escolheria a AWS. A razão é sua maturidade, robustez e abrangência de serviços, que podem atender a quase qualquer requisito técnico. Além disso, a AWS tem um forte ecossistema de parceiros e uma grande comunidade, o que pode ser valioso para suporte e integração.

No entanto, essa escolha dependeria do caso de uso específico, requisitos técnicos e orçamento disponível. Para projetos menores ou mais simples, outros provedores como DigitalOcean ou até mesmo o Free Tier de outros grandes provedores poderiam ser mais apropriados.
