{ rustPlatform
, pkg-config
, wrapGAppsHook4
, gtk4
, gtk4-layer-shell
, dbus
, libadwaita
, lib
, lockFile
, cargo
, rustc
, ...
}:
let
  cargoToml = builtins.fromTOML (builtins.readFile ../Cargo.toml);
in
rustPlatform.buildRustPackage rec {
  pname = cargoToml.package.name;
  version = cargoToml.package.version;

  src = ../.;

  buildInputs = [
    pkg-config
    gtk4
    gtk4-layer-shell
    libadwaita
    dbus
  ];

  cargoLock = {
    inherit lockFile;
  };

  checkInputs = [ cargo rustc ];

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook4
    cargo
    rustc
  ];
  copyLibs = true;

  meta = with lib; {
    description = "A work in progress notification daemon made with rust and gtk.";
    homepage = "https://github.com/DashieTM/OxiDash";
    changelog = "https://github.com/DashieTM/OxiDash/releases/tag/${version}";
    license = licenses.gpl3;
    maintainers = with maintainers; [ DashieTM ];
    mainProgram = "oxidash";
  };
}
