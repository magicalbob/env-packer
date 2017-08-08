node default {
  include ntp
  include hosts
  include sshd
  include users
  include sudoers
  include firewall
  include lynis
}
