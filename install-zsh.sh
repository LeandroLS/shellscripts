
#!/bin/bash

# Função para exibir mensagens formatadas
info() {
  echo -e "\e[34m[INFO]\e[0m $1"
}

die() {
  echo -e "\e[31m[ERROR]\e[0m $1" >&2
  exit 1
}

# Atualizar pacotes e instalar Zsh
info "Atualizando pacotes..."
sudo apt update -y || die "Falha ao atualizar pacotes. Verifique sua conexão."

info "Instalando Zsh..."
sudo apt install -y zsh || die "Falha ao instalar o Zsh."

# Verificar se o Zsh foi instalado corretamente
if ! command -v zsh &>/dev/null; then
  die "Zsh não foi instalado corretamente."
fi

# Configurar Zsh como shell padrão
info "Configurando Zsh como shell padrão..."
chsh -s $(which zsh) || die "Falha ao configurar Zsh como shell padrão."

# Instalar Oh My Zsh
info "Instalando Oh My Zsh..."
if [ -d "$HOME/.oh-my-zsh" ]; then
  info "Oh My Zsh já está instalado."
else
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || die "Falha ao instalar Oh My Zsh."
fi

# Instalar NVM (Node Version Manager)
info "Instalando NVM..."
if [ -d "$HOME/.nvm" ]; then
  info "NVM já está instalado."
else
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash || die "Falha ao instalar o NVM."
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \ . "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \ . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Instalar Node.js 22
info "Instalando Node.js 22..."
source "$HOME/.nvm/nvm.sh"
nvm install 22 || die "Falha ao instalar Node.js 22."

# Verificar versão do Node.js e npm
info "Verificando instalação do Node.js e npm..."
NODE_VERSION=$(node -v 2>/dev/null)
NPM_VERSION=$(npm -v 2>/dev/null)

if [[ "$NODE_VERSION" == v22* ]]; then
  info "Node.js $NODE_VERSION instalado com sucesso."
else
  die "Falha ao verificar a instalação do Node.js."
fi

if [[ -n "$NPM_VERSION" ]]; then
  info "npm $NPM_VERSION instalado com sucesso."
else
  die "Falha ao verificar a instalação do npm."
fi

info "Configuração concluída com sucesso!"
