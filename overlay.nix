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
      version = "4.4.7.7";
      url = "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass_paywalls_clean-4.4.7.7.xpi&commit=749a8e441ce60a349a4d92445a3286833524ea00";
      hash = "sha256-m7khKi5qW2hjvWbwqYflGR3Qfc67BBeDOSjchcM2btk=";
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
