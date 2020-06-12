class UserValidator < ActiveModel::Validator
  def validate(record)
      
    user_in_db = User.where(login: record.login).take
    if !user_in_db.nil?
      record.errors[:unique_login] << "Пользователь с таким логином уже существует"
      return
    end
  end
end



class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
        #  :registerable,
        #  :recoverable, 
         :rememberable, 
         :validatable

  has_many :metrics, dependent: :destroy

  def max_cold
    # Metric.select("max(cold)").where("user_id = #{self.id}")
    Metric.where("user_id = #{self.id}").maximum("cold")
  end

  def max_hot
    # Metric.select("max(cold)").where("user_id = #{self.id}")
    Metric.where("user_id = #{self.id}").maximum("hot")
  end

  validates_with UserValidator

end
