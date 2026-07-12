# linuwu-sense (runit state persistence)

## Install

```sh
cd linuwu-sense
doas ./install.sh
```

## Log service (required — prevents service output from blocking the TTY/login prompt)

```sh
doas mkdir -p /etc/sv/linuwu-sense-restore/log
doas mkdir -p /var/log/linuwu-sense-restore

doas sh -c 'cat > /etc/sv/linuwu-sense-restore/log/run << "EOF"
#!/bin/sh
exec svlogd -tt /var/log/linuwu-sense-restore
EOF'

doas chmod +x /etc/sv/linuwu-sense-restore/log/run

doas sv down linuwu-sense-restore
doas sv up linuwu-sense-restore
doas sv status linuwu-sense-restore
```

## Manual use

```sh
doas restore-sense
doas save-sense
doas sv status linuwu-sense-restore
```

## View logs

```sh
doas tail -f /var/log/linuwu-sense-restore/current
```

## Re-deploy after editing files in this repo

```sh
doas ./install.sh
```
