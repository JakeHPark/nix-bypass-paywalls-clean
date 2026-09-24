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
      version = "4.4.5.3";
      url = "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass_paywalls_clean-4.4.5.3.xpi&commit=217c32f8e77ae704e566268c7a53eb1550748f91";
      hash = "sha256-u/pzC39fipj5iz5GF0kEfyMm/mp7kPkdJr/o5VtDtbU=";
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
