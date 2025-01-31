{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      set selection-clipboard clipboard
    '';
  };

  # configure XDG for zathura
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = [ "org.pwmt.zathura-pdf-mupdf.desktop" ];
  };
}
