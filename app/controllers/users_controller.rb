class UsersController < ApplicationController
  skip_before_action :ensure_password_changed!

  def new_password
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user.update(user_params)
      @user.update(has_default_password: false)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to_index
    else
      render :new_password
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def redirect_to_index
    if current_user.is_admin
      redirect_to index_path
    else
      redirect_to root_path
    end
  end
end
