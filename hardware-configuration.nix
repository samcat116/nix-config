{ lib, ... }:
{
  # Tell nixpkgs what platform we are on (new-style)
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";

  # Virtio-friendly defaults for VMs
  boot.initrd.availableKernelModules = [
    "virtio_pci" "virtio_blk" "virtio_scsi" "xhci_pci" "sd_mod" "sr_mod"
  ];

  # Root filesystem
  fileSystems."/" = {
    device = "/dev/vda";
    fsType = "btrfs";
  };

  swapDevices = [ ];
}
