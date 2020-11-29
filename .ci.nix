let
  inherit (builtins) fromJSON readFile mapAttrs hasAttr concatStringsSep removeAttrs;
  j = fromJSON (readFile ./.ci.json);
in
mapAttrs
  (k: v:
    if hasAttr "packages" v then
      let
        packages = v.packages;
        script = v.script;
      in
      removeAttrs
        (v // {
          script = ''
            nix shell ${concatStringsSep " " (map (p: "nixpkgs#${p}") packages)} -c bash <<NIX
            ${script}
            NIX 
          '';
        }) [ "packages" ]
    else v
  )
  j
