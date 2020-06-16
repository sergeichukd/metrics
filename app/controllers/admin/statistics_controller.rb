class Admin::StatisticsController < Admin::BaseController
  def index
  end

  def cold
    @top_3_max_cold_consumers = get_max_3_water_cunsumers :cold
  end

  def hot
    @top_3_max_hot_consumers = get_max_3_water_cunsumers :hot
  end

  private

  def get_max_3_water_cunsumers(water_type)
    User.joins(:metrics)
        .select("users.*, max(metrics.#{water_type}) as maximum")
        .group('users.id')
        .order(maximum: :desc)
        .limit(3)
  end
end
