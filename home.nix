{ config, pkgs, lib, ... }:

let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.package = pkgs.nix;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = lib.mkDefault "emil";
  home.homeDirectory = lib.mkDefault (
    if isDarwin then "/Users/emil" else "/home/emil"
  );

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.activation.keyRepeatSpeed = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # Only run on macOS
    if [ "$(uname)" = "Darwin" ]; then
      echo "Setting macOS key repeat speed..."
      /usr/bin/defaults write -g InitialKeyRepeat -int 10
      /usr/bin/defaults write -g KeyRepeat -int 1
    fi
  '';

  home.activation.tapToClick = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # Only run on macOS
    if [ "$(uname)" = "Darwin" ]; then
      echo "Enabling tap-to-click..."
      /usr/bin/defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
      /usr/bin/defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
      /usr/bin/defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    fi
  '';

  programs.obsidian = {
    enable = true;

    vaults."Documents/Obsidian/master".enable = true;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # CLI tools
    bat
    fd
    ripgrep
    fzf
    jq
    curl
    wget
    git
    raycast
    
    # Development tools
    
    # Optional: Add more packages as needed
  ] ++ lib.optionals (!isDarwin) [
    # Linux-specific packages
  ] ++ lib.optionals isDarwin [
    aerospace
    # macOS-specific packages
  ];
  
  # Git configuration
  programs.git = {
    enable = true;
    # You can add your git config here
    settings.user = {
      name = "Emil Ahlbäck";
      email = "me@emil.zip";
    };
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    defaultKeymap = "viins";
    
    history = {
      size = 50000;
      path = "${config.home.homeDirectory}/.zsh_history";
      ignoreDups = true;
      ignoreSpace = true;
      expireDuplicatesFirst = true;
      share = true;
      save = 50000;
      extended = true;
    };

    initContent = ''
      # General config
      DISABLE_AUTO_UPDATE=true
      export BAT_THEME="gruvbox-light"
      export LANG=en_US.UTF-8
      export EDITOR="nvim"
      export PATH="$PATH:$HOME/.local/bin"

      # Markfile functionality
      export MARKFILE=$HOME/.marks
      function mark {
        if [ -z "$1" ]; then
          echo "that's wrong"
          return
        fi
        if [ "$1" != "-c" ]; then
          gomark "$1"
          return
        fi
        echo "$2:$(pwd)" >> "$MARKFILE"
        echo "Added to markfile"
      }
      function _mark {
        COMPREPLY=$(cat "$MARKFILE" | cut -d ":" -f 1)
      }
      function gomark {
        A=$(rg ^"$1": "$MARKFILE" | cut -d ":" -f "2-")
        cd $A
        echo "Welcome to $1."
      }

      # Menu complete on first tab
      setopt menu_complete

      # Enhanced history options
      setopt HIST_FCNTL_LOCK          # Use file locking for history file (safer)
      setopt HIST_REDUCE_BLANKS      # Remove extra blanks from history
      setopt INC_APPEND_HISTORY      # Append to history file immediately
      setopt HIST_IGNORE_ALL_DUPS    # Ignore all duplicates (more aggressive)
      setopt HIST_FIND_NO_DUPS       # Don't show duplicates when searching history
      setopt HIST_VERIFY             # Show history expansion before executing

      # Source local zshrc if it exists
      [ -f $HOME/.zshrc_local ] && source $HOME/.zshrc_local

      # Case insensitive completion
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
      export CASE_SENSITIVE="true"
      setopt nocaseglob

      # Custom functions
      copyfile() {
        if [[ -f "$1" ]]; then
          osascript -e 'set the clipboard to (POSIX file "'"$(realpath "$1")"'")'
          echo "File copied to clipboard: $1"
        else
          echo "Error: File not found."
        fi
      }

      # Prompt configuration
      e[1]="🌳"
      e[2]="🌿"
      e[3]="🪴"
      e[4]="🌵"
      e[5]="🌱"
      e[6]="🌷"
      e[7]="🌻"
      e[8]="🌸"
      e[9]="🍁"
      e[10]="🍄"
      e[11]="🌾"
      e[12]="🗿"

      random_plant() {
          size=''${#e[@]}
          index=$(($RANDOM % $size))
          EMOJI=''${e[$index+1]}
      }

      random_plant

      autoload -Uz vcs_info
      precmd () { vcs_info }

      R=$reset_color
      G=$fg_bold[green]
      PROMPT_NAME='%n@%B%F{green}%m%f%b '
      PROMPT_PATH='%U%2~%u '

      zstyle ':vcs_info:*' check-for-changes true
      zstyle ':vcs_info:*' formats '(%b%u%c) '
      zstyle ':vcs_info:*' unstagedstr '*'
      zstyle ':vcs_info:*' stagedstr '+'

      # Vim mode prompt
      function zle-line-init zle-keymap-select {
          VIM_NORMAL_PROMPT="%B%F{yellow} [% VI]% %b%f"
          VIM_INSERT_PROMPT=""
          RPS1="''${''${KEYMAP/vicmd/$VIM_NORMAL_PROMPT}/(main|viins)/$VIM_INSERT_PROMPT} %*"
          RPS2=$RPS1
          zle reset-prompt
      }
      zle -N zle-line-init
      zle -N zle-keymap-select

      PROMPT_VCS='$vcs_info_msg_0_'
      PS1="$PROMPT_NAME$PROMPT_PATH$PROMPT_VCS%(?.$EMOJI.❌) "
    '';

    shellAliases = {
      vim = "nvim";
      "." = "source";
      ".." = "cd ..";
      "..." = "cd ../..";
      gpr = "git pull --rebase";
      gs = "git status";
      today = "date '+%Y-%m-%d'";
      now = "date '+%H:%M:%S'";
      wttr = "curl wttr.in";
      myip = "curl ifconfig.me";
      m = "mv -vn";
      hg = "kitty +kitten hyperlinked_grep";
    } // lib.optionalAttrs (!isDarwin) {
      open = "xdg-open";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "vi-mode" ];
    };
  };

  # Neovim configuration
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Atuin - shell history
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      auto_sync = false;  # Set to true if you want to use atuin sync
      sync_frequency = "5m";
      search_mode = "fuzzy";
      filter_mode = "global";
      style = "compact";
      inline_height = 20;
    };
  };

  # Home files - link config directories
  home.file = {
    # Config directories
    # ".config/nvim" = {
    #   source = config.lib.file.mkOutOfStoreSymlink ./nvim;
    # };
    ".config/mpv" = {
      source = config.lib.file.mkOutOfStoreSymlink ./mpv;
    };
    ".config/ghostty" = {
      source = config.lib.file.mkOutOfStoreSymlink ./ghostty;
    };
  } // lib.optionalAttrs isDarwin {
    ".aerospace.toml".source = config.lib.file.mkOutOfStoreSymlink ./aerospace/aerospace.toml;
  };

  # XDG Base Directory specification
  xdg.enable = true;
}
