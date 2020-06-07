class MetricValidator < ActiveModel::Validator
    def validate(record)
        current_year = Date.today.year
        current_month = Date.today.month

        last_record = Metric.where("user_id = '#{record.user_id}'").order(:created_at).last
        if last_record.nil?
            return
        end

        last_record_year = last_record.created_at.year
        last_record_month = last_record.created_at.month

        if (current_year <= last_record_year) && (current_month <= last_record_month)
            record.errors[:date] << "Вы уже имеете актуальные показания на этот месяц"
            return
        end

        if (record.hot < last_record.hot) || (record.cold < last_record.cold)
            record.errors[:value] << "Введенные показания меньше последних: горячая: #{last_record.hot}, холодная: #{last_record.cold}"
        end

        if (record.hot < 0) || (record.cold < 0)
            record.errors[:value] << "Вводимые значения должны быть больше нуля"
        end
        
    end
end



class Metric < ApplicationRecord
    belongs_to :user
    
    validates_with MetricValidator
end
