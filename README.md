# mis-imagenes-ublue &nbsp; [![bluebuild build badge](https://github.com/benderskyariel/mis-imagenes-ublue/actions/workflows/build.yml/badge.svg)](https://github.com/benderskyariel/mis-imagenes-ublue/actions/workflows/build.yml)

Custom [uBlue](https://universal-blue.org/) / [BlueBuild](https://blue-build.org) Fedora Atomic images, built nightly and signed with cosign.

## Images

| Recipe | Base image | Description |
| --- | --- | --- |
| `silverblue-st` | `ghcr.io/ublue-os/silverblue-main` | Imagen base para off con Keybase, Syncthing y Tailscale |
| `silverblue-nvidia-kst` | `ghcr.io/ublue-os/silverblue-nvidia` | Imagen base para Oro con Keybase, Syncthing y Tailscale |
| `silverblue-nvidia-asus-kst` | `ghcr.io/ublue-os/silverblue-nvidia` | Imagen para Plata con software de Asus, Keybase, Syncthing y Tailscale |

Each is published to `ghcr.io/benderskyariel/<recipe-name>`, e.g. `ghcr.io/benderskyariel/silverblue-st`.

## Installation

> [!WARNING]
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to one of these images, substitute `<image>` below with the recipe name from the table above (e.g. `silverblue-nvidia-kst`):

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/benderskyariel/<image>:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/benderskyariel/<image>:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version pinned in the recipe's `image-version`, so a reboot won't silently jump you to the next major Fedora release.

## ISO

If build on Fedora Atomic, you can generate an offline ISO with the instructions available [here](https://blue-build.org/how-to/generate-iso/#_top). These ISOs cannot unfortunately be distributed on GitHub for free due to large sizes, so for public projects something else has to be used for hosting.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command (substitute `<image>` as above):

```bash
cosign verify --key cosign.pub ghcr.io/benderskyariel/<image>
```
