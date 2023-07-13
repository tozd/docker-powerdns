# tozd/powerdns

<https://gitlab.com/tozd/docker/powerdns>

Available as:

- [`tozd/powerdns`](https://hub.docker.com/r/tozd/powerdns)
- [`registry.gitlab.com/tozd/docker/powerdns`](https://gitlab.com/tozd/docker/powerdns/container_registry)

## Image inheritance

[`tozd/base`](https://gitlab.com/tozd/docker/base) ← [`tozd/dinit`](https://gitlab.com/tozd/docker/dinit) ← `tozd/powerdns`

## Tags

- `ubuntu-trusty`: powerdns-server 3.3
- `ubuntu-xenial`: powerdns-server 4.0.0-alpha2
- `ubuntu-bionic`: powerdns-server 4.1.1
- `ubuntu-focal`: powerdns-server 4.2.1
- `ubuntu-jammy`: powerdns-server 4.5.3

## Volumes

- `/var/log/powerdns`: Log files when `LOG_TO_STDOUT` is not set to `1`.
- `/etc/powerdns/pdns.d`: Volume with configuration files.

## Variables

- `LOG_TO_STDOUT`: If set to `1` output logs to stdout (retrievable using `docker logs`) instead of log volumes.

## Ports

- `53/udp`: DNS port on which PowerDNS listens.
- `53/tcp`: DNS port on which PowerDNS listens.

## Description

Image providing [PowerDNS](https://www.powerdns.com/) DNS server.

When `LOG_TO_STDOUT` is set to `1`, Docker image logs output to stdout and stderr. All stdout output is JSON.

You configure it by mounting a volume into `/etc/powerdns/pdns.d` with files to configure PowerDNS. For example,
a simple `pdns.conf` file could look like:

```
# Disable recursion.
allow-recursion=

# We use dinit to assure the process is running.
guardian=no
daemon=no

# DNS master & slave.
master=yes
slave=no

# Allow AXFR.
disable-axfr=no
# Allow slave.
allow-axfr-ips=123.123.123.123/32

# To be anonymous.
version-string=anonymous
```

Enable Bind backend with `pdns.simplebind.conf`:

```
launch=bind
bind-config=/etc/powerdns/bindbackend.conf
bind-check-interval=3600
```

And your `/etc/powerdns/bindbackend.conf` could look like:

```
zone "example.com" {
  type master;
  file "/etc/powerdns/bind/example.com";
};
```

This example mounts an additional `/etc/powerdns/bindbackend.conf` file and additional directory `/etc/powerdns/bind`.

Of course you can also just extend this Docker image and add those files and directories there.

## GitHub mirror

There is also a [read-only GitHub mirror available](https://github.com/tozd/docker-powerdns),
if you need to fork the project there.
