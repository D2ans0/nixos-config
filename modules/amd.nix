{ config, pkgs, ... }:

{
  ## Boot ##
  # boot.initrd.kernelModules = [ "amdgpu" ]; # Load amdgpu driver before boot

  ## Enable AMD overclocking, should be in hardware-configuration.nix ##
  #boot.kernelModules = [ "amdgpu" ];

  ## Drivers ##
  hardware.amdgpu.initrd.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd # OpenCL
      libva # VA-API
      amf
    ];
  };

  ## Tools & Monitor ##
  environment.systemPackages = with pkgs; [
    ## Tools ##
    mesa-demos # OpenGL info
    vulkan-tools # Khronos official Vulkan Tools and Utilities
    clinfo # Print information about available OpenCL platforms and devices
    libva-utils # Collection of utilities and examples for VA-API
    ## Monitor ##
    lact # Linux GPU Configuration Tool for AMD and NVIDIA
    amdgpu_top # Tool to display AMDGPU usage
    nvtopPackages.amd # (h)top like task monitor for AMD, Adreno, Intel and NVIDIA GPUs
  ];

  ## LACT daemon ##
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];
}
