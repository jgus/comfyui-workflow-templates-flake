{
  description = "ComfyUI workflow templates package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-lib = {
      url = "github:jgus/flake-lib/v1";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils, flake-lib }:
    flake-lib.lib.mkLeafFlake {
      inherit nixpkgs flake-utils;
      source = { type = "pypi"; pname = "comfyui_workflow_templates"; format = "sdist"; };
      package = {
        attr = "comfyui-workflow-templates";
        description = "ComfyUI workflow templates package";
        # Upstream lists comfyui-workflow-templates-core / -media-* as required deps but they aren't on PyPI; the consuming flake supplies what's actually needed.
        extra = { dontCheckRuntimeDeps = true; };
      };
      pin = import ./pin.nix;
    };
}
