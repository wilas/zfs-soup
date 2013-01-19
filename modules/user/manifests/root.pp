class user::root {

    define root_attune { 
        file { $name:
            ensure  => present,
            source  => "puppet:///modules/user${name}",
            owner   => "root",
            group   => "root",
            recurse => true,
        }
    }

    # ssh public key
    ssh_authorized_key { "root_key":
        key    => "AAAAB3NzaC1yc2EAAAABIwAAAQEAzklfofBRMF0doSKawOD0NQaq2z5VJUnsE3KNvEOln+l2BwHM2k2IdEXIfgR+BGUy+wz2wbDSiHVSEoqxX9tfnZSYxdI3IH8goNkkjdKy16r/cm/QEn5sSXgu0RowegTIKplFYU1CWNPlCViGXoUVatwEC2Byo9tz7/kMebQetAoeEMkRH0t/3pkgWqNHy8PDYUASp8PUnKUFcWhUyEokzfPxFllDBjdcMKpx6Iwk/iX/3LNmkXZvSQ6fbNj4a4oCKyx8BJBosUX/bopa0rhCZ6NGP0FHZsLZ9STO8fM5O921kMn7cDxe1MQwDTzvTl9ZJIfCzgZoySqHQ82JzR4nSQ==",
        type   => "ssh-rsa",
        user   => "root",
    }

    # ssh without password between hosts - priv. key
    file { "/root/.ssh/":
        ensure => directory,
        mode   => 0700,
        owner  => "root",
        group  => "root",
    }
    file { "/root/.ssh/id_rsa":
        ensure => file,
        mode   => 0600,
        owner  => "root",
        group  => "root",
        source => "puppet:///modules/user/root/.ssh/id_rsa.elk",
    }
    file { "/root/.ssh/known_hosts":
        ensure => file,
        mode   => 0644,
        owner  => "root",
        group  => "root",
        source => "puppet:///modules/user/root/.ssh/known_hosts",
    }

    root_attune { [ "/root/.vimrc", "/root/.bashrc", "/root/.vim", "/root/.tmux.conf", ]: }
}
