# Pikture

A simple image viewer

![screenshot](./assets/screenshot.png)

# Features

-   View Images!
-   File details in sidebar (width, height, file size, name and date modified)
-   Rotate clockwise and counter-clockwise
-   Save an image
-   Delete an image

# Local Development

## Building

```sh
meson setup build --prefix=/usr
ninja -C build
./build/pikture
```

### Build Flatpak

```
flatpak install flathub org.gnome.Platform//44
flatpak install flathub org.gnome.Sdk//44
flatpak-builder build com.github.mistakenelf.pikture.yml --user --install --force-clean
```

## Updating translations

```
ninja com.github.mistakenelf.pikture-update-po
```
