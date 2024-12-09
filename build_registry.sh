sudo mkdir -p /var/lib/registry
sudo chmod 755 /var/lib/registry


podman run -d --name registry -p 5000:5000 \
  -v /var/lib/registry:/var/lib/registry \
  --restart=always registry:2

mkdir -p ~/.config/systemd/user

mkdir -p ~/.config/containers/systemd
nano ~/.config/containers/systemd/container-registry.container

podman generate systemd --name registry > ~/.config/systemd/user/container-registry.service


[Unit]
Description=Podman container-registry.service
Documentation=man:podman-generate-systemd(1)
Wants=network-online.target
After=network-online.target
RequiresMountsFor=/run/user/1000/containers

[Service]
Environment=PODMAN_SYSTEMD_UNIT=%n
Restart=on-failure
RestartSec=30
TimeoutStartSec=300
TimeoutStopSec=70
Type=simple
ExecStartPre=-/nix/store/gx9xv5wwm9r9wbrxihs2l3yr2pibra25-podman-5.3.0/bin/.podman-wrapped rm -f registry
ExecStart=/nix/store/gx9xv5wwm9r9wbrxihs2l3yr2pibra25-podman-5.3.0/bin/.podman-wrapped run --name registry \
    -p 5000:5000 \
    -v /var/lib/registry:/var/lib/registry \
    registry:2
ExecStop=/nix/store/gx9xv5wwm9r9wbrxihs2l3yr2pibra25-podman-5.3.0/bin/.podman-wrapped stop -t 10 registry

[Install]
WantedBy=default.target

systemctl --user daemon-reload
systemctl --user reset-failed container-registry
systemctl --user restart container-registry

systemctl --user status container-registry.service


//use Lan registry

sudo nano /etc/containers/registries.conf.d/myregistry.conf

[[registry]]
location = "10.0.0.175:5000"
insecure = true

sudo apt-get install -y uidmap

sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $(whoami)

grep $(whoami) /etc/subuid
grep $(whoami) /etc/subgid



podman tag docker.io/library/alpine:latest 10.0.0.175:5000/alpine:latest

podman push 10.0.0.93:5000/alpine

sudo ufw allow 5000/tcp
systemctl status firewalld.service

curl http://10.0.0.93:5000/v2/_catalog


//fix
systemctl --user stop container-registry

sudo chown -R $USER:$USER /var/lib/registry
sudo chmod -R 755 /var/lib/registry

systemctl --user start container-registry

sudo nano /etc/containers/registries.conf
[[registry]]
location = "10.0.0.175:5000"
insecure = true


curl http://10.0.0.175:5000/v2/_catalog
{"repositories":["alpine"]}

//use admin container

podman  run -d   -p 9000:9000   -v /var/run/docker.sock:/var/run/docker.sock   docker.io/portainer/portainer