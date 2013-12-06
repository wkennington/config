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
        chromiumWrapper
        dmenu
        emacs
        firefoxWrapper
        gcc
        gimp
        git
        gnumake
        gnupg1compat
        go
        mercurial
        hsEnv
        imagemagick
        jre
        libpng
        libreoffice
        nmap
        pinentry
        pcsclite
        protobuf
        pythonPackages.ipython
        scrot
        subversion
        valgrind
        vim
        vlc
        xfce.terminal
        xscreensaver
        unzip
        zathura
      ];
    };
    server = self.buildEnv {
      name = "myServer";
      paths = with self; [
        git
        gnupg1compat
        gptfdisk
        iptables
        openssl
        openssh
        vim
      ];
    };
  };
}
