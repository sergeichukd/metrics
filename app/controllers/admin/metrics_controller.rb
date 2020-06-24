require './app/validators/contracts/metric_contract.rb'

class Admin::MetricsController < Admin::BaseController

  def edit
    @metric = Metric.find(params[:id])
  end

  def update
    @metric = Metric.find(params[:id])
    respond_to do |format|

      permitted_params = params.require(:metric).permit(:cold, :hot)
      result = MetricContract.new.call(permitted_params.to_h)

      if result.success?
        @metric.update(result.to_h)
        format.html { redirect_to show_user_path(@metric.user), notice: 'Metric was successfully updated.' }
      else
        flash.now[:metric_edit_error] = result.errors.to_h
        format.html { render :edit }
      end
    end
  end

  private

  # def metric_params111
  #   permitted_params = params.require(:metric).permit(:cold, :hot)
  #   MetricContract.new.call(permitted_params.to_h)
  # end
end
