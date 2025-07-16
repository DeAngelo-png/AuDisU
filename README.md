# (Au)to (Dis)cord (U)pdater
###### Yes, I am horrible at naming stuff

**audisu** is a convenient command-line tool that automatically downloads and installs the latest version of Discord for Linux. It detects your distribution and uses the appropriate package format, making updates quick and hassle-free. No need to manually download packages or manage dependencies!

## Installation

```bash
curl -fsSL https://github.com/DeAngelo-png/AuDisU/raw/refs/heads/main/init.sh | sudo bash
```

After installation, you can update Discord anytime easily by running `audisu`.

## Usage

Simply run:
```bash
audisu
```

The script will:
1. Detect your Linux distribution
2. Download the latest Discord package
3. Install it using the appropriate method
4. Display a completion banner

## Dependencies
* `wget` (for downloading)
* `tar` (for tarball extraction)

These are usually pre-installed on most distributions.

## Notes
* The initial setup **must be run as root** to install to `/bin`
* Regular updates run without root privileges
* Downloaded packages are automatically deleted after installation
* Creates a symlink in `/usr/bin/discord` for tarball installations

## Contributing
Pull requests are welcome! If you find any issues or have suggestions for improvements submit a pull request with any way of optimizing this in the future.
