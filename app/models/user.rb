class User < ApplicationRecord
  devise :database_authenticatable,
         :rememberable,
         :validatable,
         authentication_keys: [:login]

  has_many :metrics, dependent: :destroy

  validates :login, uniqueness: true, on: :create
  validates :login, :first_name, :last_name, :address, presence: true

  def set_password(password)
    self.password = password
    self.password_confirmation = password
  end

  def make_default_password(user_params)
    "#{user_params[:first_name]}#{user_params[:last_name]}"
  end

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

end
