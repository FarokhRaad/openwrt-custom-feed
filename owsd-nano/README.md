# owsd-nano

**owsd-nano** is a minimal WebSocket RPC daemon for OpenWrt, designed to bridge modern browser dashboards or local applications with OpenWrt's native `ubus` IPC system using JSON-RPC over WebSockets.

- **No SSL, no dbus, no remote proxies**
- **Small size, minimal dependencies**
- **Designed for local, trusted environments**

## Features

- Accepts JSON-RPC calls over WebSockets (using [libwebsockets](https://libwebsockets.org/))
- Directly interfaces with OpenWrt's `ubus` for RPC calls and event subscriptions
- Simple access control via ubus session objects
- Basic HTTP file serving for local dashboards
- No support for SSL, dbus, or networked ubus proxying (see [owsd-tiny](https://gitlab.bau-ha.us/mt/owsd-tiny) for such features)

## Typical Use Case

Use `owsd-nano` to enable a web dashboard or SPA, hosted **locally on the router**, to perform `ubus` calls and receive `ubus` events using fast, lightweight WebSocket connections.

> If you simply want to replace HTTP POSTs with persistent, efficient WebSocket connections to `ubus` on OpenWrt, **this is the right tool**.

## Installation

### OpenWrt build system

1. Add the owsd-nano package feed to your `feeds.conf` or `feeds.conf.default`:
    ```
    src-git owsd-nano https://github.com/FarokhRaad/owsd-nano.git
    ```

2. Update and install feeds:
    ```sh
    ./scripts/feeds update owsd-nano
    ./scripts/feeds install owsd-nano
    ```

3. Enable the package in `.config`:
    ```
    CONFIG_PACKAGE_owsd-nano=y
    ```

4. Build:
    ```sh
    make package/owsd-nano/compile V=s
    ```

## Usage

- Start the daemon (typically via OpenWrt init system):

    ```
    /usr/bin/owsd-nano -p <port>
    ```

- Connect to it via WebSocket client, for example using [wscat](https://github.com/websockets/wscat):

    ```sh
    wscat -c ws://<router-ip>:<port> -s ubus-json
    ```

- Send JSON-RPC messages following the [uhttpd-mod-ubus JSON-RPC format](https://openwrt.org/docs/techref/ubus#access_to_ubus_over_http).

## Supported JSON-RPC Methods

- **list**: List available `ubus` objects and methods
- **call**: Invoke a method on a `ubus` object
- **subscribe**: Listen for broadcast events
- **subscribe-list**: See current subscriptions
- **unsubscribe**: Stop event listening

## Dependencies

- [libwebsockets](https://libwebsockets.org/) (>=3.x)
- [libubox](https://openwrt.org/docs/techref/libubox)
- [libubus](https://openwrt.org/docs/techref/ubus)
- [libjson-c](https://github.com/json-c/json-c)

## Security

- Intended for local network or router-only dashboards
- Does **not** support SSL/TLS or advanced authentication out of the box
- Access control is enforced only via ubus session ACLs

## Authors

Originally by Martin Tippmann, forked and minimalized by Farokh Panahirad.

