# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  skip_before_action :ensure_password_changed!

  def after_sign_in_path_for(resource)
    if current_user.is_admin
      index_path
    else
      root_path
    end
  end
end
