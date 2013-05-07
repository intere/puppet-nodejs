
#
# Valid Versions: 
#    0.10.0
#    0.10.5
#
class nodejs::params($version='0.10.0') {

	$pkg_url = "http://nodejs.org/dist/v$version/node-v$version-linux-x64.tar.gz"
	$tmp_file = "/tmp/node-v$version-linux-x64.tar.gz"
	$install_dir = "/opt/node-v$version-linux-x64"

	# notify { 'configured' :
	# 	message => "package url: '$pkg_url'"
	# }
}

class nodejs inherits nodejs::params {

	#include nodejs::params("0.10.5")
	
	exec {

		"get_nodejs" :
			cwd => '/tmp',
			command => "/usr/bin/wget $nodejs::params::pkg_url",
			creates => "$tmp_file";

		"unpack_node-js" :
			cwd => '/opt',
			command => "/bin/tar -xzf $nodejs::params::tmp_file",
			creates => "$nodejs::params::install_dir",
			require => Exec['get_nodejs'];
	}

	notify { 'installed' :
		message => "node.js has been installed to $nodejs::params::install_dir",
		require => Exec['unpack_node-js']
	}
}
