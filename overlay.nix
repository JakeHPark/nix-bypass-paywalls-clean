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
      version = "4.3.8.7";
      url = "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass_paywalls_clean-4.3.8.7.xpi&commit=613c7314916ca9e345a6f85b7ae179f081093655";
      hash = "sha256-0tCSU4jq8WyzWhq13E65xrbWXmV5QEnJxD3Exs6l65E=";
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
