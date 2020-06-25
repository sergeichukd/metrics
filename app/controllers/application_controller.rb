class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :ensure_password_changed!

  private

  def ensure_password_changed!
    if current_user&.has_default_password
      redirect_to new_password_path
    end
  end
end
