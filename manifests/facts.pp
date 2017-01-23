# == Class: mcollective::facts
#
# This module sets a positive value read by facts::cronjob
#
# === Example
#
# include mcollective::facts
#
# === DEPRECATED
#

# This looks weird, huh? Going away soon.
class mcollective::facts inherits mcollective::facts::cronjob {
  warning('class is deprecated')
}
