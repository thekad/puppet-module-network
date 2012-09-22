# -*- mode: puppet; sh-basic-offset: 4; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: tabstop=4 softtabstop=4 expandtab shiftwidth=4 fileencoding=utf-8

class network {

    $longname = $node_hostname ? {
        ''      => 'localhost.localdomain',
        default => $node_hostname
    }

    $shortname = $node_hostname ? {
        ''      => 'localhost',
        default => inline_template('<%= node_hostname.split(".")[0] -%>')
    }

    $aliases = $node_hostname ? {
        ''      => [ $shortname ],
        default => [ $shortname, 'localhost', 'localhost.localdomain' ]
    }

    host {
        "${longname}":
            ip           => '127.0.0.1',
            host_aliases => $aliases,
            ensure       => present;
        'localhost6':
            ip           => '::1',
            ensure       => absent;
        'localhost6.localdomain6':
            ip           => '::1',
            ensure       => absent;
        'localhost':
            ip     => '127.0.0.1',
            ensure => absent;
    }

    if $node_hostname {
        host {
            'localhost.localdomain':
                ip     => '127.0.0.1',
                ensure => absent
        }
    }

    service {
        'network':
            enable => true;
    }

    file {
        '/etc/sysconfig/network':
            ensure  => present,
            content => template('network/sysconfig.erb'),
            notify  => Service['network'];
    }

    exec {
        'set-hostname':
            command => "hostname ${longname}",
            unless  => "[ `hostname -f` == ${longname} ]";
    }

    if $node_hostnames {
        network::addhost {
            $node_hostnames:
        }
    }
}

