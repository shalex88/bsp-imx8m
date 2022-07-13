# bsp-imx8mp-zeus

## Download the sources

```bash
git clone https://github.com/shalex88/bsp-imx8m bsp-imx8mp-hardknott -b bsp-imx8mp-hardknott
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
MACHINE=imx8mp-var-dart DISTRO=fslc-xwayland . var-setup-release.sh build
```

```bash
# Set build settings
cd conf
ln -sf ../../../site.conf site.conf
```

```bash
# Add hailo support
cd conf
# TODO: fix for hardknott
tac bblayers.conf | awk '! non_empty && ! /^$/ &&  {non_empty = 1} non_empty {skip++} skip > 1 {print}' | tac
echo -E '
\
${BSPDIR}/sources/meta-hailo/meta-hailo-accelerator \
${BSPDIR}/sources/meta-hailo/meta-hailo-libhailort \
${BSPDIR}/sources/meta-hailo/meta-hailo-offlinebuild \
${BSPDIR}/sources/meta-hailo/meta-hailo-tappas \
"
' >> bblayers.conf
```

## Fetch all sources (internet connection needed)

```bash
bitbake fsl-image-qt5 --runonly=fetch -k
bitbake imx-boot --runonly=fetch -k
```

## Build the SDK (internet connection needed)

```bash
# Append MemoryLimit=8G to limit the memory usage
bitbake fsl-image-qt5 -c populate_sdk
```

## Build the image

```bash
# Append MemoryLimit=8G to limit the memory usage
bitbake fsl-image-qt5
```
