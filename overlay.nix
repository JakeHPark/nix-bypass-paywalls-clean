final: prev:
let
  buildFirefoxXpiAddon = import "${final.nix-firefox-addons-src}/src/lib/build-firefox-xpi-addon.nix" final;
in
{
  # See: https://github.com/OsiPog/nix-firefox-addons/issues/6
  firefoxAddons = prev.firefoxAddons // {
    bypass-paywalls-clean = buildFirefoxXpiAddon {
      guid = "magnolia@12.34";
      slug = "bypass-paywalls-clean";
      version = "4.4.8.4";
      url = "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass_paywalls_clean-4.4.8.4.xpi&commit=f1e0747c53054084658fcdb301c42ef19840d9cd";
      hash = "sha256-lR9sNJyR/B2ECoz+W+SP8/6eC1DcWklHnVtYudVGVBQ=";
      permissions = [
        "<all_urls>"
        "cookies"
        "storage"
        "activeTab"
        "webRequest"
        "webRequestBlocking"
      ];
      license = "MIT";
    };
  };
}
