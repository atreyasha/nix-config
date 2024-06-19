{ lib, ... }:

{
  programs.qutebrowser = {
    enable = true;
    settings = {
      content.javascript.clipboard = "access-paste";
      editor.command = lib.mkLiteral ''["i3-sensible-terminal", "-e", "vim", "{file}"]'';
    };
  };
}
