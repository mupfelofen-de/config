{ pkgs, lib, ... }:
let
in
{
  home.packages = with pkgs; [
    # Essentials
    rxvt_unicode

    # Audio/Video
    audacity
    beets
    easytag
    ffmpeg
    kid3
    lame
    mpc_cli
    mpg123
    mpd
    mpv
    ncmpc
    sonata
    vorbisTools
    youtube-dl

    # Communication/Web
    chirp
    claws-mail
    minicom
    pidgin-with-plugins
    firefox
    tcpdump
    tdesktop

    # Connectivity/Networking
    aircrack-ng
    connect
    nmap
    putty
    lftp
    screen
    speedtest-cli
    telnet
    wirelesstools
    wireshark
    wget

    # Desktop
    gmrun
    i3lock
    kdeconnect
    keepassx
    krename
    notify-desktop
    pavucontrol
    rofi
    scrot
    skippy-xd
    trayer
    unclutter
    xclip
    xlibs.xbacklight
    xlibs.xev
    xlibs.xmodmap
    xlibs.xwininfo
    xorg.xinput

    # Engineering/Development
    androidStudioPackages.beta
    bat
    bench
    cabal2nix
    cargo
    clang-tools
    cloc
    cmake
    coq
    cppcheck
    darcs
    doxygen
    dsview
    emacs
    emacsPackages.darcsum
    emacsPackages.org
    emacsPackages.proofgeneral
    emacsPackagesNg.dash-functional
    emacsPackagesNg.f
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
    esptool
    gcc
    gcc-arm-embedded-7
    gdb
    ghostscript
    gitAndTools.gitFull
    gitAndTools.hub
    global
    gnumake
    graphviz
    kicad
    nasm
    pandoc
    pkgconfig
    platformio
    python3
    qucs
    retdec
    rtags
    rustc
    swig
    tiled
    valgrind

    # Games/Demos
    arx-libertatis
    bb
    chocolateDoom
    dosbox
    dwarf-fortress
    endless-sky
    openmw
    ppsspp
    sc-controller
    scummvm

    # Graphics
    blender
    geeqie
    gimp
    graphicsmagick
    imagemagick
    inkscape
    krita

    # Libraries
    librecad
    libressl
    libsndfile
    libusb
    libxml2
    zlib

    # Office
    libreoffice
    masterpdfeditor
    zathura

    # System/Utils
	  sourceHighlight
    bchunk
    bedup
    btrbk
    cacert
    curl
    devtodo
    dict
    disk_indicator
    fdupes
    file
    fortune
    fzf
    glxinfo
    gnupg
    gptfdisk
    gucharmap
    htmlTidy
    iotop
    isync
    iw
    jmtpfs
    jq
    jre
    llvm
    lm_sensors
    manpages
    mkpasswd
    mtools
    nix-prefetch-git
    p7zip
    pari
    patchelf
    pciutils
    posix_man_pages
    psmisc
    pv
    pwgen
    redshift
    renameutils
    rfkill
    rss2email
    s6
    smartmontools
    sshfsFuse
    steam-run-native
    syncthing
    termdown
    trickle
    unar
    unison
    unzip
    usbutils
    virt-viewer
    virtmanager
    vmtouch
    wine-staging
    winetricks
    zip
  ];

  programs.home-manager.enable = true;
}
