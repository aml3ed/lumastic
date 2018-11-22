#
# Constants for a role
#
module Roleable
  ROLE_GUEST = 'guest'.freeze unless defined? ROLE_GUEST
  ROLE_STUDENT = 'student'.freeze unless defined? ROLE_STUDENT
  ROLE_ADMIN = 'dashboard'.freeze unless defined? ROLE_ADMIN
  ALL_ROLES = [ROLE_GUEST, ROLE_STUDENT, ROLE_ADMIN].freeze unless defined? ALL_ROLES
end
