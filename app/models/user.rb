class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
        #  :registerable,
        #  :recoverable, 
         :rememberable, 
         :validatable

  has_many :metrics, dependent: :destroy

  def name
    "#{last_name} #{first_name}"
  end

end
