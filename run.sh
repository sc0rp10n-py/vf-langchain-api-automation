#!/bin/sh
echo "Welcome to Automation with sc0rp10n.py"
echo "Starting now..."
echo "Getting NVM"
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
echo "Saving to profile"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
echo "Starting docker and docker compose process..."
sudo apt-get update
echo "installing certificates"
sudo apt-get install ca-certificates curl gnupg
echo "adding docker official gpg keys"
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "setting up the repository"
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo "installing docker and docker compose now"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose
echo "cloning repo now"
git clone https://github.com/voiceflow/vf-langchain-api.git
echo "going into repo"
cd vf-langchain-api
echo "initiating build"
npm run build
echo "finished"
echo "verify by going to http://45.56.83.54:8123/"
