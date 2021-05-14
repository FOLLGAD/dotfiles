# https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary
curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer
chmod +x ~/.local/bin/rust-analyzer
echo 'Ensure $HOME/.local/bin is in the $PATH variable'

npm i -g pyright
npm i -g prettier eslint typescript
