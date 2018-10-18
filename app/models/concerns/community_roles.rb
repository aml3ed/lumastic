#
# Constants for community roles
#
module CommunityRoles
  ROLE_NONE = 'none'.freeze unless defined? ROLE_NONE
  ROLE_MEMBER = 'member'.freeze unless defined? ROLE_CURATOR
  ROLE_CONTRIBUTOR = 'contributor'.freeze unless defined? ROLE_STUDENT
  ROLE_CURATOR = 'curator'.freeze unless defined? ROLE_ADMIN
  ALL_ROLES = [ROLE_NONE, ROLE_MEMBER, ROLE_CONTRIBUTOR, ROLE_CURATOR].freeze unless defined? ALL_ROLES
end
