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

