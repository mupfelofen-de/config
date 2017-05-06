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
            progress-meter = asGit <ertes-src/progress-meter> {
                rev = "refs/tags/v0.1.0";
                sha256 = "0mzal1bbyww1a8qnhp6y69mbbx04filk29l00348q465bz0zd9k9";
            };
            rapid = asGit <ertes-src/rapid> {
                rev = "e3a1ead573e4aca23a1ff55810c69cecf10e2331";
                sha256 = "1pga5flvkqyin71zmlxf2v4farg0mi0i60f6znmi9217zihrr4p5";
            };
            rapid-term = asGit <ertes-src/rapid-term> {
                rev = "15101bdd357c89c5f15c7a0c74a26225379cfa2b";
                sha256 = "0am4d5s1y00066yz89lp1vxwz2kfs58b3harqn4vpas199lklj8w";
            };
            reflex = asGit <ertes-src/reflex> {
                rev = "de4861c9e3307ca3fcfadf3f576e4896e9f1ad16";
                sha256 = "0flvsgpfdppmbhmahl1b0rmriiwf7q9rymwmfi4rm7ys7m8xq1h3";
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
                # gnome3.gnome-chess
                gucharmap
                haskellPackages.mytaffybar
                haskellPackages.myxmonad
                inkscape
                jmtpfs
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
                xorg.xinput
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
            megaparsec
            mwc-random
            network
            pipes
            progress-meter
            random
            rapid
            rapid-term
            # reflex
            resourcet
            sdl2
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
