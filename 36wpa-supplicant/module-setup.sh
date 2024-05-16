#!/bin/bash

# 2024, D. Debnath
# SPDX-License-Identifier: GPL-3.0-or-later

# called by dracut
check() {
    require_binaries wpa_supplicant || return 1
    # 0 enables by default, 255 only on request
    return 0
}

# called by dracut
depends() {
    echo dbus bash net-lib
    return 0
}

# called by dracut
install() {
    inst wpa_supplicant

    inst "$moddir"/wpa_supplicant.service "$systemdsystemunitdir"/wpa_supplicant.service
    inst /usr/share/dbus-1/system-services/fi.w1.wpa_supplicant1.service
    inst /usr/share/dbus-1/system.d/wpa_supplicant.conf

    $SYSTEMCTL -q --root "$initdir" enable wpa_supplicant.service
}
