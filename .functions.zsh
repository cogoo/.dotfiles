# Auto switch node version
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" != "N/A" ] && [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use 
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

# Add load-nvmrc function to change directory
add-zsh-hook chpwd load-nvmrc

# List files when switching directory
chpwd() { 
  clear && ls -la; 
}

# Helpers for Nx library
og-nx-add() {
	if [ "$#" = 3 ]; then
    		echo "📦  Creating $1 $2"
    		ng g @nrwl/$1:$2 $3
	else
		echo "🚫  This command requires 3 parameters"
	fi
}
