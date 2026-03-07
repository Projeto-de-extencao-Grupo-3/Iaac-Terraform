#!/bin/bash

# Atualizar sistema
sudo apt update && sudo apt upgrade -y

# Criar pasta da aplicação
sudo mkdir -p /home/gro-track
# baixar chave do S3
aws s3 cp s3://grotrack-bucket-client/keys/key-grotrack.pem /home/gro-track/key-grotrack.pem
chmod 400 /home/gro-track/key-grotrack.pem

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

# teste do lb
sudo apt install apache2 -y
sudo tee /var/www/html/index.html > /dev/null <<'EOF'
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>GroTrack</title>

<style>
body{
    margin:0;
    font-family: Arial, Helvetica, sans-serif;
    background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    color:white;
}

.container{
    text-align:center;
    background: rgba(0,0,0,0.5);
    padding:50px;
    border-radius:12px;
    box-shadow:0 10px 25px rgba(0,0,0,0.3);
}

h1{
    font-size:42px;
    margin-bottom:10px;
}

.status{
    font-size:20px;
    margin-top:20px;
    color:#00ff9c;
}

.footer{
    margin-top:30px;
    font-size:14px;
    opacity:0.8;
}
</style>
</head>

<body>

<div class="container">
    <h1>🚀 GroTrack</h1>
    <h2>Sistema Online</h2>

    <div class="status">
        ✅ Load Balancer funcionando
    </div>

    <div class="footer">
        Infraestrutura AWS | Terraform
    </div>
</div>

</body>
</html>
EOF

sudo systemctl restart apache2