{
  # Make sure that `/var/lib/sops` is owned by root and is not world-readable/writable
  sops.gnupgHome = "/var/lib/sops";
  # disable import host ssh keys
  sops.sshKeyPaths = [];
  sops.defaultSopsFile = ../../../secrets/secrets.yaml;
}