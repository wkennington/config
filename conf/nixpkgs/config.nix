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
        myRust

        # Pkgs
        chromium
        dmenu
        emacs
        firefox
        filezilla
        gimp
        icedtea_web
        mumble
        mupdf
        pavucontrol
        pcsclite
        pinentry
        quasselClient
        scrot
        st
        vlc
        xorg.xcompmgr
        xorg.xbacklight
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
        (callPackageAlias "pkgconfig" { })
        rustc
        cargo
      ];
    };
  };
}
