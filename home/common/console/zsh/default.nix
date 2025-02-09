{ inputs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    history = {
      size = 5000;
      save = 10000;
      extended = true;
      ignoreDups = true;
    };
    historySubstringSearch.enable = true;
    shellAliases = {
      ls = "ls --color=auto";
      ll = "ls -al";
      grep = "grep --color=auto";
    };
    initExtra = ''
      ${builtins.readFile ./completions.zsh}
      ${builtins.readFile ./keybindings.zsh}
      ${builtins.readFile ./options.zsh}
      ${builtins.readFile ./prompt.zsh}
    '';
    profileExtra = ''
      # configure low delay for vim mode change
      export KEYTIMEOUT="1"

      # configure prefix-only search results that are unique
      export HISTORY_SUBSTRING_SEARCH_PREFIXED="1"
      export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE="1"
    '';
    logoutExtra = ''
      # conditionally kill gpg-agent and clear console
      if [ "$SHLVL" -le 1 ]; then
        # this segment only gets executed when logging
        # out of base login shell and not a child shell
        if [ -n "$SSH_CONNECTION" ]; then
          # if a ssh-connection is detected
          # then kill gpg-agent when logging out
          # NOTE: only possible to kill own processes:
          # https://superuser.com/questions/137207
          pkill -u "$USER" -x gpg-agent
        fi
        # clear the console for privacy reasons
        clear
      fi
    '';
    plugins = [{
      name = "zsh-system-clipboard";
      src = inputs.zsh-system-clipboard;
    }];
  };
}
