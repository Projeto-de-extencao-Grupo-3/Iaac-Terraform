# GroTrack - Infraestrutura AWS com Terraform

Este repositório contém a infraestrutura do projeto **GroTrack** utilizando **Terraform** para provisionar recursos na **AWS (Amazon Web Services)**.

A infraestrutura cria automaticamente diversos componentes necessários para uma aplicação distribuída, incluindo rede, instâncias de computação, balanceamento de carga, monitoramento, armazenamento e automação de instalação de containers.

---

# 📂 Estrutura do Repositório

## provider.tf

Configura o provedor da AWS utilizado pelo Terraform.

Define:

* Provider AWS
* Região onde os recursos serão criados

Exemplo de região utilizada:

```
us-east-1
```

---

# vpc.tf

Cria a rede principal do projeto utilizando **VPC (Virtual Private Cloud)**.

Define:

* CIDR da rede
* DNS Hostnames
* DNS Support

Essa VPC é utilizada por todos os recursos da infraestrutura.

---

# subnets.tf

Define as subnets utilizadas pela infraestrutura.

### Subnet privada

Utilizada para serviços internos:

* Backend
* API
* Banco de dados

### Subnets públicas

Utilizadas para serviços expostos à internet:

* Frontend
* Load Balancer

Distribuídas em múltiplas Availability Zones para maior disponibilidade.

---

# network.tf

Configura os componentes de rede da infraestrutura.

Cria:

* Internet Gateway
* NAT Gateway
* Elastic IP
* Route Tables públicas e privadas
* Associações das subnets às rotas

Isso permite:

* Instâncias públicas acessarem a internet
* Instâncias privadas acessarem a internet através do NAT Gateway

---

# security_groups.tf

Define os **Security Groups** da aplicação.

Controla:

* Portas abertas
* Comunicação entre serviços
* Acesso SSH
* Tráfego interno da VPC

### Regras principais

Frontend

* HTTP (80)
* HTTPS (443)

Frontend → Backend

* Porta 8080

Backend → Database

* Porta 3306

SSH

* Acesso externo permitido apenas ao frontend
* Acesso interno aos demais serviços

---

# keypair.tf

Cria a chave SSH utilizada para acessar as instâncias EC2.

Utiliza o recurso **Key Pair** da AWS.

A chave pública `.pub` é enviada para a AWS e a chave `.pem` deve permanecer local para acesso SSH às instâncias.

---

# ec2.tf

Cria as instâncias do projeto.

Instâncias criadas:

| Instância          | Função                    |
| ------------------ | ------------------------- |
| frontend-grotrack  | Servidor frontend         |
| frontend2-grotrack | Segundo servidor frontend |
| backend-grotrack   | Servidor backend          |
| db-grotrack        | Banco de dados            |
| api-grotrack       | API da aplicação          |

Cada instância executa automaticamente um **script de inicialização (user_data)** que:

* Atualiza o sistema
* Instala Docker
* Prepara o ambiente da aplicação

---

# loadbalancer.tf

Cria o balanceamento de carga da aplicação.

Componentes criados:

* Application Load Balancer
* Target Group
* Listener HTTP
* Associação das instâncias frontend ao target group

O Load Balancer distribui automaticamente o tráfego entre:

* frontend-grotrack
* frontend2-grotrack

---

# cloudwatch.tf

Configura monitoramento de CPU para todas as instâncias.

São criados alarmes para:

* frontend
* frontend2
* backend
* api
* database

Caso o uso de CPU ultrapasse **70%**, um alerta é disparado.

---

# sns.tf

Cria um sistema de notificações por e-mail.

Quando um alarme do CloudWatch dispara, uma notificação é enviada automaticamente para o e-mail configurado.

---

# s3.tf

Cria buckets S3 utilizados pela aplicação.

Buckets criados:

| Bucket                  | Finalidade                      |
| ----------------------- | ------------------------------- |
| grotrack-bucket-raw     | armazenamento de dados brutos   |
| grotrack-bucket-trusted | armazenamento de dados tratados |
| grotrack-bucket-client  | dados prontos para consumo      |

---

# outputs.tf

Exibe informações importantes após a criação da infraestrutura.

Retorna:

* IP público das instâncias frontend
* IP privado das instâncias frontend
* IP privado das instâncias backend
* IP privado da API
* IP privado do banco de dados

Essas informações facilitam conexões SSH e integrações entre serviços.

---

# scripts/

Pasta contendo os scripts executados automaticamente nas instâncias EC2.

Exemplo de estrutura:

```
scripts/
default.sh
frontend.sh
backend.sh
api.sh
db.sh
```

Esses scripts são responsáveis por:

* Instalar Docker
* Configurar o ambiente
* Executar containers da aplicação

---

# 🚀 Como Usar

## 1️⃣ Configurar credenciais AWS

Configure suas credenciais antes de executar qualquer comando:

```
aws configure
```

Ou utilize variáveis de ambiente caso utilize credenciais temporárias.

---

# 2️⃣ Inicializar o Terraform

```
terraform init
```

Esse comando baixa os providers necessários.

---

# 3️⃣ Validar a configuração

```
terraform validate
```

Verifica se há erros de sintaxe nos arquivos Terraform.

---

# 4️⃣ Visualizar o plano de execução

```
terraform plan
```

Mostra quais recursos serão criados ou modificados antes da aplicação.

---

# 5️⃣ Criar a infraestrutura

```
terraform apply
```

Provisiona todos os recursos na AWS.

---

# 6️⃣ Destruir a infraestrutura

Caso seja necessário remover todos os recursos criados:

```
terraform destroy
```

---

# ⚠️ Pontos Importantes

* Alterações em **security_groups.tf** podem modificar regras de acesso da aplicação.
* Alterações em **ec2.tf** podem recriar instâncias.
* A chave **.pem** deve ser mantida em segurança para acesso SSH.
* Sempre execute `terraform plan` antes de aplicar alterações.

---

# 📌 Observação

Toda a infraestrutura foi criada utilizando **Infrastructure as Code (IaC)** com Terraform, permitindo que o ambiente seja reproduzido de forma rápida, segura e versionada.