### Rodar Container

O docker run verifica se a imagem já existe, se não, vai no docker hub e baixa; caso exista, ele executa.

`docker pull` - baixar a imagem

`docker run container` - executar um container

`docker run container --name nome_container` - executar um container e dar um nome a ele

`docker run container comando` - executar um container e executar um comando

`docker run -d container` - executar um container sem travar o terminal

`docker run -d -P container` - define automaticamente qual porta do host a aplicação irá ser executada

`docker run -d -p 8080:80 container` - define automaticamente qual porta do host a aplicação irá ser executada (host:docker)

### Listar Container

`docker ps` & `docker container ls` - lista os containers que estão rodando naquele momento

`docker ps -a` & `docker container ls -a` - lista todos os containers que já foram executados naquele host

`docker inspect` - detalhar container

`docker info` - listar informações do docker naquela máquina

### Estados do container

essas ações podem ser feitas pelo ID do container

`docker start container` - inicia um container

`docker stop container` - para um container

`docker stop -t=0 container` - parar um container imediatamente

`docker pause container` - pausa a execução de um container

`docker unpause container` - "despausa" a execução de um container

`docker rm container` - exclui um container

### Execução de comandos

pode ser feito de maneira iterativa com a tag -it.

`docker exec container comando` - executa um comando dentro do container

`docker exec -it container comando` - executa um comando de maneira iterativa dentro do container

`docker exec -it container sh` - acessar terminal do container

### Listar imagens

`docker images` & `docker images ls` - listar imagens baixadas no host

`docker inspect imagem` - detalhar imagem

`docker history imagem` - exibe camadas da imagem

### Criar imagem

para criar uma imagem, é necessário ter um Dockerfile. Nele, serão feitas as configurações necessárias para o funcionamento da aplicação.

- Exemplo: <a href="https://github.com/Mizack/Macetes/blob/main/Dockerfile">Dockerfile</a>

com o Dockerfile criado, dentro do diretório do projeto:

`docker build -t <seu-nome-de-usuario-do-docker-hub>/app-node:1.0 .` - criar imagem (tag -t é para criar nome)

### Subir imagem para o docker hub

`docker login -u nome_user` - fazer login

`docker push nome_user/nome_app:1.0` - fazer upload da imagem

`docker tag nome_user/nome_app_antigo:1.0 nome_user/nome_app:1.0` - mudar nome da imagem

### Excluir imagem

`docker rmi imagem`

### Persistência de dados

##### BIND - utiliza um diretório do host para persistir os dados

`docker run –it –v /diretorio/no/host:/pasta/container container comando` - BIND

`docker run –it --mount type=bind,source=/diretorio/no/host,target=/pasta/container container comando` - BIND

##### VOLUME - um espaço de memória gerenciado pelo Docker

`docker volume` && `docker volume ls` - listar volumes do docker

`docker volume create nome-volume` - criar volume

`docker run –it –v nome-volume:/pasta/container container comando` - VOLUME

`docker run -it --mount source=nome-volume, target=/pasta/container container comando` - VOLUME

##### TMPFS - o dado da persistencia só existe enquanto o container está em funcionamento

`docker run -it --tmpfs=/pasta/container container comando` - TMPFS

`docker run –it --mount type=tmpfs,destination=/pasta/container container comando` - TMPFS

### Redes

A rede host remove o isolamento entre o container e o sistema, enquanto a rede none remove a interface de rede.

`docker network ls` - listar redes disponíveis

`docker network create --driver bridge minha-bridge` - criar uma rede nova

`docker run -d --name nome-container --network minha-bridge container comando` - rodar container usando rede criada

### Compose

Ele é responsável por organizar os containers de modo que todos sejam executados simultâneamente

- Exemplo: <a href="https://github.com/Mizack/Macetes/blob/main/docker-compose.yml">docker-compose.yml</a>

`docker-compose up -d` - executa o passo a passo descrito no docker-compose.yml

`docker-compose ps` - lista quais "composes" estão rodando

`docker-compose down` - matar a execução do compose

### Docker Machine

`docker-machine ls` - listar vms rodando

`docker-machine create -d driver nome-virtual` - criar uma máquina virtual. Adicionar `--virtualbox-no-vtx-check` antes do nome da vm

`docker-machine start nome-virtual` - inicia uma virtual

`docker-machine ssh nome-virtual` - acessar virtual via SSH

### Swarm

`docker swarm init --advertise-addr ip-vm` - iniciar o swarm. A máquina em que esse comando for executado, será a gerenciadora dos outros participantes do cluster

`docker swarm join --token token-manager ip-manager` - adicionar um worker ao swarm

`docker swarm join-token worker` - retorna o comando com o token do manager para adicionar novos workers

`docker node ls` - listar workers do cluster. Isso só pode ser executado em um manager

`docker node ls --format "{{.Coluna1}} {{.Coluna2}}"` - filtrar colunas que serão mostradas

- Remover um worker do swarm

  `docker swarm leave` - dentro do worker

  `docker node rm id-worker` - dentro do manager

`docker node inspect worker` - detalha um worker

`docker service create -p host:vm imagem` - inicia um serviço

`docker service ls` - lista os servicos que estão sendo executados

`docker service ps id-vm` - lista detalhes do serviço

* Routing mesh - faz o redirecionamento de serviços dentro de um swarm. Permite acessar um serviço que é executado em um nó a partir de qualquer IP que esteja associado ao swarm

* Quando um manager cai, os servicos continuam rodando nos outros "nós" do swarm. A partir dessa queda, não é mais possível gerenciar o estado do swarm a nao ser que tenha backup.

* Criar um backup do swarm:
  
  `cp -r /var/lib/docker/swarm/ pasta-backup` - copiar conteúdo da pasta do swarm para uma pasta de backup
  
  `cp -r pasta-backup/* /var/lib/docker/swarm/` - copiar backup para a pasta do swarm
  
  `docker swarm init --force-new-cluster --advertise-addr ip-vm` - recriar o swarm
  
* Criar novos managers:
  
  `docker swarm join-token manager` - descobrir qual o hash para associar um manager (dentro do atual manager)

  `docker swarm join --token token-manager ip-manager` - tornar um novo manager (dentro do novo manager)
  
Quando o manager cai, a responsabilidade é reatribuida a outro manager "Reachable". Caso tenha mais de um nesse status, é aplicado o algoritmo RAFT:

  * SUPORTA: (N-1)/2 Falhas

  * MINÍMO: (N/2)+1 Quórum

  <i>N = nº Managers</i>
  
 * Remover um manager do cluster:

  `docker node demote nome-vm` - rebaixar a VM de manager para worker
  
  `docker node rm nome-vm` - remover a VM do cluster
  
`docker node update --availability drain nome-vm-manager` - evitar que manager execute serviços

`docker service update --constraint-add node.role==worker id-servico` - informa ao serviço que ele só pode ser executado em um "nó" worker

`docker service update --replicas N id-servico` - informa quantas replicas desse serviço existirão (N = nº de réplicas). Caso haja um nº maior de réplicas do que máquinas, algumas máquinas terão mais de 1 serviço.

`docker service scale id-servico=N` - outra forma de chegar ao resultado do comando acima

`docker service create -p host:vm --mode global imagem` - cria um serviço de maneira global, ou seja, todos os "nós" do cluster terão esse serviço rodando. Isso serve para executar serviços que obrigatoriamente devem rodar, como serviços de análise de segurança.
