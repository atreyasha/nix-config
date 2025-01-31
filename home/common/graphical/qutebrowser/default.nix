let
  defaultPage = "https://www.google.com";
in
{
  programs.qutebrowser = {
    enable = true;
    settings = {
      fonts.default_size = "11pt";
      zoom.default = "110%";
      content.javascript.clipboard = "access-paste";
      editor.command = ["i3-sensible-terminal" "-e" "vim" "{file}"];
      scrolling.bar = "always";
      url.default_page = "${defaultPage}";
      url.start_pages = [ "${defaultPage}" ];
    };
    keyBindings = {
      normal = {
        "gK" = "tab-move +";
        "gJ" = "tab-move -";
      };
    };
    searchEngines = {
      DEFAULT = "${defaultPage}/search?q={}";
    };
  };

  # configure XDG for qutebrowser
  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "org.qutebrowser.qutebrowser.desktop" ];
    "x-scheme-handler/http" = [ "org.qutebrowser.qutebrowser.desktop" ];
    "x-scheme-handler/https" = [ "org.qutebrowser.qutebrowser.desktop" ];
    "x-scheme-handler/about"= [ "org.qutebrowser.qutebrowser.desktop" ];
    "x-scheme-handler/unknown" = [ "org.qutebrowser.qutebrowser.desktop" ];
  };
}
