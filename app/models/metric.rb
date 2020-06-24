class MetricValidator < ActiveModel::Validator
  def validate(record)
    if metric_nil? record
      record.errors[:value] << I18n.t('metrics.error.empty_fields')
      return
    end

    if metric_negative? record
      record.errors[:value] << I18n.t('metrics.error.value_negative')
    end
  end

  private

  def metric_negative?(record)
    record.hot.negative? || record.cold.negative?
  end

  def metric_nil?(record)
    !(record.hot && record.cold)
  end
end

class MetricClientValidator < ActiveModel::Validator
  def validate(record)
    @last_record = Metric.where(user_id: record.user_id).first
    if @last_record.nil?
      return
    end

    if not_actual_metric?
      record.errors[:date] << I18n.t('metrics.error.have_actual_records')
      return
    end

    if metric_decreased?(record)
      record.errors[:value] << I18n.t('metrics.error.value_decreased', hot: @last_record.hot, cold: @last_record.cold)
    end
  end

  private

  def not_actual_metric?
    current_year = Date.today.year
    current_month = Date.today.month

    last_record_year = @last_record.created_at.year
    last_record_month = @last_record.created_at.month

    (current_year <= last_record_year) && (current_month <= last_record_month)
  end

  def metric_decreased?(record)
    (record.hot < @last_record.hot) || (record.cold < @last_record.cold)
  end
end

class Metric < ApplicationRecord
  belongs_to :user

  default_scope { order('created_at DESC') }

  validates_with MetricValidator
  validates_with MetricClientValidator, on: :client_context
end
