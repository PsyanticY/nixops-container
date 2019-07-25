{
  config_exporters = { optionalAttrs, ... }: [
    (config: { container = optionalAttrs (config.deployment.targetEnv == "container") config.deployment.container; })
  ];
  options = [
    ./container.nix
  ];
  resources = { ... }: {};
}
