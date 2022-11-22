cd ~
mkdir .nvim_coc
cd .nvim_coc
wget -q --show-progress https://nodejs.org/dist/v18.12.0/node-v18.12.0-linux-x64.tar.xz
wget -q --show-progress https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.tar.gz
tar -xf node-v18.12.0-linux-x64.tar.xz
tar -zxf nvim-linux64.tar.gz
mv node-v18.12.0-linux-x64 node
mv nvim-linux64 nvim
echo 'export PATH="$HOME/.nvim_coc/node/bin:$PATH' >> ~/.zshrc
echo 'export PATH="$HOME/.nvim_coc/nvim/bin:$PATH' >> ~/.zshrc
pip install neovim

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
wget -q --show-progress https://raw.githubusercontent.com/leosmaia21/VIM-CONFIG/main/init.vim
mkdir -p ~/.config/nvim/
mv init.vim ~/.config/nvim/init.vim

wget -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/3270.zip
mkdir fonts
unzip -qq 3270.zip -d fonts/
mv fonts/* ~/.local/share/fonts/
fc-cache -f

echo ""
echo "Tadam!!! Está feito, agora fecha o terminal e volta abrir"
echo "usa o nvim em vez do vim e ao abrir um ficheiro c pela primeira vez"
echo "corre o comando :CocCommand clangd.install"
echo "Aceito MbWay e dinheiro"
 
