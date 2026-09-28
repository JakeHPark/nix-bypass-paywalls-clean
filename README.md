# Nix Bypass Paywalls Clean

Automatically packages the latest build of Bypass Paywalls Clean with Nix. First, add this repository as an input to your flake:

```nix
{
  # ...
  inputs = {
    # ...
    nix-firefox-addons.url = "github:OsiPog/nix-firefox-addons";

    nix-bypass-paywalls-clean = {
      url = "github:JakeHPark/nix-bypass-paywalls-clean";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-firefox-addons.follows = "nix-firefox-addons";
    };
    # ...
  };
  # ...
}
```

Then apply the overlay:

```nix
{ inputs, ... }: {
  # ...
  nixpkgs.overlays = [
    inputs.nix-firefox-addons.overlays.default
    inputs.nix-bypass-paywalls-clean.overlays.default
    # ...
  ];
  # ...
}
```

Then in your [Home Manager](https://nix-community.github.io/home-manager/) configuration:

```nix
{ lib, pkgs, ... }: {
  # ...
  programs.firefox = {
    enable = true;
    # ...
    profiles.default = {
      extensions = {
        packages = with pkgs.firefoxAddons; [
          bypass-paywalls-clean
        ];
      };

      # Optional: without this the addons need to be enabled manually after first install.
      settings = {
        "extensions.autoDisableScopes" = 0;
      };
    };
  };
};
```

And you can configure it with [Nix Home Utils](https://github.com/JakeHPark/nix-home-utils):

```nix
{
  nix-home-utils.bypassPaywallsClean = {
    enable = true;
    # These are set by default for convenience:
    enableNewSitesByDefault = true;
    checkUpdateRulesAtStartup = true;
    showOptionsOnUpdate = false;
  };
}
```
