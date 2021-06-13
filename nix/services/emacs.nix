{ config, pkgs, emacsPackage ? pkgs.emacs-nox, ... }:

let
  myEmacs = (pkgs.emacsPackagesGen emacsPackage).emacsWithPackages (epkgs:
    (with epkgs.melpaPackages; [
      all-the-icons
      company
      counsel
      counsel-projectile
      doom-modeline
      dracula-theme
      editorconfig
      flycheck
      forge
      helpful
      go-mode
      groovy-mode
      ivy
      ivy-rich
      jenkinsfile-mode
      lsp-mode
      lsp-ui
      magit
      markdown-mode
      nix-mode
      projectile
      ripgrep
      rainbow-delimiters
      use-package
      which-key
      yaml-mode
    ]));
in {
  services.emacs = {
    enable = true;
    install = false;
    defaultEditor = true;
    package = myEmacs;
  };

  home-manager.users.greenday = {
    home.file = {
      ".emacs.d" = {
        source = ./emacs;
        recursive = true;
      };

      "fonts.el" = {
        target = ".emacs.d/config/fonts.el";
        text = ''
             (provide 'fonts)
             (set-frame-font "Hack Nerd Font-${toString config.settings.fontSize}")
             (setq default-frame-alist '((font . "Hack Nerd Font-${toString config.settings.fontSize}")))
        '';
      };
    };
  };
}
