pkgs : {
  allowUnfree = true;
  cabal.libraryProfiling = true;
  pulseaudio = true;
  firefox = {
    jre = false;
    enableAdobeFlash = false;
    enableGoogleTalkPlugin = false;
    icedtea = true;
  };
  st.config = (builtins.readFile ./st/config.mach.h)
    + (builtins.readFile ./st/config.inc.h);
  packageOverrides = self : rec {
    chromium = self.chromium.override {
      enablePepperFlash = true;
    };
    myHsEnv = self.haskellPackages.ghcWithPackages (self : with self; [
      xmonad
      xmonad-contrib
    ]);
    myWorkGraphical = self.buildEnv {
      name = "myWorkGraphical";
      paths = with self; ([
        # Envs
        myHsEnv
        myShell
        #myRust

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

        # Pkgs
        #firefox-unwrapped
        google-chrome
        mumble_git
        pinentry_qt
      ]);
    };
    myShell = self.buildEnv {
      name = "myShell";
      paths = with self; [
        acpi
        #consul
        elvish
        fish
        gnupg
        git
        htop
        ipfs
        minisign
        mosh
        #nomad
        notmuch
        openssh
        (callPackageAlias "openssl" { })
        psmisc
        sl
        subversion
        teleport
        tmux
        unzip
        #vault
        vim
        yubikey-manager
      ];
    };
    myRust = self.myEnvFun {
      name = "myRust";
      buildInputs = with self; [
        stdenv
        autoconf
        automake
        libtool
        rustc
        cargo
      ];
    };
  };
}
