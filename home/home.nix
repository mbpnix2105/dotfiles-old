{ config, pkgs, ... }:

{
  imports = [
    ./modules/alacritty.nix
    ./modules/shell.nix
    ./modules/files.nix
    ./modules/zsh.nix
    ./modules/pkgs.nix
  ];

  programs.home-manager.enable = true;

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
  };

  services.emacs = {
    enable = true;
  };

  programs.gh = {
    enable = true;
    gitProtocol = "ssh";
  };

  xdg.enable = true;

  gtk = {
    enable = true;
    iconTheme.name = "Arc";
    iconTheme.package = pkgs.arc-icon-theme;
    theme.name = "Sweet-Dark";
    theme.package = pkgs.sweet;
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    extraConfig = ''
      syntax on
      set tabstop=2 softtabstop=2
      set shiftwidth=2
      set expandtab
      set smartindent
      set nu rnu
      set nowrap
      set smartcase
      set noswapfile
      set nobackup
      set undodir=~/.vim/undodir
      set undofile
      set colorcolumn=80
      highlight ColorColumn ctermbg=0 guibg=lightgrey
      colorscheme gruvbox
      set background=dark
    '';
    plugins = [
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.gruvbox
    ];
  };

  programs.ssh = {
    enable = true;
    compression = true;
    matchBlocks =
      let
        home = config.home.homeDirectory;
      in
      {
        "github.com" = {
          user = "git";
          identityFile = "${home}/.ssh/key.pub";
          identitiesOnly = true;
        };
      };
  };

  programs.password-store = {
    enable = true;
    package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);
    settings = { PASSWORD_STORE_DIR = ".password-store"; };
  };

  programs.gpg = {
    enable = true;
    settings = { homedir = ".gnupg"; };
  };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    defaultCacheTtl = 60;
    defaultCacheTtlSsh = 60;
    maxCacheTtl = 60;
    maxCacheTtlSsh = 60;
    pinentryFlavor = "gtk2";
    sshKeys = [ "6F108BEA85A44CEE1495B3626F668D412CAF081D" ];
  };

  programs.git = {
    enable = true;
    userName = "mbpnix2105";
    userEmail = "mbpnix2105@protonmail.com";
    signing = {
      signByDefault = true;
      key = "72DAFC99";
    };
    extraConfig = {
      core.editor = "vim";
      github.username = "mbpnix2105";
      color.ui = true;
      pull.rebase = true;
      diff.algorithm = "patience";
    };
  };

  home.username = "mbpnix";
  home.homeDirectory = "/home/mbpnix";

  home.stateVersion = "21.05";

  home.packages = with pkgs; [
    arc-icon-theme
    arc-theme
    arduino
    atom
    bat
    bc
    capitaine-cursors
    discord
    etcher
    exa
    git-crypt
    google-cloud-sdk
    gruvbox-dark-gtk
    gruvbox-dark-icons-gtk
    hping
    htop
    i3lock-color
    i3lock-fancy
    inkscape
    keepassxc
    kotatogram-desktop
    lsd
    neofetch
    nettools
    nmap
    nordic
    numix-cursor-theme
    numix-gtk-theme
    numix-icon-theme
    numix-icon-theme-circle
    numix-icon-theme-square
    numix-solarized-gtk-theme
    numix-solarized-gtk-theme
    numix-sx-gtk-theme
    orchis
    p7zip
    papirus-icon-theme
    pavucontrol
    pinentry-gtk2
    procs
    ripgrep
    scrot
    speedtest-cli
    stow
    sweet
    tree
    unrar
    unzip
    vimix-gtk-themes
    vlc
    vscodium
    xclip
    youtube-dl
  ];
}
