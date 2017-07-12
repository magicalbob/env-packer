node default {
  scheduled_task { 'Puppet_Manifest':
    ensure    => present,
    enabled   => true,
    command   => 'C:\Windows\System32\cmd.exe',
    arguments => '/c puppet apply c:\vagrant\manifests\windows.pp',
    trigger   => {
      schedule   => daily,
      every      => 1,            # Specifies every other day. Defaults to 1 (every day).
      start_date => '2017-01-01', # Defaults to 'today'
      start_time => '00:01',      # Must be specified
      minutes_interval => '60',   # Repeat this task every 60 minutes
      minutes_duration => '300',  # The task will run for a total of five hours      
    }
  }
}
