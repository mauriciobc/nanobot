# Deploy via Portainer Repository (Plano C)

O Portainer clona o repo e faz o build no host — não precisa de imagem pré-construída.

## Passo 1: Fork e push

1. **Criar fork** no GitHub: acesse https://github.com/HKUDS/nanobot e clique em "Fork"

2. **Configurar remote e fazer push:**
   ```bash
   git remote add fork https://github.com/SEU_USUARIO/nanobot.git
   git push fork main
   ```
   (Substitua `SEU_USUARIO` pelo seu usuário do GitHub)

## Passo 2: Portainer → Add stack → Repository

- **Name:** nanobot
- **Build method:** Repository
- **Repository URL:** `https://github.com/SEU_USUARIO/nanobot`
- **Repository reference:** `refs/heads/main`
- **Compose path:** `stack.yml`

Clique em **Deploy the stack**. O Portainer irá clonar, fazer o build e subir o stack.

## Após o deploy

Rodar `nanobot onboard` para criar o config inicial (troque `SEU_USUARIO` pelo seu usuário):

```bash
docker run --rm -v nanobot_nanobot-data:/root/.nanobot nanobot onboard
```

Edite `~/.nanobot/config.json` no volume e adicione sua API key.
