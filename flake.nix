{
  description = "Bypass Paywalls Clean packaged with Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-firefox-addons = {
      url = "github:OsiPog/nix-firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nix-firefox-addons,
      ...
    }:
    let
      overlay =
        final: prev:
        (import ./overlay.nix (final // { nix-firefox-addons-src = nix-firefox-addons; }) prev);
    in
    {
      overlays.default = overlay;
      overlay = overlay;
    };
}
