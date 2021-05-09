# Check http://releases.llvm.org/download.html#10.0.0 for the latest available binaries
FROM gcc:latest

COPY nvmconfig/ /root/dotfiles/
WORKDIR /root

# Make sure the image is updated, install some prerequisites,
# Download the latest version of Clang (official binary) for Ubuntu
# Extract the archive and add Clang to the PATH
RUN apt-get update && apt-get install -y \
  xz-utils apt-utils cscope exuberant-ctags screen tmux \
  build-essential python3-venv python3-pip \
  curl wget cmake tree automake neovim stow git gdb man manpages-dev \
  && sh -c 'curl -x http://192.168.1.100:1088 -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' \
  && rm -rf /var/lib/apt/lists/* && cd dotfiles && stow default

# Start from a Bash prompt
CMD [ "/bin/bash" ]