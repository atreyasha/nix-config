{
  programs.rofi = {
    enable = true;
    theme = "gruvbox-dark-hard";
    extraConfig = {
      ''
      configuration {
        modi: "drun";
        font: "mono 11";
        bw: 0;
        location: 1;
        disable-history: false;
        line-margin: 0;
        line-padding: 1;
        separator-style: "none";
      }

      @theme "gruvbox-dark-hard"

      listview {
        lines: 20;
        columns: 9;
      }

      window {
        width: 100%;
        }
    '';
    };
  };
}
