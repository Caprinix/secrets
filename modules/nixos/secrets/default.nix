{
  inputs,
  config,
  system,
  lib,
  ...
}:
let
  inherit (lib) mkDefault mkMerge mkEnableOption mkIf;

  cfg = config.caprinix.secrets;

  hostname = config.networking.hostName;
  systemSecretsDir = ../../../systems/${system}/${hostname};
  homeDir = "/home/replicapra";
  sshSecrets = import ./ssh.nix { inherit systemSecretsDir homeDir; };
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  options.caprinix.secrets = {
      enable = mkEnableOption "secrets" // {
        default = true;
      };
  };

  config = mkIf cfg.enable  {
    systemd.tmpfiles.rules = [ "d ${homeDir}/.ssh 0755 replicapra users -" ];

    sops = {
      defaultSopsFile = "${systemSecretsDir}/secrets.yaml";
      validateSopsFiles = true;

      age = {
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        keyFile = mkDefault "/persistent/system/var/lib/sops-nix/key.txt";
        generateKey = true;
      };

      secrets = mkMerge [
        {
          "replicapra/password" = {
            neededForUsers = true;
          };
        }
        sshSecrets
      ];
    };
  };
}
