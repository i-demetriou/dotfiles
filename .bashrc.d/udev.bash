# I can never remember the commands
# This could have been a README

# Common udev rules failures:
# - Make sure that your rules permissions are correct! (644, root:root)
# - Commands need to be absolute path referenced, e.g. /usr/bin/echo rather echo
# - RUN+= commands must not end with a \
# - Be careful of expansions in RUN+= blocks!

# TIPS:
# - Don't forget to run `udev_reload`
# - In RUN+=, to escape a '$' use '$$'. e.g RUN+="/usr/bin/echo 'I want $$10' > /tmp/santa-letter"
# - Consider ending your rule with:
#     , RUN+="/usr/bin/logger --tag my-rule Device mounted on %k"
#   so that the udev_logs command will pick it up (or journalctl --tag my-rule)

udev_monitor() {
    sudo udevadm monitor --udev --property
}

udev_about() {
    local device=$1

    udevadm info -a -p $(udevadm info -q path $device)
}

udev_trigger_remove_add() {
    local device=$1

    sudo udevadm trigger --subsystem-match=tty --action=remove --name-match=$device
    sudo udevadm trigger --subsystem-match=tty --action=add --name-match=$device
}

udev_logs() {
    journalctl --catalog --pager-end --follow --unit systemd-udevd.service
}

udev_reload() {
    sudo udevadm control --reload-rules
}
