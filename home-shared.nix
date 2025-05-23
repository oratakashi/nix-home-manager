{ config, pkgs, ... }:

let

  # unstable = import <nixpkgs-unstable> {};

in

{
  
  home.username = "oratakashi";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Terminal Tools
    git
    eza
    # neofetch
    fastfetch
    btop
    htop

    # Development Tools
    scrcpy
    php84
    php84Extensions.opcache
    php84Extensions.mbstring
    php84Extensions.curl
    php84Extensions.openssl
    php84Extensions.pdo
    php84Extensions.pdo_mysql
    php84Packages.composer

    # Build Tools
    cmake
    ninja
    clang
    python311
    nodejs_20
    # nodejs_17
    yarn
    # android-tools
  ];

  # Setup Starship
  programs.starship = {
    enable = true;
		enableFishIntegration = true;
  };

  # Setup Fish
  programs.fish = {
    enable = true;

    shellAliases =  {
      # code="flatpak run com.visualstudio.code";
      mirror = "scrcpy -Sw --always-on-top --no-audio -s RR8R20A1BPX";
      mirror-vivo = "scrcpy -Sw --always-on-top --no-audio -s 10DDCF0F62000BG";
      ls = "eza --icons";
      # home-refresh = "home-manager -- switch --flake ~/.config/home-manager";
      # home-update = "home-manager switch";
      home-edit = "code ~/.config/home-manager";
      cat = "bat";
      neofetch = "fastfetch";
      nix-clear="nix-collect-garbage -d";
    };

    interactiveShellInit = ''
      set -gx LANG en_US.UTF-8
      set -gx LC_ALL en_US.UTF-8

      # Optional: Set icon for Linux (similar to POWERLEVEL9K_LINUX_ICON)
      set -gx POWERLEVEL9K_LINUX_ICON \uf179

      # Inject PATH dari Nix
      set -l nix_paths \
        /Users/oratakashi/.nix-profile/bin \
        /etc/profiles/per-user/oratakashi/bin

      for p in $nix_paths
        if not contains $p $fish_user_paths
          set -Ua fish_user_paths $p
        end
      end
    '';
  };

  # Setup Zsh
  programs.zsh = {
    enable = false;
    autosuggestion.enable = true;
    enableCompletion = true;
    # dotDir = ".config/zsh";
    initExtra = ''
      ## include config generated via "p10k configure" manually; zplug cannot edit home manager's zshrc file.
      ## note that I moved it from its original location to /etc/nixos/p10k
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      typeset -g POWERLEVEL9K_LINUX_ICON='\uf179'

      export LANG="en_US.UTF-8";
      export LC_ALL="en_US.UTF-8";

      # Zplug Setup
      if [ ! -d "$HOME/.zplug" ]; then
        git clone https://github.com/zplug/zplug "$HOME/.zplug"
      fi
      export ZPLUG_HOME="$HOME/.zplug"
      if [ -f "$ZPLUG_HOME/init.zsh" ]; then
        source "$ZPLUG_HOME/init.zsh"
        autoload -Uz zplug

        if type zplug &> /dev/null; then
          zplug "romkatv/powerlevel10k", as:theme, depth:1
          zplug load
        else
          echo "zplug masih belum ter-load, cek konfigurasi!"
        fi
      fi
    '';
    zplug = {
      enable = false;
      plugins = [
        { name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; }
      # Installations with additional options. For the list of options,
      # please refer to Zplug README.
      ];
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };

    shellAliases =  {
      # code="flatpak run com.visualstudio.code";
      mirror = "scrcpy -Sw --always-on-top --no-audio -s RR8R20A1BPX";
      mirror-vivo = "scrcpy -Sw --always-on-top --no-audio -s 10DDCF0F62000BG";
      ls = "eza --icons";
      # home-refresh = "home-manager -- switch --flake ~/.config/home-manager";
      # home-update = "home-manager switch";
      home-edit = "code ~/.config/home-manager";
      cat = "bat";
      neofetch = "fastfetch";
      nix-clear="nix-collect-garbage -d";
    };

    # profileExtra = ''
    #   # export JAVA_HOME="/home/oratakashi/.jdks/jbr-17.0.8.1"
    #   export KOBWEB = "/home/oratakashi/Documents/Tools/kobweb/bin"
    #   export PATH="$KOBWEB/bin:$PATH"
    # '';
  };

  home.sessionPath = [
    "/home/oratakashi/Documents/Tools/kobweb/bin"
  ];

  # Setup Java
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };

  # Setup Bat
  programs.bat = {
    enable = true;
    config = {
      map-syntax = [
        "*.jenkinsfile:Groovy"
        "*.props:Java Properties"
      ];
      pager = "less -FR";
      theme = "Nord";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/oratakashi/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.neovim.enable = true;
  programs.helix.enable = true;
}
