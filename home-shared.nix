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
    eza
    neofetch

    # Development Tools
    scrcpy
    nixfmt
    php
    php83Packages.composer

    # Build Tools
    cmake
    ninja
    clang
    python311
    nodejs_20
    # nodejs_17
    yarn
    android-tools
  ];

  # Setup Zsh
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    # dotDir = ".config/zsh";
    initExtra = ''
      ## include config generated via "p10k configure" manually; zplug cannot edit home manager's zshrc file.
      ## note that I moved it from its original location to /etc/nixos/p10k
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      typeset -g POWERLEVEL9K_LINUX_ICON='\uf179'
    '';
    zplug = {
      enable = true;
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
      home-update = ''
        if [[ "$(uname)" == "Darwin" ]]; then
          echo "Installing macOS configuration..."
          home-manager switch --flake ~/.config/home-manager#darwin
        elif grep -q Microsoft /proc/version 2>/dev/null; then
          echo "Installing Windows (WSL) configuration..."
          home-manager switch --flake ~/.config/home-manager#windows
        else
          echo "Installing Linux configuration..."
          home-manager switch --flake ~/.config/home-manager#linux
        fi
      '';
      home-edit = "code ~/.config/home-manager";
      cat = "bat";
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
