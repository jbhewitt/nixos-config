{ lib, config, ... }:
{
  imports = [
    ../common/cpu/amd
    ../common/gpu/amd
    ../common/gpu/nvidia/prime.nix
    ../common/gpu/nvidia/ada-lovelace
    ../common/hidpi.nix
    ../common/pc/laptop
    ../common/pc/laptop/ssd
  ];

  hardware.nvidia.prime = {
		amdgpuBusId = "PCI:01:00:0";
		nvidiaBusId = "PCI:06:00:0";  
	};

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      # This is the latest driver with the CVE patches + explicit sync
      version = "555.52.04";
      sha256_64bit = "sha256-nVOubb7zKulXhux9AruUTVBQwccFFuYGWrU1ZiakRAI=";
      sha256_aarch64 = "sha256-Kt60kTTO3mli66De2d1CAoE3wr0yUbBe7eqCIrYHcWk=";
      openSha256 = "sha256-wDimW8/rJlmwr1zQz8+b1uvxxxbOf3Bpk060lfLKuy0=";
      settingsSha256 = "sha256-PMh5efbSEq7iqEMBr2+VGQYkBG73TGUh6FuDHZhmwHk=";
      persistencedSha256 = "sha256-KAYIvPjUVilQQcD04h163MHmKcQrn2a8oaXujL2Bxro=";
    };
  };

  services.thermald.enable = lib.mkDefault true;

  # √(3840² + 2160²) px / 15.60 in ≃ 282 dpi
#  services.xserver.dpi = 282;
}
