# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    if current_user.has_default_password
      new_password_path
    elsif current_user.is_admin
      index_path
    else
      root_path
    end
  end
end
