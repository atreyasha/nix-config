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
    searchEngines = {
      DEFAULT = "${defaultPage}/search?q={}";
    };
  };
}
