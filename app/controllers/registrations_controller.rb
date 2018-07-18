#
# Manage user registrations
#
class RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper
  layout 'application'

end