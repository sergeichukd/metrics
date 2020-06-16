class Admin::BaseController < ApplicationController
  before_action :ensure_admin_user!

  private

  def ensure_admin_user!
    unless current_user&.is_admin
      redirect_to root_path
    end
  end
end
