# os-keyrad — OPNsense plugin for keyrad

An OPNsense MVC plugin that provides a web GUI for [keyrad](https://github.com/gpappsoft/keyrad),
a Go-based RADIUS server that authenticates users against Keycloak (password + OTP/TOTP).

The GUI lives under **Services → keyrad RADIUS** and manages everything that the
`keyrad.yaml` and `clients.conf` files express, plus service control.

## Features

- **General settings** — Keycloak token/admin-API URL, realm, client id/secret,
  TLS verification, RADIUS listen address/port, OTP challenge message and the
  authentication toggles (PAP, challenge-response, Message-Authenticator, debug).
- **Clients** grid — FreeRADIUS-style RADIUS clients (host or CIDR) with shared secrets.
- **Attribute mappings** grid — map Keycloak roles/groups/scopes to standard or
  Vendor-Specific RADIUS attributes, including `re:` regex scope keys.
- **Service control** — start/stop/restart/status plus an *Apply* button that
  regenerates the config and reloads the daemon.

The plugin renders these files from `config.xml` via the OPNsense template engine:

| Generated file              | Purpose                                  |
|-----------------------------|------------------------------------------|
| `/usr/local/etc/keyrad/keyrad.yaml`  | keyrad main configuration       |
| `/usr/local/etc/keyrad/clients.conf` | RADIUS client definitions       |
| `/etc/rc.conf.d/keyrad`              | CLI flags for the rc.d service  |

## Requirements

This plugin is the **GUI only**. The keyrad daemon binary must be installed at
`/usr/local/bin/keyrad`. Build it for FreeBSD/OPNsense (see the keyrad README):

```sh
# cross-compile from Linux/macOS, then copy to the firewall
GOOS=freebsd GOARCH=amd64 go build -o keyrad-freebsd-amd64 main.go
scp keyrad-freebsd-amd64 root@opnsense:/usr/local/bin/keyrad
ssh root@opnsense chmod +x /usr/local/bin/keyrad
```

## Building / installing the plugin

OPNsense plugins build inside the OPNsense ports/plugins tree.

1. Clone the OPNsense plugins repository on a FreeBSD build host:
   ```sh
   git clone https://github.com/opnsense/plugins
   ```
2. Drop this directory in under a category, e.g. `security/keyrad`
   (the directory containing this `Makefile`).
3. Build and install the package:
   ```sh
   cd plugins/security/keyrad
   make package
   pkg add work/pkg/os-keyrad-*.pkg
   ```

For quick iteration on a running OPNsense box you can instead copy the contents
of `src/` straight onto the firewall (mirrors `/usr/local`) and refresh the
caches:

```sh
rsync -a src/ root@opnsense:/usr/local/
ssh root@opnsense /usr/local/etc/rc.d/configd restart
ssh root@opnsense 'service configd restart; /usr/local/sbin/pluginctl -c'   # rebuild MVC/template cache
```

Then open **Services → keyrad RADIUS**, fill in the Keycloak settings, add a
client, tick *Enable keyrad* and press **Apply**.

## Layout

```
Makefile, pkg-descr                         plugin packaging
src/etc/inc/plugins.inc.d/keyrad.inc        service + syslog registration
src/etc/rc.d/keyrad                         FreeBSD rc.d service script
src/opnsense/mvc/app/
  models/OPNsense/Keyrad/Keyrad.xml         config model (general/clients/mappings)
  controllers/OPNsense/Keyrad/              Index + Api (Settings/Clients/Mappings/Service)
  views/OPNsense/Keyrad/index.volt          the page (tabs + grids + apply)
src/opnsense/service/
  conf/actions.d/actions_keyrad.conf        configd start/stop/restart/status
  templates/OPNsense/Keyrad/                keyrad.yaml / clients.conf / rc.conf.d templates
```

## License

Apache-2.0, matching the keyrad project.
# os-keyrad
