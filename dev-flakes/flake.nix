{
  description = "Python dev shell";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    spacetime = {
      url = "github:mx42/nix_spacetimedb/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs
  outputs =
    {
      nixpkgs,
      spacetime,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      spacetimedb = import spacetime { inherit pkgs; };
    in
    {
      devShells.${system} = {
        python = pkgs.mkShell {
          packages = (
            with pkgs;
            [
              python313
              onefetch
              uv
              ruff
            ]
          );
          shellHook = ''
            onefetch
            uv sync
          '';
        };
        scala = pkgs.mkShell {
          packages = (
            with pkgs;
            [
              sbt
              coursier
              onefetch
              openjdk
            ]
          );
          shellHook = ''
            onefetch
          '';
        };
        docker = pkgs.mkShell {
          packages = (
            with pkgs;
            [
              podman
              podman-compose
            ]
          );
        };
        rust = pkgs.mkShell {
          packages = (
            with pkgs;
            [
              rustc
              rust-analyzer
              cargo
              lld
              pkg-config
              openssl
              onefetch
            ]
          );
          PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
          shellHook = ''
            onefetch
          '';
        };
        spacetime = pkgs.mkShell {
          packages = [
            spacetimedb
          ];
        };
      };
    };
}
