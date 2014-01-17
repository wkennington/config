pkgs : {
  cabal.libraryProfiling = true;
  firefox = {
    jre = false;
    enableGoogleTalkPlugin = false;
    enableAdobeFlash = false;
  };
  chromium = {
    jre = false;
    enableGoogleTalkPlugin = true;
    enableAdobeFlash = true;
  };
  packageOverrides = self : rec {
    hsEnv = self.haskellPackages.ghcWithPackages (self : with self; [
      xmonad
    ]);
    desktop = self.buildEnv {
      name = "myDesktop";
      paths = with self; [
        acpi
        chromiumWrapper
        dmenu
        emacs
        firefoxWrapper
        gdb
        gimp
        git
        gnupg1compat
        hsEnv
        mercurial
        mtr
        libreoffice
        openssh
        openssl
        pavucontrol
        pcsclite
        pinentry
        psmisc
        pulseaudio
        python3Packages.ipython
        scrot
        spotify
        subversion
        unzip
        valgrind
        vim
        vlc
        wget
        xfce.terminal
        xlibs.xbacklight
        xscreensaver
        zathura
        zsh
      ];
    };
    server = self.buildEnv {
      name = "myServer";
      paths = with self; [
        acpi
        atop
        dnstop
        git
        gptfdisk
        htop
        iftop
        iotop
        iperf
        iptables
        mtr
        nmap
        openssh
        openssl
        psmisc
        tmux
        unzip
        vim
        wget
        zsh
      ];
    };
  };
}
