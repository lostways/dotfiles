# Docker Engine from Docker's apt repo (Ubuntu or Debian)
# https://docs.docker.com/engine/install/ubuntu/
. /etc/os-release
if [[ $ID != ubuntu && $ID != debian ]]; then
  log "ERROR: docker.sh supports Ubuntu and Debian, not $ID"
  exit 1
fi

# Distro packages that conflict with Docker's own
conflicts=$(dpkg-query -W -f '${Package} ${db:Status-Abbrev}\n' docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc 2>/dev/null | awk '$2 == "ii" {print $1}')
if [[ -n $conflicts ]]; then
  log "Removing conflicting packages: $conflicts"
  sudo apt-get remove -y $conflicts
fi

log "Adding Docker's apt repository..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL "https://download.docker.com/linux/$ID/gpg" -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/$ID
Suites: $VERSION_CODENAME
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
# the old one-line format this script used to write
sudo rm -f /etc/apt/sources.list.d/docker.list /etc/apt/keyrings/docker.gpg
sudo apt-get update

log "Installing Docker Engine..."
sudo apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin

# The package creates the docker group and starts the service
if ! id -nG "$USER" | grep -qw docker; then
  log "Adding $USER to the docker group (log out and back in to use docker without sudo)"
  sudo usermod -aG docker "$USER"
fi

log "Verifying installation..."
sudo docker run --rm hello-world
