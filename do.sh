#!/bin/sh

# for those of us that dont' use python enough to remember the protocols

# check for virtualenv
if [ ! -d ".$(basename $(pwd))" ]; then
  virtualenv ".$(basename $(pwd))"
fi
# source the virtual environment
. ".$(basename $(pwd))/bin/activate"

# install deps
pip install -r requirements.txt

# build using nix package manager
sudo groupadd -r nixbld && \
for n in $(seq 1 10); do sudo useradd -c "Nix build user $n" \
    -d /var/empty -g nixbld -G nixbld -M -N -r -s "$(which nologin||echo '/usr/sbin/nologin')" \
    nixbld$n; done

[ "$(which nix-build)" ]|| \
bash <(curl https://nixos.org/nix/install)
#curl https://nixos.org/nix/install| sudo su 
nix-build

# unit test? 

# deactivate virtualenv
deactivate
