class AdminController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @metrics = Metric.where("user_id = '#{@user.id}'")
  end

  def show_statistics
  end

  def show_cold_statistics
    @users = User.all
    @users_max_cold_sorted_reversed = @users.sort_by{|user| -user.max_cold}
    @users_sorted_3_greater_cold = @users_max_cold_sorted_reversed.slice(0..2)
  end

  def show_hot_statistics
    @users = User.all
    @users_max_hot_sorted_reversed = @users.sort_by{|user| -user.max_hot}
    @users_sorted_3_greater_hot = @users_max_hot_sorted_reversed.slice(0..2)
  end

  def edit
    @metric = Metric.find(params[:id])
  end


  def update
    respond_to do |format|
      if @metric.update(metric_params)
        format.html { redirect_to @metric, notice: 'Metric was successfully updated.' }
        format.json { render :show, status: :ok, location: @metric }
      else
        format.html { render :edit }
        format.json { render json: @metric.errors, status: :unprocessable_entity }
      end
    end
  end  

  def new_user
    @user = User.new
  end

  # POST admin/users
  # POST admin/users.json
  def create_user
    @user = User.new(new_user_params)
    password = "#{new_user_params[:first_name]}#{new_user_params[:last_name]}"
    @user.password = password
    @user.password_confirmation = password


    respond_to do |format|
      if @user.save
        format.html { redirect_to index_path, notice: 'User was successfully created.' }
      else
        format.html { render :new_user, notice: 'Error. User is not created. Please try again.' }
      end
    end
  end


  private
    def new_user_params
      puts "!!!!!!!!!!!"
      puts params[:dimka_field]
      puts "!!!!!!!!!!!"
      params.require(:user).permit(:email, :first_name, :last_name, :is_admin, :login, :address)
    end

end
