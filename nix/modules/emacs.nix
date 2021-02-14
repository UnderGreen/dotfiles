{ pkgs, ... }:

{
  services.emacs.defaultEditor = true;

  home-manager.users.greenday = {
    programs = {
      emacs = {
        enable = true;
        extraPackages = epkgs:
          with epkgs; [
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
          ];
      };
    };

    services.emacs = { enable = true; };

    home.file.".emacs.d" = {
      source = ./emacs;
      recursive = true;
    };
  };
}
