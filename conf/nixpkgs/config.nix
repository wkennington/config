pkgs : {
  allowUnfree = true;
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
  st.conf = (builtins.readFile ./st/config.mach.h)
    + (builtins.readFile ./st/config.inc.h);
  packageOverrides = self : rec {
    hsEnv = self.haskellPackages.ghcWithPackages (self : with self; [
      xmonad
      #yi
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
        filezilla
        #libreoffice
        mumble
        nix-repl
        #notbit
        pavucontrol
        pcsclite
        pinentry
        pulseaudio
        kde4.quasselClient
        scrot
        st
        sup
        vlc
        xlibs.xbacklight
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
      buildInputs = (with self; [ python27
      #rubyLibs.sass_3_3_4
      ])
        ++ (with self.python27Packages; [
          django_1_5 google_api_python_client paypalrestsdk pil sorl_thumbnail six sqlite3
        ]);
    };
  };
}
