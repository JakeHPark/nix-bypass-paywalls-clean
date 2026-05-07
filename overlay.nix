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
      version = "4.3.6.5";
      url = "https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=bypass_paywalls_clean-4.3.6.5.xpi&commit=e108d0ff124c3fc440ab61cec57393ea83660fad";
      hash = "sha256-paBt/jH2kOWwjEozVjGh8ruNhFJ0gPvy2KFbEaBtv/s=";
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
