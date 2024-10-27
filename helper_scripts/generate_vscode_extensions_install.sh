rm -rf ./install_vscode_extensions.sh
echo "#!/bin/bash" > ./install_vscode_extensions.sh
code --list-extensions | xargs -L 1 echo code --install-extension >> ./install_vscode_extensions.sh
chmod +x ./install_vscode_extensions.sh