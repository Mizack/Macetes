### LINUX

<hr>

excluir diretorio: `rm -rf diretorio`

criar arquivo: `touch nome_arquivo`

ler o que está escrito no arquivo: `cat nome_arquivo`

procurar termo dentro do arquivo: `cat nome_arquivo | grep "termo"`

contar quantas linhas tem um arquivo: `wc nome_arquivo`

editar arquivo: `nano nome_arquivo`

criar um grupo de segurança para um comando: `sudo usermod -aG docker $USER`

verificar se existe um serviço sendo executado em determinada porta: `sudo lsof -i :porta`

matar o serviço: `sudo kill ID_SERVICO`

<hr>

#### XAMPP

  wget "https://sourceforge.net/projects/xampp/files/XAMPP%20Linux/7.4.27/xampp-linux-x64-7.4.27-2-installer.run/download" -O xampp-installer.run
  
  chmod +x xampp-installer.run
  
  sudo ./xampp-installer.run
  
  iniciar xampp via terminal: sudo /opt/lampp/lampp start
  
  iniciar xampp via interface: sudo /opt/lampp/manager-linux-x64.run

<hr>

#### MYSQL
  
  ##### install

  sudo apt update
  
  sudo apt install mysql-server
  
  sudo systemctl start mysql.service
  
  ### config
  
  sudo mysql
  
  ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
  
  exit
  
  mysql -u root -p
  
  ALTER USER 'root'@'localhost' IDENTIFIED WITH auth_socket;
