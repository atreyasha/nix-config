# nix-config

This repository documents my personal NixOS configuration.

## Hosts :heart:

| Machine | Specification                           |
|:--------|:----------------------------------------|
| `monix` | Lenovo Yoga Slim 6, Intel Core i7-1260P |
| `becks` | Development VMWare guest for `monix`    |

Configuration includes support for:

- [`alacritty`](https://github.com/alacritty/alacritty)
- [`i3-gaps`](https://github.com/Airblader/i3) + [`i3lock-fancy-rapid`](https://github.com/yvbbrjdr/i3lock-fancy-rapid)
- [`picom`](https://github.com/yshui/picom/)
- [`qutebrowser`](https://github.com/qutebrowser/qutebrowser/issues/700)
- [`ranger`](https://github.com/ranger/ranger)
- [`rofi`](https://github.com/davatorium/rofi)
- [`spacemacs`](https://github.com/syl20bnr/spacemacs)
- [`vim`](https://wiki.archlinux.org/title/Vim)
- [`zathura`](https://github.com/pwmt/zathura)
- [`zsh`](https://wiki.archlinux.org/title/Zsh)

## Installation :books:

### Partitioning & formatting

Follow the [NixOS Manual](https://nixos.org/manual/nixos/stable/#sec-installation-manual-summary) to encrypt, partition and format your filesystem. Return to this readme after mounting partitions in the target filesystem (i.e. `/mnt/*`).

### Flakes

1. Clone this repository in the target filesystem:

    ```
    # git clone https://github.com/atreyasha/nix-config.git /mnt/etc/nix-config
    ```

2. **[Optional]** If installing on new hardware, update hardware configuration (eg. partition UUIDs, LUKS devices) in `hosts/<host>/hardware.nix` and commit these changes later. Run the following to inspect detected hardware configuration:

    ```
    # nixos-generate-config --show-hardware-config
    ```

3. Install this configuration, which implicitly utilizes [Nix Flakes](https://nixos.wiki/wiki/Flakes):

    ```
    # nixos-install --flake /mnt/etc/nix-config#<host>
    ```

4. Update the `root` and default user's password.

## Maintenance :construction_worker:

After installing NixOS, make changes to this repository as required. To sync changes on the system, execute the following as the default user:

```
$ pull-and-switch
```

## Development :fire:

Install [`nixfmt`](https://github.com/NixOS/nixfmt) in your system. Initialize `pre-commit` hook for automatic formatting checks of Nix files:

```
$ pre-commit install
```

## Credits :stars:

- [`nix-starter-configs`](https://github.com/Misterio77/nix-starter-configs) for a great starting point to NixOS
- [`nixfiles`](https://cyberchaos.dev/leona/nixfiles) for an example of complex multi-host configuration
