{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix # readonly and different according to hardware
    ];

  # grub
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.efiSysMountPoint = "/efi";

  networking.hostName = "sko"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  networking.proxy.default = "http://127.0.0.1:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost";

  # timezone
  time.timeZone = "Asia/Shanghai";

  # locale
  i18n.defaultLocale = "zh_CN.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # input method
  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk             # alternatively, kdePackages.fcitx5-qt
      fcitx5-chinese-addons  # table input method support
      fcitx5-nord            # a color theme
    ];
  };

  # x11
  services.xserver.enable = true;

  # sudo
  security.sudo.wheelNeedsPassword = false;

  # gnome stuff
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = true;
  services.gnome.glib-networking.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gnome.gnome-settings-daemon.enable = true;
  services.gnome.sushi.enable = true;

  # display manager
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.setupCommands = ''
    xrandr --output DP-0 --rate 144
  '';

  # flatpak
  services.flatpak.enable = true;

  # sound stuff should be enabled by gnome by default
  # hardware.pulseaudio.enable = true;

  # normal user
  users.users.polyarkk = {
    isNormalUser = true;
    createHome = true;
    home = "/home/polyarkk";
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  fonts.packages = with pkgs; [
    lxgw-wenkai
    vista-fonts-chs
  ];

  # packages
  environment.systemPackages = with pkgs; [
    nano
    wget
    openssh
    fastfetch
    git
    google-chrome
    rustup
    poetry
    fnm
    autojump
    # mihomo-party # RIP
    clash-verge-rev
    docker
    gnome-tweaks
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
    gnomeExtensions.just-perfection
    gnomeExtensions.vitals
    gnomeExtensions.appindicator
    gnomeExtensions.user-themes
    gnomeExtensions.kimpanel
    gnomeExtensions.pano
    gnomeExtensions.move-clock
    gh
    qq
    htop
    go-musicfox

    # no flexible theme settings
    # orchis-theme
    sassc
    gnome-themes-extra
    gtk-engine-murrine

    tela-circle-icon-theme
    catppuccin-cursors.macchiatoRed

    vscode # todo: detailed configuration for extensions
    # (vscode-with-extensions.override {
    #   vscodeExtensions = with vscode-extensions; [
    #     bbenoist.nix
    #     ms-python.python
    #     ms-azuretools.vscode-docker
    #     ms-vscode-remote.remote-ssh
    #   ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    #     {
    #       name = "remote-ssh-edit";
    #       publisher = "ms-vscode-remote";
    #       version = "0.47.2";
    #       sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g";
    #     }
    #   ];
    # })
  ];

  programs.zsh = {
    enable = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.zsh.ohMyZsh = {
    enable = true;
    plugins = [
      "git"
      "autojump"
    ];
    theme = "gentoo";
  };

  virtualisation.docker.enable = true;

  # sshd
  services.openssh.enable = true;

  # firewall
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  # tl;dr: do not edit it
  system.stateVersion = "25.05";

  nix.settings.substituters = lib.mkForce [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
  nixpkgs.config.allowUnfree = true;
}
