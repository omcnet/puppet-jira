# == Class: jira::params
#
# Defines default values for jira module
#
class jira::params {

  Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

  case $::osfamily {
    /RedHat/: {
      # TODO: this should really be a fact telling us whether
      # we use systemd or not
      if $::operatingsystemmajrelease == '7' {
        $json_packages           = 'rubygem-json'
        $service_file_location   = '/usr/lib/systemd/system/jira.service'
        $service_file_template   = 'jira/jira.service.erb'
        $service_lockfile        = '/var/lock/subsys/jira'
      } elsif $::operatingsystemmajrelease == '6' {
        $json_packages           = [ 'rubygem-json', 'ruby-json' ]
        $service_file_location   = '/etc/init.d/jira'
        $service_file_template   = 'jira/jira.initscript.erb'
        $service_lockfile        = '/var/lock/subsys/jira'
      } elsif $::operatingsystem == "Fedora" {
        #TODO: make this a real comparison by number
        if $::operatingsystemmajrelease == "21" {
          $json_packages           = 'rubygem-json'
          $service_file_location   = '/usr/lib/systemd/system/jira.service'
          $service_file_template   = 'jira/jira.service.erb'
          $service_lockfile        = '/var/lock/subsys/jira' 
        }
      }
    } /Debian/: {
        $json_packages           = [ 'rubygem-json', 'ruby-json' ]
        $service_file_location   = '/etc/init.d/jira'
        $service_file_template   = 'jira/jira.initscript.erb'
        $service_lockfile        = '/var/lock/jira'
    } default: {
        $json_packages           = [ 'rubygem-json', 'ruby-json' ]
        $service_file_location   = '/etc/init.d/jira'
        $service_file_template   = 'jira/jira.initscript.erb'
        $service_lockfile        = '/var/lock/subsys/jira'
    }
  }
}
