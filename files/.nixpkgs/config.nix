nixos : {
    allowUnfree = true;
    firefox.enableAdobeFlash = false;

    haskellPackageOverrides = self: super:
        let asDarcs = path:
                (self.callPackage (import path) {}).override (args: args // {
                    mkDerivation = expr:
                        args.mkDerivation (expr // {
                            src = nixos.pkgs.fetchdarcs { url = path; };
                        });
                });

            asGit = path: rev:
                (self.callPackage (import path) {}).override (args: args // {
                    mkDerivation = expr:
                        args.mkDerivation (expr // {
                            src = nixos.pkgs.fetchgit (rev // { url = path; });
                        });
                });

        in {
            mytaffybar = self.callPackage ../cfg/my/mytaffybar {};
            myxmonad = self.callPackage ../cfg/my/myxmonad {};
            rapid = asGit <ertes-src/rapid> { rev = "e3a1ead573e4aca23a1ff55810c69cecf10e2331"; sha256 = "1pga5flvkqyin71zmlxf2v4farg0mi0i60f6znmi9217zihrr4p5"; };
            reflex = asGit <ertes-src/reflex> { rev = "2e9a8de650857424fb93b372c6d00fda5e99d380"; sha256 = "126j7siz004ihwggi9jnva49wymdj29ra0sm4k545y2xcbvjks6h"; };
        };

    packageOverrides = super: let self = super.pkgs; in {

        ertes-base = super.buildEnv {
            name = "ertes-base";
            paths = with self; [
                cacert
                connect
                curl
                darcs
                dict
                emacs
                emacsPackagesNg.geiser
                emacsPackagesNg.haskell-mode
                emacsPackagesNg.magit
                emacsPackagesNg.markdown-mode
                emacsPackagesNg.org
                emacsPackagesNg.paredit
                emacsPackagesNg.yaml-mode
                emacsPackagesNg.yasnippet
                execline
                file
                fortune
                gcc
                gitAndTools.gitFull
                gitAndTools.hub
                gnumake
                gnupg
                gptfdisk
                graphicsmagick
                isync
                lftp
                libressl
                llvm
                lm_sensors
                manpages
                mkpasswd
                msmtp
                nix-repl
                nmap
                notmuch
                p7zip
                pari-unstable
                posix_man_pages
                psmisc
                pv
                pwgen
                renameutils
                s6
                screen
                smartmontools
                sqlite
                sshfsFuse
                unzip
                vmtouch
                wget
                zip
            ];
        };

        ertes-dev = super.buildEnv {
            name = "ertes-dev";
            paths = with self; [
                AgdaStdlib
                cabal2nix
                ghc-env
                ghostscript
                gnuplot
                maxima
                pandoc
                texlive.combined.scheme-basic
            ];
        };

        ertes-gui = super.buildEnv {
            name = "ertes-gui";
            paths = with self; [
                audacity
                beets
                blender
                compton-git
                disk_indicator
                feh
                ffmpeg
                firefox
                gajim
                geeqie
                gimp
                glxinfo
                gmrun
                gnome3.gnome-chess
                haskellPackages.mytaffybar
                haskellPackages.myxmonad
                inkscape
                jmtpfs
                kde4.kcharselect
                kid3
                ledger
                mpc_cli
                mpd
                mpv
                ncmpc
                pavucontrol
                redshift
                rxvt_unicode
                scrot
                syncthing
                t
                torbrowser
                transmission
                unclutter
                xclip
                xlibs.xbacklight
                xlibs.xev
                xlibs.xmodmap
                xlibs.xwininfo
                xtrlock-pam
                youtube-dl
                zathura
                znc
            ];
        };

        ghc-env = super.haskellPackages.ghcWithPackages (p: with p; [
            Agda
            arithmoi
            async
            cabal-install
            clock
            comonad
            criterion
            fingertree
            free
            generic-deriving
            hasktags
            hscolour
            kan-extensions
            lens
            linear
            mwc-random
            network
            pipes
            random
            reflex
            resourcet
            stm
            Stream
            text
            vector
        ]);

        ghcjs-env = super.haskell.packages.ghcjs.ghcWithPackages (p: with p; [
            ghcjs-dom
            reflex
            reflex-dom
            text
            vector
        ]);
    };
}
