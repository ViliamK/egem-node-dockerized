# egem-node-dockerized
EtherGem node daemon container for EtherGem Network


This method uses a [bind mount](https://docs.docker.com/storage/bind-mounts) to persist the blockchain data on the host.

To simplify things, basic operations have been added as `Makefile` commands.

## To build:
```
make image
```

## To run the node / daemon (non-interactive):
```
make node
```

## To access the running node interactively with the geth console:
```
make attach
```

## To run as a systemd service:
Assuming you have created a user `egemnode` in group `egemnode` and have cloned this repository in the `egemnode` home user directory,
the following service file will start the daemon automatically at system startup.

Enter the following into `/etc/systemd/system/egemnode.service`:
```
[Unit]
Description=EtherGem node daemon service
After=network.target

[Service]
User=egemnode
Group=egemnode
Type=simple
Restart=always
RestartSec=30s
WorkingDirectory=/home/egemnode/egem-node-dockerized
ExecStart=/usr/bin/make node

[Install]
WantedBy=default.target
```

After creating the service file, enable and restart the service:
```
systemctl enable egemnode
systemctl restart egemnode
```

NOTE: You must make sure the service is running if you use interactive mode for the geth console.

To stop the service:
```
systemctl stop egemnode
```

To restart the service:
```
systemctl restart egemnode
```

<hr>

#### Donations accepted:
`0xbACA64fe2f0783f49727f9809Bc7fA96955507Cb` (EGEM)

