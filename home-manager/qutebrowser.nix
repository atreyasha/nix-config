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
      DEFAULT = "https://www.google.com/search?q={}";
    };
    # config.bind('K', 'tab-next')
    # config.bind('J', 'tab-prev')
    # config.bind('gK', 'tab-move +')
    # config.bind('gJ', 'tab-move -')
    # config.bind('<Ctrl-h>', 'scroll-page -0.2 0')
    # config.bind('<Ctrl-j>', 'scroll-page 0 0.2')
    # config.bind('<Ctrl-k>', 'scroll-page 0 -0.2')
    # config.bind('<Ctrl-l>', 'scroll-page 0.2 0')
    # config.bind('h', 'scroll-page -0.05 0')
    # config.bind('j', 'scroll-page 0 0.05')
    # config.bind('k', 'scroll-page 0 -0.05')
    # config.bind('l', 'scroll-page 0.05 0')
  };
}
