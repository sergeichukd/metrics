class User < ApplicationRecord
  devise :database_authenticatable,
         :rememberable,
         :validatable,
         authentication_keys: [:login]

  has_many :metrics, dependent: :destroy

  validates :login, uniqueness: true, on: :create
  validates :login, :email, :first_name, :last_name, :address, presence: true

  def max_cold
    Metric.where(user_id: self.id).maximum(:cold)
  end

  def max_hot
    Metric.where(user_id: self.id).maximum(:hot)
  end

  def set_password(password)
    self.password = password
    self.password_confirmation = password
  end

  def make_default_password(user_params)
    user_params[:first_name] << user_params[:last_name]
  end
end
