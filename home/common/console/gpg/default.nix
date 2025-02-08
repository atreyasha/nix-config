{ pkgs, ... }:

{
  programs.gpg = { enable = true; };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    enableSshSupport = true;
    maxCacheTtl = 86400;
    maxCacheTtlSsh = 86400;
    defaultCacheTtl = 86400;
    defaultCacheTtlSsh = 86400;
    pinentryPackage = pkgs.pinentry-gnome3;
    sshKeys = [ "976D820F8536BE33DC2EDDD5BF5A160809FF4089" ];
  };
}
