# == Class: mcollective::facts
#
# This module installs a cron script that puts Puppet facts in a file for MCollective to use
#
class mcollective::facts::cronjob (
  $enable = true,
) inherits mcollective {

  $ensure = $enable ? {
    true  => 'present',
    false => 'absent',
  }

  $mco_etc  = $mcollective::etcdir
  $ruby_bin = "${mcollective::bindir}/ruby"

  file { '/opt/puppetlabs/puppet/bin/refresh-mcollective-metadata':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("${module_name}/refresh-mcollective-metadata.erb"),
  }

  $rnd_minute = fqdn_rand(15) # assure spread of the fact collection

  cron { 'mcollective-facts':
    ensure  => $ensure,
    command => '/opt/puppetlabs/puppet/bin/refresh-mcollective-metadata',
    minute  => "${rnd_minute}-59/15",
    require => File['/opt/puppetlabs/puppet/bin/refresh-mcollective-metadata'],
  }
}
