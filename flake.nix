{
  description = ''Helper procs for SCGI applications'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."scgi-master".dir   = "master";
  inputs."scgi-master".owner = "nim-nix-pkgs";
  inputs."scgi-master".ref   = "master";
  inputs."scgi-master".repo  = "scgi";
  inputs."scgi-master".type  = "github";
  inputs."scgi-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."scgi-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}