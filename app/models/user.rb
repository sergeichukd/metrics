class UserValidator < ActiveModel::Validator
end


class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
        #  :registerable,
        #  :recoverable, 
         :rememberable, 
         :validatable,
         authentication_keys: [:login]

  has_many :metrics, dependent: :destroy

  validates :login, uniqueness: true, on: :create

  def max_cold
    Metric.where("user_id = #{self.id}").maximum("cold")
  end

  def max_hot
    Metric.where("user_id = #{self.id}").maximum("hot")
  end

end
