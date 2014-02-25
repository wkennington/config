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
    graphical = self.buildEnv {
      name = "myGraphical";
      paths = with self; [
        # Envs
        dev
        shell

        # Pkgs
        chromiumWrapper
        dmenu
        emacs
        firefoxWrapper
        gimp
        gnupg1compat
        hsEnv
        libreoffice
        mumble
        pavucontrol
        pcsclite
        pinentry
        pulseaudio
        scrot
        spotify
        vlc
        xfce.terminal
        xlibs.xbacklight
        xscreensaver
        zathura
      ];
    };
    nongraphical = self.buildEnv {
      name = "myNonGraphical";
      paths = with self; [
        dev
        shell
      ];
    };
    dev = self.buildEnv {
      name = "myDev";
      paths = with self; [
        gdb
        mercurial
        python3Packages.ipython
        subversion
        valgrind
      ];
    };
    shell = self.buildEnv {
      name = "myShell";
      paths = with self; [
        acpi
        fish
        git
        htop
        mosh
        openssh
        openssl
        psmisc
        tmux
        unzip
        vim
        wget
      ];
    };
  };
}
