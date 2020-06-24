require './app/validators/contracts/metric_client_contract.rb'

class MetricsController < ApplicationController
  before_action :authenticate_user!

  def index
    @metrics = Metric.where(user_id: current_user.id)
  end

  def new
    @metric = Metric.new
  end

  def create
    # @metric = Metric.new(metric_params)
    # @metric.user_id = current_user.id

    respond_to do |format|
      if metric_params.success?
        Metric.new(metric_params)
        format.html { redirect_to root_path, notice: 'Metric was successfully created.' }
      else
        flash.now[:metric_edit_error] = metric_params.errors.to_h
        format.html { render :new }
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def metric_params
    permitted_params = params.require(:metric).permit(:cold, :hot)
    permitted_params[:user_id] = current_user.id
    MetricClientContract.new.call(permitted_params.to_h)
  end
end
