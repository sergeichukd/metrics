require './app/validators/contracts/metric_contract.rb'

class MetricClientContract < MetricContract
  # params(MetricSchema) do
  schema do
    required(:user_id).filled(:integer)
    required(:cold).filled(:integer)
    required(:hot).filled(:integer)
  end

  rule(:user_id, :cold, :hot) do
    last_record = Metric.where(user_id: values[:user_id]).first

    if last_record.nil?
      return
    end

    if not_actual_metric?(last_record)
      key.failure("You've already have actual records for current month")
    end

    if metric_decreased?(values, last_record)
      key.failure("Current metrics is less then the last record; hot: #{last_record.hot}, cold: #{last_record.cold}")
    end
  end

  private

  def not_actual_metric?(last_record)
    current_year = Date.today.year
    current_month = Date.today.month

    last_record_year = last_record.created_at.year
    last_record_month = last_record.created_at.month

    (current_year <= last_record_year) && (current_month <= last_record_month)
  end

  def metric_decreased?(values, last_record)
    (values[:hot] < last_record.hot) || (values[:cold].cold < last_record.cold)
  end
end
