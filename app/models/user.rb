class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  has_many :budgets
  has_many :needs
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable
end
