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
