meet.vpsfree.cz
===============
Jitsi Meet on vpsFree NixOS containers, managed by [confctl](https://github.com/vpsfreecz/confctl) (`cd meet && nix-shell`).

- `environments/meet.nix` - master (prosody, jicofo, nginx), parametrized by domain
- `environments/jvb.nix` - videobridge, parametrized by master domain
- `environments/base.nix` - shared container base

Testing a new setup
-------------------
`jvb10` and `jvb11` share their containers with the test cluster:

| container     | production | test         |
|---------------|------------|--------------|
| 37.205.13.90  | jvb11      | test-meet    |
| 37.205.14.250 | jvb10      | test-jvb01   |

1. `confctl deploy --reboot -t test-meet '*' boot`, verify https://test-meet.vpsfree.cz
2. `confctl deploy --reboot -t meet-nixos '*' boot` (master + jvb1..11, jvb10/11 go back to production)

Never deploy all machines at once, the pairs above would overwrite each other.

Use `boot` + `--reboot` when the systemd version changes: a live `switch` re-executes
PID1 and on cgroup v1 nodes the container hung (systemd 257 -> 262, Nov 2026).

DNS
---
    auth.meet.vpsfree.cz       CNAME  meet.vpsfree.cz        # ACME SAN, prosody XMPP cert for jvb
    auth.test-meet.vpsfree.cz  CNAME  test-meet.vpsfree.cz
    turn.meet.vpsfree.cz       CNAME  jvb1.vpsfree.cz        # TURN (not deployed yet)
    turn.test-meet.vpsfree.cz  CNAME  test-jvb01.vpsfree.cz

TURN
----
coturn on jvb1 (`turn.meet.vpsfree.cz`) and test-jvb01 (`turn.test-meet.vpsfree.cz`), TURNS on 443/tcp,
TURN on 3478. Prosody hands out credentials (`external_services`). The shared secret is not in the repo:
`/secrets/turn/secret` on the master and the TURN host, root 0600, **no trailing newline**
(`openssl rand -hex 32 | tr -d '\n' > /secrets/turn/secret`). The relay only reaches the bridges.
