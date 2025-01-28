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
    pkgs.kubectx
    pkgs.kubernetes-helm
    pkgs.stern
    pkgs.fluxcd
    pkgs.argocd
    pkgs.tfswitch
    pkgs.tgswitch
    pkgs.packer
    pkgs.ansible
    pkgs.k9s
    pkgs.curl
    pkgs.git
    pkgs.unzip
    pkgs.neovim
    pkgs.wl-clipboard
    pkgs.fd
    pkgs.ripgrep
    pkgs.tmux
    pkgs.stow
    pkgs.direnv
    pkgs.powerline-fonts
    pkgs.yazi
    pkgs.rustup
    #pkgs.sshuttle
    pkgs.fzf
    pkgs.minio-client
    pkgs.bat
    pkgs.lnav
    #pkgs.kitty
    pkgs.fastfetch
    pkgs.nerdctl
    pkgs.httpie
    pkgs.btop
    pkgs.ghostty
    pkgs.nerd-fonts.fira-code


    #(pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })

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
    ".bashrc".source                 = configs/bashrc/.bashrc;
    ".inputrc".source                = configs/bashrc/.inputrc;
    ".tmux.conf".source              = configs/tmux/.tmux.conf;
    ".gitconfig".source              = configs/git/.gitconfig;

    ".config/yazi".source            = configs/yazi;
    ".config/nvim".source            = configs/nvim;
    ".config/kitty".source           = configs/kitty;
    ".config/ranger".source          = configs/ranger;
    ".config/bash_git_prompt".source = configs/bash_git_prompt;

    ".kube-ps1".source = builtins.fetchGit {
        url = "https://github.com/jonmosco/kube-ps1.git";
        rev = "0391b238d903022dd78b40be4f2fb5bba96cc0f3";
    };

    ".local/share/nvim/site/autoload/plug.vim".source = builtins.fetchGit{
        url = "https://github.com/junegunn/vim-plug.git";
        rev = "d80f495fabff8446972b8695ba251ca636a047b0"; 
    } + "/plug.vim";

    ".bash-git-prompt".source = builtins.fetchGit {
        url = "https://github.com/magicmonty/bash-git-prompt.git";
        rev = "622e337d119adcdd5d4bee3ef15f8d81d4eea631";
    };

    ".tmux/plugins/tpm".source = builtins.fetchGit {
        url = "https://github.com/tmux-plugins/tpm.git";
        rev = "99469c4a9b1ccf77fade25842dc7bafbc8ce9946";
    };

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
