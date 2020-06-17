class Admin::MetricsController < ApplicationController
  def edit
    @metric = Metric.find(params[:id])
  end

  def update
    @metric = Metric.find(params[:id])
    respond_to do |format|
      if @metric.update(metric_params)
        format.html { redirect_to show_user_path(@metric.user), notice: 'Metric was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def metric_params
    params.require(:metric).permit(:cold, :hot)
  end
end
