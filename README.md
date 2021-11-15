# bsp-imx8mp-zeus

## Download the sources

```bash
git clone https://github.com/shalex88/bsp-imx8m bsp-imx8mp-zeus -b bsp-imx8mp-zeus
```

## Build docker container (internet connection needed)

```bash
./start.sh -b
```

## Get yocto sources (internet connection needed)

```bash
./start.sh
./clone_yocto.sh
```

## Prepare build environment

```bash
cd var-fsl-yocto
MACHINE=imx8mp-var-dart DISTRO=fsl-imx-xwayland . var-setup-release.sh
```

```bash
# Set build settings
cd conf
ln -sf ../../../site.conf site.conf
```

## Fetch all sources (internet connection needed)

```bash
bitbake fsl-image-qt5 --runonly=fetch -k
bitbake imx-boot --runonly=fetch -k
bitbake meta-toolchain --runonly=fetch -k
```

## Build the image

```bash
# Append MemoryLimit=8G to limit the memory usage
bitbake fsl-image-qt5
```
