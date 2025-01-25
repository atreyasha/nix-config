{ pkgs, ... }:

{
  programs.gpg = {
    enable = true;
    publicKeys = [];
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    enableSshSupport = true;
    maxCacheTtl = 86400;
    maxCacheTtlSsh = 86400;
    defaultCacheTtl = 86400;
    defaultCacheTtlSsh = 86400;
    pinentryPackage = pkgs.pinentry-gnome3;
    sshKeys = [];
  };
}
