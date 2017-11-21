# armactl

A tool for managing an ArmA 3 dedicated server on Linux.

## Requirements

* Any common Linux distribution
* Ruby >= 2.4
* [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD)
* 32-bit version of the GNU Standard C++ library (e.g. the `lib32stdc++6` package for Debian and Ubuntu)
* Steam account that owns ArmA 3

## Usage

```sh
ARMACTL_ROOT="$HOME/arma3"

armactl init "$ARMACTL_ROOT"
cd "$ARMACTL_ROOT"

vim config.yml

armactl install-server
armactl sync-workshop-content
armactl start <server name>
```

## License

MIT
