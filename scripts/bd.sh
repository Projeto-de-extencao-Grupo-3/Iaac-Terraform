#!/bin/bash

# Atualizar sistema
sudo apt update && sudo apt upgrade -y

# Criar pasta da aplicação
sudo mkdir -p /home/gro-track

echo "Script rodou com a criação de pasta"

# Dependências
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y

# Adicionar chave do Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Adicionar repositório
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
| sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualizar novamente após adicionar repo
sudo apt update

# Instalar Docker
sudo apt install docker-ce docker-ce-cli containerd.io -y

# Iniciar Docker
sudo systemctl enable docker
sudo systemctl start docker

# Permitir usuário ubuntu usar docker
sudo usermod -aG docker ubuntu

echo "Script rodou a instalação do docker"

# aguardar docker iniciar
sleep 20

# subir container
docker run -d -p 80:80 --name henriquedandrade/bd-grotrack-v2:bd