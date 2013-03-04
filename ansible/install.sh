#!/bin/bash

# Installs the dependencies requiered for Ansible
# as shown in: http://ansible.cc/docs/gettingstarted.html#requirements
pip install paramiko PyYAML jinja2

APPS_DIR="$HOME/.apps"
ANSIBLE_DIR="$APPS_DIR/ansible"
CONFIG_DIR="$APPS_DIR/etc"
ANSIBLE_CONFIG_DIR="$CONFIG_DIR/ansible"

# Get Ansible from github and install it in the currents user home .apps
if [ ! -d "$APPS_DIR" ]; then
    mkdir "$APPS_DIR"
fi

cd "$APPS_DIR"
git clone git://github.com/ansible/ansible.git

# Installs configs to .apps/etc
if [ ! -d "$CONFIG_DIR" ]; then
    mkdir "$CONFIG_DIR"
fi

if [ ! -d "$ANSIBLE_CONFIG_DIR" ]; then
    mkdir "$ANSIBLE_CONFIG_DIR"
fi

# Creates an empty hosts file for Ansible
if [ ! -f "$ANSIBLE_CONFIG_DIR/hosts" ]; then
    echo "" > "$ANSIBLE_CONFIG_DIR/hosts"
fi

echo "Add your servers to $ANSIBLE_CONFIG_DIR/hosts"

# Patchs hacking/env-setup to add support for zsh
ANSIBLE_ENV_FILE="$ANSIBLE_DIR/hacking/env-setup"
sed -i '' 's_$PWD_'"$ANSIBLE_DIR"'_' $ANSIBLE_ENV_FILE

# Creates a new env.sh to be sourced when starting the console
if [ ! -f "$ANSIBLE_CONFIG_DIR/env.sh" ]; then
    echo "source $ANSIBLE_ENV_FILE -q" > "$ANSIBLE_CONFIG_DIR/env.sh"
    echo "export ANSIBLE_HOSTS=$ANSIBLE_CONFIG_DIR/hosts" >> "$ANSIBLE_CONFIG_DIR/env.sh"
fi

echo "Include $ANSIBLE_CONFIG_DIR/env.sh to be loaded"