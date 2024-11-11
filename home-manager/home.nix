{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "user";
  home.homeDirectory = "/home/user";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.kubectl
    pkgs.kubernetes-helm
    pkgs.stern
    pkgs.fluxcd
    pkgs.terraform
    pkgs.packer
    pkgs.ansible
    pkgs.k9s
    pkgs.curl
    pkgs.git
    pkgs.unzip
    pkgs.neovim
    pkgs.glances
    pkgs.wl-clipboard
    pkgs.fd
    pkgs.ripgrep
    pkgs.tmux
    pkgs.stow
    pkgs.direnv
    pkgs.powerline-fonts
    pkgs.yazi
    #pkgs.kitty

    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".bashrc".source                 = ~/.dotfiles/configs/bashrc/.bashrc;
    ".inputrc".source                = ~/.dotfiles/configs/bashrc/.inputrc;
    ".tmux.conf".source              = ~/.dotfiles/configs/tmux/.tmux.conf;
    ".tmuxline.conf".source          = ~/.dotfiles/configs/tmux/.tmuxline.conf;
    ".gitconfig".source              = ~/.dotfiles/configs/git/.gitconfig;

    ".config/yazi".source            = ~/.dotfiles/configs/yazi;
    ".config/nvim".source            = ~/.dotfiles/configs/nvim;
    ".config/kitty".source           = ~/.dotfiles/configs/kitty;
    ".config/ranger".source          = ~/.dotfiles/configs/ranger;
    ".config/bash_git_prompt".source = ~/.dotfiles/configs/bash_git_prompt;


    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/user/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";

  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
