pkgs : {
  allowUnfree = true;
  cabal.libraryProfiling = true;
  pulseaudio = true;
  st.config = (builtins.readFile ./st/config.mach.h)
    + (builtins.readFile ./st/config.inc.h);
  packageOverrides = self : rec {
    myHsEnv = self.haskellPackages.ghcWithPackages (self : with self; [
      xmonad
      xmonad-contrib
    ]);
    google-chrome = self.google-chrome.override {
      adobe-flash-player = null;
    };
    myWorkGraphical = self.buildEnv {
      name = "myWorkGraphical";
      paths = with self; ([
        # Envs
        myHsEnv
        myWorkShell

        # Pkgs
        dmenu
        emacs
        feh
        gimp
        moolticute
        mpv
        mupdf
        pavucontrol
        scrot
        st
        xorg.xcompmgr
      ]);
    };
    myGraphical = self.buildEnv {
      name = "myGraphical";
      paths = with self; ([
        # Envs
        myWorkGraphical
        myShell

        # Pkgs
        #firefox-unwrapped
        google-chrome
        light-locker
        mumble_git
        pinentry_qt
      ]);
    };
    myWorkShell = self.buildEnv {
      name = "myWorkShell";
      paths = with self; [
        acpi
        elvish
        fish
        gnupg
        git
        htop
        ipfs
        mercurial
        minisign
        mosh
        ncdu
        openssh
        (callPackageAlias "openssl" { })
        psmisc
        sl
        subversion
        teleport
        tmux
        unrar
        unzip
        vim
      ];
    };
    myShell = self.buildEnv {
      name = "myShell";
      paths = with self; [
        # Envs
        myWorkShell

        # Pkgs
        #consul
        #nomad
        notmuch
        #vault
        yubikey-manager
      ];
    };
  };
}
