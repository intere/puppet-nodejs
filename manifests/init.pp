
class nodejs {
	
	exec {
		"get_nodejs" :
			cwd => '/tmp',
			command => '/usr/bin/wget http://nodejs.org/dist/v0.10.5/node-v0.10.5-linux-x64.tar.gz',
			creates => '/tmp/node-v0.10.5-linux-x64.tar.gz';

		"unpack_node-js" :
			cwd => '/opt',
			command => '/bin/tar -xzf /tmp/node-v0.10.5-linux-x64.tar.gz',
			creates => '/opt/node-v0.10.5-linux-x64',
			require => Exec['get_nodejs'];
	}

	notify { 'installed' :
		message => "node.js has been installed to /opt/node-v0.10.5-linux-x64",
		require => Exec['unpack_node-js']
	}
}
