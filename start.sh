#!/bin/bash
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install 11
source ~/.bashrc
git clone  https://github.com/eosdac/DACtools
cd DACtools/memberstats
npm install
node export_members_and_voters.js
cp members.csv ../../
cd ../..
