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
    comfyui-workflow-templates-core = {
      url = "github:jgus/comfyui-workflow-templates-core-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.flake-lib.follows = "flake-lib";
    };
    comfyui-workflow-templates-json = {
      url = "github:jgus/comfyui-workflow-templates-json-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.flake-lib.follows = "flake-lib";
    };
    comfyui-workflow-templates-media-api = {
      url = "github:jgus/comfyui-workflow-templates-media-api-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.flake-lib.follows = "flake-lib";
    };
    comfyui-workflow-templates-media-video = {
      url = "github:jgus/comfyui-workflow-templates-media-video-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.flake-lib.follows = "flake-lib";
    };
    comfyui-workflow-templates-media-image = {
      url = "github:jgus/comfyui-workflow-templates-media-image-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.flake-lib.follows = "flake-lib";
    };
    comfyui-workflow-templates-media-other = {
      url = "github:jgus/comfyui-workflow-templates-media-other-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.flake-lib.follows = "flake-lib";
    };
    comfyui-workflow-templates-media-assets-01 = {
      url = "github:jgus/comfyui-workflow-templates-media-assets-01-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
      inputs.flake-lib.follows = "flake-lib";
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , flake-lib
    , comfyui-workflow-templates-core
    , comfyui-workflow-templates-json
    , comfyui-workflow-templates-media-api
    , comfyui-workflow-templates-media-video
    , comfyui-workflow-templates-media-image
    , comfyui-workflow-templates-media-other
    , comfyui-workflow-templates-media-assets-01
    }:
    flake-lib.lib.mkLeafFlake {
      inherit nixpkgs flake-utils;
      source = { type = "pypi"; pname = "comfyui_workflow_templates"; format = "sdist"; };
      package = {
        attr = "comfyui-workflow-templates";
        description = "ComfyUI workflow templates package";
        dependencies = ps:
          let
            inherit (ps.python.stdenv.hostPlatform) system;
          in
          [
            comfyui-workflow-templates-core.packages.${system}.comfyui-workflow-templates-core
            comfyui-workflow-templates-json.packages.${system}.comfyui-workflow-templates-json
            comfyui-workflow-templates-media-api.packages.${system}.comfyui-workflow-templates-media-api
            comfyui-workflow-templates-media-video.packages.${system}.comfyui-workflow-templates-media-video
            comfyui-workflow-templates-media-image.packages.${system}.comfyui-workflow-templates-media-image
            comfyui-workflow-templates-media-other.packages.${system}.comfyui-workflow-templates-media-other
            comfyui-workflow-templates-media-assets-01.packages.${system}.comfyui-workflow-templates-media-assets-01
          ];
        extra.pythonImportsCheck = [ "comfyui_workflow_templates" ];
      };
      pin = import ./pin.nix;
      siblings = map
        (reqName: {
          inherit reqName;
          pypiName = reqName;
          flakeRepo = "jgus/${reqName}-flake";
          mode = "exact";
        })
        [
          "comfyui-workflow-templates-core"
          "comfyui-workflow-templates-json"
          "comfyui-workflow-templates-media-api"
          "comfyui-workflow-templates-media-video"
          "comfyui-workflow-templates-media-image"
          "comfyui-workflow-templates-media-other"
          "comfyui-workflow-templates-media-assets-01"
        ];
      siblingRefsInPin = true;
    };
}
