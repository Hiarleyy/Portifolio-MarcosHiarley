# Guia de Deploy no Portainer via Docker Hub

Este guia explica passo a passo como gerar a imagem de produção do seu portfólio, enviá-la para o Docker Hub e realizar o deploy utilizando o Portainer Stacks.

---

## Pré-requisitos

1. **Docker e Docker Compose** instalados localmente.
2. Conta ativa no **Docker Hub** (com um repositório configurado/pronto para aceitar imagens).
3. Acesso ao painel do **Portainer** onde a stack será criada.

---

## Passo 1: Construir e Enviar a Imagem para o Docker Hub

Antes de criar a stack no Portainer, é preciso enviar a imagem da aplicação (Rails) atualizada para o Docker Hub.

### 1.1 Fazer Login no Docker Hub pelo Terminal
Abra o seu terminal local e execute:
```bash
docker login
```
Insira o seu nome de usuário e a senha ou token de acesso do Docker Hub.

### 1.2 Compilar e Puxar a Imagem (Automático)
Criamos scripts utilitários para automatizar a compilação e o envio. Rode o comando apropriado para o seu sistema:

#### No Windows (PowerShell):
```powershell
.\bin\build-and-push.ps1 -Username seu_usuario_dockerhub -Tag latest
```

#### No Linux / macOS / WSL (Bash):
```bash
chmod +x ./bin/build-and-push.sh
./bin/build-and-push.sh seu_usuario_dockerhub latest
```

*Substitua `seu_usuario_dockerhub` pelo seu username do Docker Hub.*

---

## Passo 2: Configurar o Portainer Stack

O Portainer gerencia projetos usando "Stacks", que utilizam a sintaxe do Docker Compose.

1. Acesse o seu painel do **Portainer**.
2. No menu lateral esquerdo, clique em **Stacks** e depois em **+ Add stack**.
3. Defina o nome da Stack, por exemplo: `portfolio`.
4. No campo **Build method**, certifique-se de que **Web editor** está selecionado.
5. Copie e cole o conteúdo do arquivo [docker-compose.prod.yml](file:///d:/portifolio/docker-compose.prod.yml) no editor de texto.

---

## Passo 3: Configurar as Variáveis de Ambiente no Portainer

Abaixo do editor da stack no Portainer, você encontrará a seção **Environment variables**. Clique em **Add environment variable** (ou selecione a opção de edição avançada/bulk para colar várias de uma vez) e adicione as seguintes variáveis:

| Variável | Descrição / Valor Recomendado | Exemplo |
| :--- | :--- | :--- |
| `DOCKERHUB_USERNAME` | Seu nome de usuário no Docker Hub para puxar a imagem. | `hiarley` |
| `PORT` | Porta que o container web irá expor no servidor host (padrão: `3000`). | `3000` |
| `DB_USER` | Usuário para o banco de dados PostgreSQL (padrão: `portfolio`). | `portfolio` |
| `DB_PASSWORD` | **(Obrigatório)** Senha forte para o banco de dados de produção. | `SenhaForteProducao123!` |
| `DB_NAME` | Nome do banco de dados de produção (padrão: `portfolio_production`).| `portfolio_production` |
| `RAILS_MASTER_KEY` | **(Crítico)** A chave secreta contida no arquivo local `config/master.key` para desencriptar credenciais. | *(Copie o conteúdo de config/master.key)* |
| `SMTP_USERNAME` | O email do Gmail usado para enviar mensagens. | `seuemail@gmail.com` |
| `SMTP_PASSWORD` | A senha de aplicativo de 16 dígitos gerada no Gmail. | `xxxx_xxxx_xxxx_xxxx` |
| `CONTACT_EMAIL` | O email que irá receber as mensagens do formulário de contato. | `destino@gmail.com` |
| `APP_HOST` | Domínio ou IP do servidor onde a aplicação estará rodando. | `marcoshiarley.insilico.cloud` |
| `SMTP_DOMAIN` | Domínio de envio do SMTP (para identificar a aplicação ao servidor SMTP). | `gmail.com` |

---

## Passo 4: Implantar a Stack

Depois de preencher as variáveis de ambiente:

1. Clique no botão **Deploy the stack** na parte inferior da tela do Portainer.
2. O Portainer irá:
   - Criar uma rede dedicada para a Stack.
   - Criar e montar os volumes persistentes (`postgres_data` e `storage_data`).
   - Baixar a imagem Postgres oficial.
   - Baixar a imagem do seu portfólio que você enviou ao Docker Hub.
   - Iniciar o banco de dados.
   - Executar o `docker-entrypoint` para realizar as migrações pendentes e criar o banco se necessário.
   - Iniciar o servidor web Rails.

---

## Atualizações Futuras

Sempre que fizer alterações no código do portfólio:
1. Recompile e envie a imagem rodando o script:
   `.\bin\build-and-push.ps1` (ou `./bin/build-and-push.sh`).
2. Acesse a Stack no **Portainer**, clique em **Editor**, role até o final e ative a opção **Pull latest image** (se o tag for o mesmo, ex: `latest`).
3. Clique em **Update the stack**. O container web será recriado usando a versão mais recente da imagem com zero de downtime ou downtime mínimo.

---

## Observação sobre SSL/HTTPS (Reverse Proxy)

Como a aplicação Rails está configurada para forçar o uso de SSL (`config.force_ssl = true` em produção), certifique-se de configurar um proxy reverso (como Nginx Proxy Manager, Traefik, Caddy ou Cloudflare) apontando para o seu container na porta configurada (padrão `3000`) com suporte a SSL habilitado para o domínio **`marcoshiarley.insilico.cloud`**. Isso garante que todo o tráfego seja criptografado de ponta a ponta e que os cookies de segurança funcionem perfeitamente.

