class AdminController < ApplicationController
  before_action :ensure_admin_user!

  def index
    @users = User.all
  end

  # User block
  def show_user
    @user = User.find(params[:id])
    @metrics = Metric.where(user_id: @user.id)
  end

  def new_user
    @user = User.new
  end

  def create_user
    @user = User.new(new_user_params)

    password = @user.make_default_password(new_user_params)
    @user.set_password password

    respond_to do |format|
      if @user.save
        format.html { redirect_to index_path, notice: 'User was successfully created.' }
      else
        format.html { render :new_user, notice: 'Error. User is not created. Please try again.' }
      end
    end
  end

  # Statistics block
  def show_statistics
  end

  def show_cold_statistics
    @users = User.all
    users_cold_not_nil = @users.select(&:max_cold)
    users_max_cold_sorted_reversed = users_cold_not_nil.sort_by{ |user| -user.max_cold }
    @users_sorted_3_greater_cold = users_max_cold_sorted_reversed.slice(0..2)
  end

  def show_hot_statistics
    @users = User.all
    users_hot_not_nil = @users.select(&:max_hot)
    users_max_hot_sorted_reversed = users_hot_not_nil.sort_by{|user| -user.max_hot}
    @users_sorted_3_greater_hot = users_max_hot_sorted_reversed.slice(0..2)
  end

  # Metric block
  def show_metric
    @metric = Metric.find(params[:id])
  end

  def update_metric
    @metric = Metric.find(params[:id])
    respond_to do |format|
      if @metric.update(metric_params)
        format.html { redirect_to show_user_path(@metric.user), notice: 'Metric was successfully updated.' }
      else
        format.html { render :show_metric }
      end
    end
  end

  private

  def ensure_admin_user!
    unless current_user&.is_admin
      redirect_to root_path
    end
  end

  def new_user_params
    params.require(:user).permit(:email, :first_name, :last_name, :is_admin, :login, :address)
  end

  def metric_params
    params.require(:metric).permit(:cold, :hot)
  end
end
