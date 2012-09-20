Overview
========

Module to manage network-related configs, currently supporting redhat-like systems


Install
-------

Install in `<module_path>/network`


Example usage
-------------

    node default {
        $node_hostname = 'devilbat'
        include network
        network::addhost {
            'puppet':
                line => 'puppet.fqdn.com:10.1.1.12';
        }
    }


Disclaimer
==========

This program is free software. It comes without any warranty, to
the extent permitted by applicable law. You can redistribute it
and/or modify it under the terms of the Do What The Fuck You Want
To Public License, Version 2, as published by Sam Hocevar. See
<http://sam.zoy.org/wtfpl/COPYING> for more details.

