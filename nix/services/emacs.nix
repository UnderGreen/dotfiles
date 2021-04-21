{ pkgs, emacsPackage ? pkgs.emacs-nox, ... }:

let
  myEmacs = (pkgs.emacsPackagesGen emacsPackage).emacsWithPackages (epkgs:
    (with epkgs.melpaPackages; [
      doom-modeline
      dracula-theme
      ivy
      magit
      nix-mode
      rainbow-delimiters
      swiper
      use-package
    ]));
in {
  services.emacs = {
    enable = true;
    install = false;
    defaultEditor = true;
    package = myEmacs;
  };
}
