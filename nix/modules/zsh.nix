{ pkgs, lib, ... }:

{
  home-manager.users.greenday.programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      autocd = true;
      history = {
        size = 10000;
      };
      defaultKeymap = "emacs";
      dotDir = ".config/zsh";
      initExtraFirst = ''
        # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
        # Initialization code that may require console input (password prompts, [y/n]
        # confirmations, etc.) must go above this block; everything else may go below.
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '';

      initExtra = ''
        export CLOUD_SDK_HOME="${pkgs.google-cloud-sdk}"
        source "$CLOUD_SDK_HOME/google-cloud-sdk/completion.zsh.inc"

        # Dracula color theme for fzf
        export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'--color=dark --color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f --color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7'
      '';

      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "last-working-dir" ];
        theme = "";
      };

      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./zsh/p10k-config;
          file = "p10k.zsh";
        }
      ];
    };
  };
}
