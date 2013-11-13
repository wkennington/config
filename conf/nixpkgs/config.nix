pkgs : {
  cabal.libraryProfiling = true;
  firefox = {
    jre = true;
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
#      haskellPlatform
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
        git
        gnumake
        gnupg1compat
        go
        mercurial
        hsEnv
        imagemagick
        libpng
        libreoffice
        protobuf
        python
        subversion
        valgrind
        vim
        xfce.terminal
        xscreensaver
        zathura
      ];
    };
    
    server = self.buildEnv {
      name = "myServer";
      paths = with self; [
        git
        gnupg1compat
        vim
      ];
    };
  };
}
