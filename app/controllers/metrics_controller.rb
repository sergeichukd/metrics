class MetricsController < ApplicationController
  before_action :authenticate_user!

  def index
    @metrics = Metric.where(user_id: current_user.id)
  end

  def new
    @metric = Metric.new
  end

  def create
    @metric = Metric.new(metric_params)
    @metric.user_id = current_user.id

    respond_to do |format|
      if @metric.save(context: :client_context)
        format.html { redirect_to root_path, notice: 'Metric was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def metric_params
    params.require(:metric).permit(:cold, :hot)
  end
end
