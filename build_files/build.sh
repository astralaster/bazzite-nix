#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Nix

# The Nix installer needs a real top-level /nix to bind-mount the persistent
# store onto. On composefs the root is read-only, so /nix cannot be created at
# runtime; baking it into the image puts it in every deployment. The installer
# then skips its nix-directory.service (ConditionPathExists=!/nix) and only
# adds nix.mount, which binds /var/home/nix onto /nix.
mkdir -p /nix

### Packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1
#
# dnf5 install -y <package>

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging
