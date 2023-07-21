# linux-desktop-ansible
1. Copy `default.config.yml` to `config.yml` and customize variables
2. Add secrets to `vault.yml`
3. `make deps` to install playbook dependencies
4. `make vault` to encrypt `vault.yml`
5. `make install` to run playbook

## Get PCI IDs for config.yml
```
sudo apt install --no-install-recommends -y pciutils
```

```
lspci -nn
```

## Compositors and vSync
[Great video discussing compositors, vsync, and screen tearing.](https://www.youtube.com/watch?v=3esPpe-fclI)


Basically if you do not care that much about latency (i.e. not using your system for FPS gaming) you should enable vsync on your GPU drivers and use a compositor ([Picom](https://wiki.archlinux.org/title/picom)) without vsync for the best tear free experience.


For Nvidia on X11 you can enable vsync by adding `{ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}` to each display in your `xorg.conf`:
```
Section "Screen"
    Identifier     "Screen0"
    Device         "Device0"
    Monitor        "Monitor0"
    DefaultDepth    24
    Option         "Stereo" "0"
    Option         "nvidiaXineramaInfoOrder" "DFP-2"
    Option         "metamodes" "DP-1: 1920x1080_60 +0+180 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-7: 1920x1080_60 +4480+180 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}, DP-2: 2560x1440_100 +1920+0 {ForceCompositionPipeline=On, ForceFullCompositionPipeline=On}"
    Option         "SLI" "Off"
    Option         "MultiGPU" "Off"
    Option         "BaseMosaic" "off"
    SubSection     "Display"
        Depth       24
    EndSubSection
EndSection
```


The nice part about using GPU driver vsync is that you can use multiple monitors with different refresh rates and still not experience tearing. If just try to do this with only a compositor you will probably still have tearing issues and you will experience lag when running GPU two accelerated applications on two different monitors with two different refresh rates. For example your YouTube video will stutter when scrolling through Discord.
