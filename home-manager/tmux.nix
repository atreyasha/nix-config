{ config, ... }:

{
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    mouse = true;
    terminal = "screen-256color";
    prefix = "C-a";
    escapeTime = 10;
    keyMode = "vi";
    extraConfig = ''
      # leftover core setup
      set -g bell-action none
      setw -g xterm-keys on

      # status bar
      set -g status-interval 1
      set -g status-position bottom
      set -g status-right '#(date +"%b %_d %H:%M") | #(whoami)@#(hostname -s)'

      # key bindings
      bind ! split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind b break-pane
      bind k confirm kill-window
      bind q confirm kill-session
      bind r source-file ${config.xdg.configHome}/tmux/tmux.conf
      bind t select-layout tiled
      bind x kill-pane
      bind -n S-Left previous-window
      bind -n S-Right next-window
      bind -n M-S-Left resize-pane -L 5
      bind -n M-S-Right resize-pane -R 5
      bind -n M-S-Down resize-pane -D 5
      bind -n M-S-Up resize-pane -U 5

      # vim-like copy & paste
      bind Escape copy-mode
      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xsel -i -p && xsel -o -p | xsel -i -b"
      bind p run "xsel -o | tmux load-buffer - ; tmux paste-buffer"

      # check for ssh sessions
      if-shell 'test "$SSH_CONNECTION"' 'set -g status-bg yellow'
    '';
  };
}
