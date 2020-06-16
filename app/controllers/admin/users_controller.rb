class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @metrics = Metric.where(user_id: @user.id)
  end

  def create
    @user = User.new(user_params)

    password = @user.make_default_password(user_params)
    @user.set_password password

    respond_to do |format|
      if @user.save
        format.html { redirect_to index_path, notice: 'User was successfully created.' }
      else
        format.html { render :new, notice: 'Error. User is not created. Please try again.' }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :is_admin, :login, :address)
  end
end
