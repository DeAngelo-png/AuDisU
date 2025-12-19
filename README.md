# (Au)to (Dis)cord (U)pdater
###### Yes, I am horrible at naming stuff

**audisu** is a convenient tool that automatically downloads and installs the latest version of Discord for Linux. It detects your distribution and uses the appropriate package format automatically. No need to manually `dpkg`.

## Installation

```bash
curl -fsSL https://github.com/DeAngelo-png/AuDisU/raw/refs/heads/main/init.sh | sudo bash
```

After installation, you can update Discord anytime easily by running `audisu`.

## Usage

```bash
audisu
```

## Dependencies
* `wget` (for downloading)
* `tar` (for tarball extraction)

These are usually preinstalled on most distributions.

## Notes
* The initial setup **must be run as root** to install to `/bin`
* Regular updates run will prompt to run with root to finish installation
* Downloaded packages are in the `/tmp`
* Creates a symlink in `/usr/bin/discord` for tarball installations

## Contributing
Pull requests are welcome! If you find any issues or have suggestions for improvements submit a pull request with any way of optimizing this in the future.
