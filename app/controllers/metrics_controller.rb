class MetricsController < ApplicationController
  # before_action :set_metric, only: [:show, :edit, :update, :destroy]

  # GET /metrics
  # GET /metrics.json
  def index
    @metrics = Metric.where("user_id = '#{current_user.id}'")
  end

  # GET /metrics/1
  # GET /metrics/1.json
  # def show
  # end

  # GET /metrics/new
  def new
    @metric = Metric.new
  end

  # GET /metrics/1/edit
  # def edit
  # end

  # POST /metrics
  # POST /metrics.json
  def create
    @metric = Metric.new(metric_params)
    @metric.user_id = current_user.id

    respond_to do |format|
      if @metric.save
        format.html { redirect_to @metric, notice: 'Metric was successfully created.' }
        format.json { render :show, status: :created, location: @metric }
      else
        format.html { render :new }
        format.json { render json: @metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metrics/1
  # PATCH/PUT /metrics/1.json
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

  # DELETE /metrics/1
  # DELETE /metrics/1.json
  # def destroy
  #   @metric.destroy
  #   respond_to do |format|
  #     format.html { redirect_to metrics_url, notice: 'Metric was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metric
      @metric = Metric.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def metric_params
      params.require(:metric).permit(:cold, :hot)
    end
end
