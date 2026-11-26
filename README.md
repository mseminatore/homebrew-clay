# homebrew-clay

Homebrew tap for [Clay](https://github.com/mseminatore/clay) (macOS and Linux,
arm64 and x86_64).

```sh
brew install mseminatore/clay/clay
# or: brew tap mseminatore/clay && brew install clay
```

The formula installs the prebuilt release archives. `clay --compile` needs a C
compiler (`cc`): the Xcode Command Line Tools on macOS, gcc or clang on Linux.
The Linux build links the system's OpenSSL 3 (`libssl.so.3`; Ubuntu 22.04+,
Debian 12+, Fedora 36+).

## Updating

Clay's `.github/workflows/homebrew.yml` runs `bin/bump` and pushes here when a
release is published. By hand:

```sh
gh release download v0.3.14 -R mseminatore/clay -p SHA256SUMS
bin/bump 0.3.14 SHA256SUMS && rm SHA256SUMS
brew audit --strict --online mseminatore/clay/clay
```
