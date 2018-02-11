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
                rev = "refs/heads/master";
                sha256 = "10mbbaav7ffn956rpcyfd2fym4mdk5sq6vq5gpakxr1r07k4ajbq";
            };
            rapid = asGit <ertes-src/rapid> {
                rev = "refs/heads/master";
                sha256 = "1jkr26cpxhdjszwpcilzxaqfqy3ffmbbjaq3181s40m9grjx2s24";
            };
            rapid-term = asGit <ertes-src/rapid-term> {
                rev = "refs/heads/master";
                sha256 = "131bgcn0jpm7v924vfqyxfa8ls68ni52a4rpja0rcbxy2b02yrmr";
            };
            reflex = asGit <ertes-src/reflex> {
                rev = "refs/heads/develop";
                sha256 = "1835njkbrv7mbqa000zldhfvi9zhz5ic83s92nb9s83w19cxxps3";
            };
            wires = asGit <ertes-src/wires> {
                rev = "53ad7aae155d420f3de7bd7222fe13f05fe13110";
                sha256 = "1nhq61rqfv8m0yiw7h8hmwmbvll7cx6f9yyp8ymf8rrhdk5fhd4i";
            };
        };

    packageOverrides = super: let self = super.pkgs; in {

        busybox = super.busybox.override { enableStatic = true; useMusl = true; };

        ertes-base = super.buildEnv {
            name = "ertes-base";
            paths = with self; [
                aircrack-ng
                bedup
                cacert
                connect
                curl
                darcs
                dict
                emacs
                emacsPackages.darcsum
                emacsPackages.org
                emacsPackages.proofgeneral
                emacsPackagesNg.geiser
                emacsPackagesNg.haskell-mode
                emacsPackagesNg.jq-mode
                emacsPackagesNg.magit
                emacsPackagesNg.markdown-mode
                emacsPackagesNg.paredit
                emacsPackagesNg.yaml-mode
                emacsPackagesNg.yasnippet

                emacsPackagesNg.company
                emacsPackagesNg.dash-functional
                emacsPackagesNg.f
                emacsPackagesNg.flycheck

                # emacsPackagesNg.dash
                # emacsPackagesNg.let-alist
                # emacsPackagesNg.s
                # emacsPackagesNg.seq

                execline
                fdupes
                file
                fortune
                gcc
                gitAndTools.gitFull
                gitAndTools.hub
                gnumake
                gnupg
                gptfdisk
                graphicsmagick
                iotop
                isync
                iw
                jq
                lftp
                libressl
                llvm
                lm_sensors
                manpages
                mkpasswd
                nix-repl
                nmap
                notmuch
                p7zip
                pari
                pciutils
                posix_man_pages
                rfkill
                psmisc
                pv
                pwgen
                renameutils
                s6
                screen
                smartmontools
                speedtest-cli
                sqlite
                sshfsFuse
                tcpdump
                termdown
                unzip
                usbutils
                vmtouch
                wget
                whois
                wirelesstools
                zip
            ];
        };

        ertes-dev = super.buildEnv {
            name = "ertes-dev";
            paths = with self; [
                cabal2nix
                coq
                ghc-env
                ghostscript
                gnuplot
                maxima
                pandoc
                pypi2nix
                python-env
                texlive.combined.scheme-basic
            ];
        };

        ertes-gui = super.buildEnv {
            name = "ertes-gui";
            paths = with self; [
                audacity
                beets
                blender
                chocolateDoom
                compton-git
                disk_indicator
                feh
                ffmpeg
                firefox-esr
                gajim
                geeqie
                gimp
                glxinfo
                gmrun
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
                palemoon
                pavucontrol
                redshift
                rxvt_unicode
                scrot
                syncthing
                t
                torbrowser
                transmission
                transmission-remote-cli
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

        ghc-env = self.haskellPackages.ghcWithPackages (p: with p; [
            ad
            aeson
            arithmoi
            async
            base16-bytestring
            base64-bytestring
            cabal-install
            clock
            comonad
            criterion
            cryptonite
            exceptions
            fingertree
            free
            generic-deriving
            ghc-datasize
            gl
            hasktags
            hscolour
            http-conduit
            kan-extensions
            lens
            lens-aeson
            linear
            machines
            megaparsec
            mwc-random
            network
            pipes
            progress-meter
            QuickCheck
            random
            rapid
            rapid-term
            # reflex
            resourcet
            sdl2
            sqlite-simple
            stm
            streams
            text
            vector
            # wires
        ]);

        ghcjs-env = super.haskell.packages.ghcjs.ghcWithPackages (p: with p; [
            ghcjs-dom
            reflex
            reflex-dom
            text
            vector
        ]);

        python-env = super.python3.withPackages(p: with p; [
            pyrsistent
            requests
        ]);
    };
}
