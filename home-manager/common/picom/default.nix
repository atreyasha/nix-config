{
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    fadeSteps = [ 0.03 0.03 ];
    backend = "glx";
    vSync = true;
  };
}
