class MetricValidator < ActiveModel::Validator
  def validate(record)
    @last_record = Metric.where(user_id: record.user_id).first
    if @last_record.nil?
      return
    end

    if actual_metric?
      record.errors[:date] << 'Вы уже имеете актуальные показания на этот месяц'
      return
    end

    if metric_decreased? record
      record.errors[:value] << "Введенные показания меньше последних: горячая: #{@last_record.hot}, холодная: #{@last_record.cold}"
    end

    if metric_negative? record
      record.errors[:value] << 'Вводимые значения должны быть больше нуля'
    end
  end

  private

  def actual_metric?
    current_year = Date.today.year
    current_month = Date.today.month

    last_record_year = @last_record.created_at.year
    last_record_month = @last_record.created_at.month

    (current_year <= last_record_year) && (current_month <= last_record_month)
  end

  def metric_decreased?(record)
    (record.hot < @last_record.hot) || (record.cold < @last_record.cold)
  end

  def metric_negative?(record)
    record.hot.negative? || record.cold.negative?
  end
end

class Metric < ApplicationRecord
  belongs_to :user

  default_scope { order('created_at DESC') }

  validates :cold, :hot, presence: true
  validates_with MetricValidator, on: :create
end
