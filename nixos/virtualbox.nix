{ lib, ... }:

with lib;

{
  # enable guest additions
  virtualisation.virtualbox.guest.enable = true;

  # FIXME: UUID detection is currently broken
  boot.loader.grub.fsIdentifier = "provided";

  # add some more video drivers to give X11 a shot at working in
  # VMware and QEMU.
  services.xserver.videoDrivers = mkOverride 40 [ "virtualbox" "vmware" "cirrus" "vesa" "modesetting" ];

  # disable power management
  powerManagement.enable = false;
}
