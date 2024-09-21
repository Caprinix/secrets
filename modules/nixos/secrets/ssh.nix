{
  systemSecretsDir,
  homeDir,
}:
{
  "ssh/id_private" = {
    path = "${homeDir}/.ssh/id_ed25519";
    format = "binary";
    sopsFile = "${systemSecretsDir}/ssh/id_ed25519.sops";
    owner = "replicapra";
    group = "users";
  };
  "ssh/id_public" = {
    path = "${homeDir}/.ssh/id_ed25519.pub";
    format = "binary";
    sopsFile = "${systemSecretsDir}/ssh/id_ed25519.pub.sops";
    owner = "replicapra";
    group = "users";
  };
  "ssh/host_private" = {
    path = "/etc/ssh/ssh_host_ed25519_key";
    format = "binary";
    sopsFile = "${systemSecretsDir}/ssh/ssh_host_ed25519_key.sops";
  };
  "ssh/host_public" = {
    path = "/etc/ssh/ssh_host_ed25519_key.pub";
    format = "binary";
    sopsFile = "${systemSecretsDir}/ssh/ssh_host_ed25519_key.pub.sops";
  };
}
