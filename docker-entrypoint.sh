#!/bin/sh
set -e

# Start SSH daemon if OPENSSH_ENABLED (default: true when SSH_ROOT_PASSWORD is set)
if [ -n "${SSH_ROOT_PASSWORD}" ] || [ "${OPENSSH_ENABLED:-1}" = "1" ]; then
    mkdir -p /run/sshd
    if [ -n "${SSH_ROOT_PASSWORD}" ]; then
        echo "root:${SSH_ROOT_PASSWORD}" | chpasswd
    fi
    # Permit root login (password or without-password)
    sed -i 's/#*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config 2>/dev/null || true
    /usr/sbin/sshd
fi

exec nanobot gateway --port "${NANOBOT_PORT:-18789}"
