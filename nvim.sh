cd ~
mkdir .nvimcoc
cd .nvimcoc
echo "Download node nvim clangd e fontes"
wget -q --show-progress https://nodejs.org/dist/v18.12.1/node-v18.12.1-linux-x64.tar.xz
wget -q --show-progress https://github.com/neovim/neovim/releases/download/v0.8.0/nvim-linux64.tar.gz
wget -q --show-progress https://github.com/clangd/clangd/releases/download/15.0.6/clangd-linux-15.0.6.zip
wget -q --show-progress https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/3270.zip

echo "A extrair ficheiros"
tar -xf node-v18.12.1-linux-x64.tar.xz
tar -zxf nvim-linux64.tar.gz
unzip  -qq clangd-linux-15.0.6.zip
mv node-v18.12.1-linux-x64 node
mv nvim-linux64 nvim
mv clangd_15.0.6 clangd

mkdir fonts
unzip -qq 3270.zip -d fonts/
mv fonts/ ~/.fonts/

pip -q install neovim

echo 'export PATH="$HOME/.nvimcoc/node/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="$HOME/.nvimcoc/clangd/bin:$PATH"' >> ~/.zshrc
echo 'export PATH="$HOME/.nvimcoc/nvim/bin:$PATH"' >> ~/.zshrc


rm *.zip
rm *.tar.*

cd ~/.config
git clone https://github.com/leosmaia21/VIM-CONFIG.git nvim
fc-cache -f

echo ""
echo "Tadam!!! Fecha o terminal e volta abrir"
echo "usa o nvim em vez do vim"
echo "Aceito MbWay e dinheiro"
source ~/.zshrc
