# nix run github:nix-community/nixos-generators -- --format proxmox --configuration vm.nix
{pkgs, ...}: let
  keys = [
    # kraairm2
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGqesfGzltPA+pNVQ667T1tKzQoz09qTcoQshygxl73I3EbYD5vnHFtC+tnziVbfxSx8ZDRvPDN7vHEalE5U3JU="

    # pptech
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPunOvQgmyeb53IYJs6kxtY2TUpy+2BksnuHANN7vT7T"
  ];
in {
  services.openssh = {
    enable = true;
    # require public key authentication for better security
    passwordAuthentication = true;
    kbdInteractiveAuthentication = true;
    permitRootLogin = "yes";
  };

  users.users."root" = {
    openssh.authorizedKeys.keys = keys;
    hashedPassword = "$6$k6JhsM4oLMG/FOGR$cB.HgMnm6vhDwoGo6XGPMkODmhE2Ku12ApMnquj3Wlxd/1e5P14fSt8FgpFUDSUbRNkw/ThTU9ALXr0hfxpBp.";
  };

  users.users."pp31tech" = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = keys;
    hashedPassword = "$6$k6JhsM4oLMG/FOGR$cB.HgMnm6vhDwoGo6XGPMkODmhE2Ku12ApMnquj3Wlxd/1e5P14fSt8FgpFUDSUbRNkw/ThTU9ALXr0hfxpBp.";
    extraGroups = ["wheel"];
  };

  security.sudo = {
    enable = true;
  };

  networking.firewall.enable = false;
}
