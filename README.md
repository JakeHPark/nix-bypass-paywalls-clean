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
  # ...
  home.activation =
    # I'm not adding these helpers to this repo. They should be upstreamed.
    let
      # ...
      # See: https://github.com/nix-community/home-manager/issues/6361#issuecomment-4265948928
      patchJson =
        path: options:
        # `linkGeneration` runs after `writeBoundary`.
        # Writing to the home directory before `linkGeneration` can screw with `home.file` links.
        lib.hm.dag.entryAfter [ "linkGeneration" ] ''
          ${pkgs.coreutils}/bin/mkdir -p "$(${pkgs.coreutils}/bin/dirname "$HOME/${path}")"
          temp="$(${pkgs.coreutils}/bin/mktemp)"
          (${pkgs.coreutils}/bin/cat "$HOME/${path}" 2>/dev/null || printf '%s' '{}') \
            | ${pkgs.jq}/bin/jq --argjson patch ${lib.escapeShellArg (builtins.toJSON options)} '. * $patch' > "$temp"
          ${pkgs.coreutils}/bin/mv "$temp" "$HOME/${path}"
        '';

      # Home Manager tries to do this via `home.file`, which prevents dynamic state updates
      # and often doesn't work at all.
      # See: https://github.com/nix-community/home-manager/issues/4889#issuecomment-4265963138
      patchFirefoxExtension =
        id: options: patchJson ".mozilla/firefox/default/browser-extension-data/${id}/storage.js" options;
      # ...
    in
    {
      # ...
      # Configure it however you want.
      # See: `~/.mozilla/firefox/default/browser-extension-data/magnolia@12.34/storage.js`
      bypassPaywallsClean = patchFirefoxExtension "magnolia@12.34" {
        optIn = true;
        optInFetch = true;
        optInShown = true;
        customShown = true;
        fetchShown = true;

        sites = {
          "Enable new sites by default" = "#options_enable_new_sites";
          "Check for update rules at startup" = "#options_optin_update_rules";
        };
      };
      # ...
    };
  # ...
};
```
