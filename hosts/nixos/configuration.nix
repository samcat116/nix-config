{ config, pkgs, modulesPath, inputs, ... }:

{
  imports = [
    # Include the default lxd configuration
    "${modulesPath}/virtualisation/lxc-container.nix"
    # Hardware configuration
    ./hardware-configuration.nix
    # OrbStack and Incus specific configs
    ./incus.nix
    ./orbstack.nix
  ];

  # Basic system configuration
  nixpkgs.hostPlatform = "aarch64-linux";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # System packages
  environment.systemPackages = with pkgs; [
    wget
    ripgrep
  ];

  # User configuration
  users.users.sam = {
    uid = 501;
    extraGroups = [ "wheel" "orbstack" ];

    # Simulate isNormalUser, but with an arbitrary UID
    isSystemUser = true;
    group = "users";
    createHome = true;
    home = "/home/sam";
    homeMode = "700";
    useDefaultShell = true;
  };

  # Terminal and sudo configuration
  environment.enableAllTerminfo = true;
  security.sudo.wheelNeedsPassword = false;
  users.mutableUsers = false;

  # Time zone
  time.timeZone = "America/New_York";

  # Shell configuration
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Git configuration (system-wide)
  programs.git.enable = true;


  # NixOS Helper (nh)
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos/";
  };

  # Network configuration
  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };

  systemd.network = {
    enable = true;
    networks."50-eth0" = {
      matchConfig.Name = "eth0";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };

  # Home-manager configuration (nvf integration)
  home-manager.sharedModules = [ inputs.nvf.homeManagerModules.default ];

  # Extra certificates from OrbStack
  security.pki.certificates = [
    ''
      -----BEGIN CERTIFICATE-----
MIICDDCCAbKgAwIBAgIQaEe54e8KSo3a/bo7VF+OuzAKBggqhkjOPQQDAjBmMR0w
GwYDVQQKExRPcmJTdGFjayBEZXZlbG9wbWVudDEeMBwGA1UECwwVQ29udGFpbmVy
cyAmIFNlcnZpY2VzMSUwIwYDVQQDExxPcmJTdGFjayBEZXZlbG9wbWVudCBSb290
IENBMB4XDTI0MTEzMDE3MzYxNloXDTM0MTEzMDE3MzYxNlowZjEdMBsGA1UEChMU
T3JiU3RhY2sgRGV2ZWxvcG1lbnQxHjAcBgNVBAsMFUNvbnRhaW5lcnMgJiBTZXJ2
aWNlczElMCMGA1UEAxMcT3JiU3RhY2sgRGV2ZWxvcG1lbnQgUm9vdCBDQTBZMBMG
ByqGSM49AgEGCCqGSM49AwEHA0IABOH0Hc9zGUmrXeVuM0YyP1vA0q7PIRW78yrd
UcsvfXlBF+UYrZ6J0NfV6UPTkujGWqDuJ2B8IXgTtnFFNTPRE8qjQjBAMA4GA1Ud
DwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBT0vsKARq5SDOs6
qa+THgH3sZtzzjAKBggqhkjOPQQDAgNIADBFAiEAjl1zYFI238I/BWfQ6vUGWNXG
Vl8v2HCXL2Rty1jBAOYCIHoLQsI/FexakFknD86xPruI9lAzHD9VqrVnqYZTrF9n
-----END CERTIFICATE-----

-----BEGIN CERTIFICATE-----
MIIE2zCCA0OgAwIBAgIQfxxq4oTUQ4RU3kQhtHgYxzANBgkqhkiG9w0BAQsFADCB
hTEeMBwGA1UEChMVbWtjZXJ0IGRldmVsb3BtZW50IENBMS0wKwYDVQQLDCRzYW1A
TWFjLmxvY2FsZG9tYWluIChTYW11ZWwgU2NobWl0dCkxNDAyBgNVBAMMK21rY2Vy
dCBzYW1ATWFjLmxvY2FsZG9tYWluIChTYW11ZWwgU2NobWl0dCkwHhcNMjUxMDAx
MDE1OTA1WhcNMzUxMDAxMDE1OTA1WjCBhTEeMBwGA1UEChMVbWtjZXJ0IGRldmVs
b3BtZW50IENBMS0wKwYDVQQLDCRzYW1ATWFjLmxvY2FsZG9tYWluIChTYW11ZWwg
U2NobWl0dCkxNDAyBgNVBAMMK21rY2VydCBzYW1ATWFjLmxvY2FsZG9tYWluIChT
YW11ZWwgU2NobWl0dCkwggGiMA0GCSqGSIb3DQEBAQUAA4IBjwAwggGKAoIBgQDT
A5JT1Azjnz1e5tMv0dy2l/1qKG1woxlW/qGLKKdnQ3tCOb0cG6CGi+O9yg0geOxQ
zR/fghEcR72Z2buKPHhh4oXkd8920HGm00SgAguOw8+I4CWtVph3Sr/GvA/Vwe0X
1GOj3cuObx+ZqbPVmCgjJeLtP2eG+AY3QVpZUG0BtsBuLa3kbNMW2l/Bp0GGHDWx
9I9rIZMhdaR5WlSQZQs3y3GloRRdHDA5Cf+cPG8MSPBcwMGg6fRKljeCpX9RFRO6
pIqDEZh29AEDgN41ZxSh6fCrpFbbEKjwaSunSvGypQlF6GEr5TOn7SNMe91U9jsj
zEd2+9YXdhDOf3KpOMOvqyNmvM6sbXCMmFOgVeDrMPsXYKqVinlTj2Leett1+pU0
fFfn2YxOr32qmLXKvqyDecXBbG9KvMbL5Oqs+bNdouZfhmVLd8EZzIFgez0TdJG3
MilGOTDjsRFy94E83zq3LSz7LQRk0YD9fh37gzb5kIkqYzSQ42FCcgvWcgBTaNMC
AwEAAaNFMEMwDgYDVR0PAQH/BAQDAgIEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYD
VR0OBBYEFL4JVwqsV0hWpToWTa/Ebl32gRhEMA0GCSqGSIb3DQEBCwUAA4IBgQCH
VMn3xbIxXDILEKPfy1wXBSM0RhY1pcR4TmLv02gu6D1ppCerq6tDU2A5fOIy6CDS
BdnLCNleildm9ttd3Lj5A2rtlWOykoDdXYiU7x6SXMlpQ+y0HOf2EfNmSpwwsDlr
PFZaVvYLqO4mrRg4kVJjrQnt8xD6lx7398bVMR/7lFXMvu3SIsiKpyzwD+JsMwl0
SNbWv6C0VBEARC1H5WKv00hquSoRTcNiyKCCmsAYZ4Y94liiSDut5O+H1AjmhzcO
O+nDtTkC3/ho6rnKd9dV6pcEEaEJtwZAoJFwBEPKNfKkgC+o8QOJp7mzWfrrUhor
TyKLNc0Q8JhKg2/an6l/px+MgHyqn7UyFB3+xjtx4LG4RsoaxRfdq9dDD34/7lLg
xvJqbXzr8yc8xn7ySIliUJICNzNF8ySy4VYxB++XFBkQuPF/wAOZDktZz6rpG+u1
zMUvjGYYShgZueR1YvcD0Q+iUL6pKxZkZA4TSoEop2ZFpHBR/TJrjgYdMWJ1j6Y=
-----END CERTIFICATE-----

-----BEGIN CERTIFICATE-----
MIICDDCCAbKgAwIBAgIQaEe54e8KSo3a/bo7VF+OuzAKBggqhkjOPQQDAjBmMR0w
GwYDVQQKExRPcmJTdGFjayBEZXZlbG9wbWVudDEeMBwGA1UECwwVQ29udGFpbmVy
cyAmIFNlcnZpY2VzMSUwIwYDVQQDExxPcmJTdGFjayBEZXZlbG9wbWVudCBSb290
IENBMB4XDTI0MTEzMDE3MzYxNloXDTM0MTEzMDE3MzYxNlowZjEdMBsGA1UEChMU
T3JiU3RhY2sgRGV2ZWxvcG1lbnQxHjAcBgNVBAsMFUNvbnRhaW5lcnMgJiBTZXJ2
aWNlczElMCMGA1UEAxMcT3JiU3RhY2sgRGV2ZWxvcG1lbnQgUm9vdCBDQTBZMBMG
ByqGSM49AgEGCCqGSM49AwEHA0IABOH0Hc9zGUmrXeVuM0YyP1vA0q7PIRW78yrd
UcsvfXlBF+UYrZ6J0NfV6UPTkujGWqDuJ2B8IXgTtnFFNTPRE8qjQjBAMA4GA1Ud
DwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBT0vsKARq5SDOs6
qa+THgH3sZtzzjAKBggqhkjOPQQDAgNIADBFAiEAjl1zYFI238I/BWfQ6vUGWNXG
Vl8v2HCXL2Rty1jBAOYCIHoLQsI/FexakFknD86xPruI9lAzHD9VqrVnqYZTrF9n
-----END CERTIFICATE-----

    ''
  ];

  system.stateVersion = "25.05";
}
