{
  inputs,
  config,
  system,
  lib,
  ...
}:
let
  inherit (lib) mkDefault;

  hostname = config.networking.hostName;
  systemSecretsDir = ../../../systems/${system}/${hostname};
in
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  config = {
    sops = {
      defaultSopsFile = "${systemSecretsDir}/secrets.yaml";
      validateSopsFiles = true;

      age = {
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        keyFile = mkDefault "/persistent/system/var/lib/sops-nix/key.txt";
        generateKey = true;
      };

      secrets = { };
    };
  };
}
