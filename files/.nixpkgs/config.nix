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
            powermate = asGit <ertes-src/powermate> {
                rev = "ed4381827bcb197cb1fd4a63c2e04bcdb7548899";
                sha256 = "1bj073phaij38b057adsgqbvqr2lvv99vicxixmysvj8r4gnz57l";
            };
            rapid = asGit <ertes-src/rapid> {
                rev = "e3a1ead573e4aca23a1ff55810c69cecf10e2331";
                sha256 = "1pga5flvkqyin71zmlxf2v4farg0mi0i60f6znmi9217zihrr4p5";
            };
            rapid-term = asGit <ertes-src/rapid-term> {
                rev = "f46b0b8011b638706e34c5b23ad54b8f54d9854c";
                sha256 = "0g852pwg0pmsbpgfkvygxr9fyzr9x6z5km0m8drz18521c6bhbfa";
            };
            reflex = asGit <ertes-src/reflex> {
                rev = "d78ba4318c425ca9b942dc387d7c5c7ab2d2e095";
                sha256 = "10sryvwdf88ajkp35yma8llkb38cp63vjr5mq2hba4s2d8yg649q";
            };
            wires = asGit <ertes-src/wires> {
                rev = "53ad7aae155d420f3de7bd7222fe13f05fe13110";
                sha256 = "1nhq61rqfv8m0yiw7h8hmwmbvll7cx6f9yyp8ymf8rrhdk5fhd4i";
            };
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

        ertes-scripts =
            import (builtins.getEnv "HOME" + "/cfg/my/scripts") {
                pkgs = self;
            };

        ghc-env = super.haskellPackages.ghcWithPackages (p: with p; [
            ad
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
            ghc-datasize
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
            smallcheck
            sqlite-simple
            stm
            Stream
            text
            vector
            wires
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
