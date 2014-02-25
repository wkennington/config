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
      yi
    ]);
    graphical = self.buildEnv {
      name = "myGraphical";
      paths = with self; [
        # Envs
        cs225
        dev
        orpheum
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
        virtmanager
        vlc
        weechat
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
        dos2unix
        #ffmpeg
        shell
        zip
      ];
    };
    dev = self.buildEnv {
      name = "myDev";
      paths = with self; [
        mercurial
        python3Packages.ipython
        subversion
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
    cs225 = self.myEnvFun {
      name = "cs225";
      buildInputs = with self; [
        gdb
        imagemagick
        libpng
        stdenv
        valgrind
      ];
    };
    orpheum = self.myEnvFun {
      name = "orpheum";
      buildInputs = with self; [
        python27
        python27Packages.django_1_5
        python27Packages.gdata
        python27Packages.pil
        python27Packages.sqlite3
      ];
    };
  };
}
