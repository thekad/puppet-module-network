# -*- mode: puppet; sh-basic-offset: 4; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: tabstop=4 softtabstop=4 expandtab shiftwidth=4 fileencoding=utf-8

define network::addhost($line='') {

    $hostline = $line ? {
        ''      => $name,
        default => $line
    }

    host {
        "${name}":
            name         => inline_template('<%= hostline.split(":")[0].split(".")[0] -%>'),
            ip           => inline_template('<%= hostline.split(":")[1] -%>'),
            host_aliases => inline_template('<%= hostline.split(":")[0] -%>'),
            ensure       => present;
    }
}

