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
    myGraphical = self.buildEnv {
      name = "myGraphical";
      paths = with self; ([
        # Envs
        myHsEnv
        myShell
        #myRust

        # Pkgs
        dmenu
        emacs
        firefox-unwrapped
        filezilla
        gimp
        google-chrome
        hexchat
        icedtea_web
        mumble
        mupdf
        pavucontrol
        pinentry
        quasselClient
        scrot
        st
        vlc
        stdenv.stdenvDeps
        stdenv
        xorg.xcompmgr
      ]);
    };
    myNonGraphical = self.buildEnv {
      name = "myNonGraphical";
      paths = with self; [
        shell
      ];
    };
    myShell = self.buildEnv {
      name = "myShell";
      paths = with self; [
        acpi
        consul
        fish
        gnupg
        git
        htop
        ipfs
        minisign
        mosh
        nomad
        openssh
        (callPackageAlias "openssl" { })
        psmisc
        sl
        subversion
        tmux
        unzip
        vault
        vim
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
