{
  programs.qutebrowser = {
    enable = true;
    settings = {
      content.javascript.clipboard = "access-paste";
      editor.command = ["i3-sensible-terminal" "-e" "vim" "{file}"];
    };
  };
}
