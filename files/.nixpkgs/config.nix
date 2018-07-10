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
            # myxmonad = self.callPackage ../cfg/my/myxmonad {};
            #powermate = asGit <ertes-src/powermate> {
            #    rev = "ed4381827bcb197cb1fd4a63c2e04bcdb7548899";
            #    sha256 = "1bj073phaij38b057adsgqbvqr2lvv99vicxixmysvj8r4gnz57l";
            #};
            #progress-meter = asGit <ertes-src/progress-meter> {
            #    rev = "refs/heads/master";
            #    sha256 = "01c2kklz5z544q17cqghxvc0cx0wa27h6i6km1a5aaypw6l0w03d";
            #};
            #rapid = asGit <ertes-src/rapid> {
            #    rev = "refs/heads/master";
            #    sha256 = "08gagxsczcan41ks00iifrpl05y083wnrz73mp8ssnv72f0jjnnp";
            #};
            #rapid-term = asGit <ertes-src/rapid-term> {
            #    rev = "refs/heads/master";
            #    sha256 = "1cx2fnkk6vc93gczdwalx9n1z0p4haghnxj8clp1zkl5nnajarj7";
            #};
            #reflex = asGit <ertes-src/reflex> {
            #    rev = "refs/heads/develop";
            #    sha256 = "1835njkbrv7mbqa000zldhfvi9zhz5ic83s92nb9s83w19cxxps3";
            #};
            #wires = asGit <ertes-src/wires> {
            #    rev = "53ad7aae155d420f3de7bd7222fe13f05fe13110";
            #    sha256 = "1nhq61rqfv8m0yiw7h8hmwmbvll7cx6f9yyp8ymf8rrhdk5fhd4i";
            #};
        };

    packageOverrides = super: let self = super.pkgs; in {

        ertes-base = super.buildEnv {
            name = "ertes-base";
            paths = with self; [
                aircrack-ng
                bedup
                btrbk
                cacert
                connect
                curl
                darcs
                devtodo
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
                emacsPackagesNg.nix-mode
                emacsPackagesNg.paredit
                emacsPackagesNg.php-eldoc
                emacsPackagesNg.php-mode
                emacsPackagesNg.restclient
                emacsPackagesNg.yaml-mode
                emacsPackagesNg.yasnippet

                emacsPackagesNg.dash-functional
                emacsPackagesNg.f

                # execline
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
                htmlTidy
                imagemagick
                iotop
                isync
                iw
                jq
                lame
                lftp
                libressl
                llvm
                lm_sensors
                manpages
                minicom
                mkpasswd
                mpg123
                nix-repl
                nmap
                notmuch
                p7zip
                pari
                patchelf
                pciutils
                posix_man_pages
                postgresql100
                rfkill
                psmisc
                pv
                pwgen
                renameutils
                rss2email
                s6
                screen
                smartmontools
                speedtest-cli
                sqlite
                sshfsFuse
                tcpdump
                termdown
                trickle
                unison
                unar
                unzip
                usbutils
                vmtouch
                vorbisTools
                wget
                whois
                wirelesstools
                zip
            ];
        };

        ertes-dev = super.buildEnv {
            name = "ertes-dev";
            paths = with self; [
                avrbinutils
                avrdude
                avrgcc
                avrlibc
                cabal2nix
                coq
                doxygen
                emscripten
                emscriptenPackages.zlib
                ghc-env
                ghostscript
                gnuplot
                libxml2
                maxima
                nix-prefetch-git
                pandoc
                pkgconfig
                pypi2nix
                python3-env
                SDL2
                SDL2_gfx
                SDL2_image
                SDL2_mixer
                SDL2_net
                SDL2_ttf
                texlive.combined.scheme-basic
                zlib
            ];
        };

        ertes-gui = super.buildEnv {
            name = "ertes-gui";
            paths = with self; [
                arx-libertatis
                audacity
                bb
                beets
                blender
                chirp
                chocolateDoom
                claws-mail
                compton-git
                disk_indicator
                dwarf-fortress
                easytag
                endless-sky
                feh
                firefox
                ffmpeg
                gajim
                geeqie
                gimp
                glxinfo
                gmrun
                gucharmap
                # haskellPackages.myxmonad
                # haskellPackages.xmobar
                i3lock
                inkscape
                keepassx
                kid3
                krita
                ledger
                mpc_cli
                mpd
                mpv
                ncmpc
                notify-desktop
                openmw
                pavucontrol
                ppsspp
                redshift
                rxvt_unicode
                sc-controller
                scrot
                scummvm
                stalonetray
                steam-run
                sonata
                syncthing
                tiled
                # torbrowser
                trayer
                unclutter
                virtmanager
                wine
                wireshark
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
            concurrent-machines
            criterion
            cryptonite
            digest
            exceptions
            fingertree
            free
            generic-deriving
            gl
            hasktags
            hscolour
            http-conduit
            JuicyPixels
            kan-extensions
            lens
            lens-aeson
            linear
            logict
            machines
            megaparsec
            mwc-random
            network
            pipes
            postgresql-simple
            progress-meter
            QuickCheck
            random
            rapid
            rapid-term
            # reflex
            resourcet
            scotty
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

        python3-env = super.python3.withPackages (p: with p; [
            pyrsistent
            requests
        ]);
    };
}
