# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.wifi.powersave = false;
#  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  boot.initrd.luks.devices."luks-8628814e-2103-48a3-bfb8-a439e23c7e92".device = "/dev/disk/by-uuid/8628814e-2103-48a3-bfb8-a439e23c7e92";


 # boot.blacklistedKernelModules = [ "wlp9s0" ];  # onboard Wi-Fi module

#  boot.initrd.kernelModules = [ "amdgpu" ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Brisbane";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  #amd
  #services.xserver.videoDrivers = [ "modesetting" ];
 #  services.xserver.videoDrivers = [ "amdgpu" ];
  
  hardware.cpu.amd.updateMicrocode = true;                                                                                                                                                                         
  hardware.bluetooth.enable = true;
  
hardware.enableRedistributableFirmware = true;                                                                                                                                                                   
#hardware.graphics.enable = true;
#  hardware.opengl.driSupport = true;   
#  hardware.opengl.driSupport32Bit = true;   
# Enable OpenGL
hardware.opengl = {
  enable = true;
  driSupport = true;
  driSupport32Bit = true;
  extraPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-extension-layer
  ];
};


 

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

    # Set the global GTK cursor theme for GNOME
/*  gnome = {
    extraGSettingsOverrides = ''
      [org.gnome.desktop.interface]
      cursor-theme='breeze_cursors'  # Replace with your chosen cursor theme name
    '';
  };
*/

#kde  
	#services.displayManager.sddm.enable = true;
	#services.desktopManager.plasma6.enable = true;
	#services.displayManager.defaultSession = "plasmax11";

	#case insenstive filesystems
#	use-case-hack = true

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing = { enable = true; drivers = [ pkgs.epson-escpr ]; };
  services.avahi = {
  	enable = true;
  	nssmdns4 = true;
	openFirewall = true;
	};


  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jb = {
    isNormalUser = true;
    description = "JB Hewitt";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Enable automatic login for the user.
#  services.xserver.displayManager.autoLogin.enable = true;
#  services.xserver.displayManager.autoLogin.user = "jb";
  services.displayManager.autoLogin.user = "jb";
  services.displayManager.autoLogin.enable = true;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

	#mouse tool
	services.ratbagd.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
	amdvlk 
  	terminator
	kitty
	wezterm
	winbox
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
	neovim
	unzip
	zip
    wget
    	xdg-utils
    pkgs.kdePackages.plasma-systemmonitor
	brave
    p7zip
	lenovo-legion
	obs-studio
	mosh
    neovim
    steam
	piper #mouse tool
  #  steam-original
  #  steam-run
    	btop
	htop
    discord
    #rustdesk
    rustdesk-flutter
    vlc    
	bitwarden
   yubikey-manager
   yubikey-manager-qt
   yubikey-agent
   yubikey-personalization-gui
   yubikey-personalization
   pam_u2f 
   

    jetbrains-toolbox    
    obsidian
#jetbrains.rider
    unityhub
	bambu-studio
    openh264
    x264
    mesa
    android-studio
    android-tools
    android-udev-rules
    android-studio-tools
    gh
    git
    git-lfs
    github-desktop
    vscode-with-extensions
    blender-hip
    blockbench
    audacity
    vulkan-loader
    vulkan-tools
    vulkan-validation-layers
    slack
    signal-desktop
	whatsapp-for-linux
	qalculate-gtk
    wineWowPackages.full  
    wine64
    wine    
    dracula-theme
	volantes-cursors
	gnomeExtensions.paperwm
	gnome.gnome-tweaks
	lshw
	hwinfo
	fzf
	fzf-zsh
	atuin
	powertop
	dust
	bat
	tldr
	zellij
	eza
  ];

   programs.steam.enable = true;


  fonts.packages = with pkgs; [ 
corefonts
google-fonts
font-awesome
vistafonts
nerdfonts 
noto-fonts
noto-fonts-cjk
noto-fonts-emoji
liberation_ttf
fira
fira-code
fira-code-symbols
source-serif-pro
libertine
liberation_ttf
liberation_ttf_v1
monocraft
mononoki
roboto
roboto-mono
roboto-serif
stix-two
  ];

  services.flatpak.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.mosh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

#hardware.extraPackages = with pkgs; [
#  amdvlk
#  rocmPackages.clr.icd
#];
#hardware.extraPackages32 = with pkgs; [
#  driversi686Linux.amdvlk
#];

services.udev.packages = [ pkgs.yubikey-personalization ];

programs.gnupg.agent = {
  enable = true;
  enableSSHSupport = true;
};

#smartcard enable (yubikey)
services.pcscd.enable = true;

security.pam.services = {
  login.u2fAuth = true;
  sudo.u2fAuth = true;
};

#fix for webbrowser not launching with links
#https://discourse.nixos.org/t/alvr-cant-launch-steamvr-steam-desktop-is-not-executable/43845/10
xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  wlr.enable = true;
  extraPortals = [ pkgs.xdg-desktop-portal-kde ];
};



  #helps with dual boot windows time
  time.hardwareClockInLocalTime = true;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
  #system.stateVersion = "nixos-unstable"; # Did you read the comment?

}
