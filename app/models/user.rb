class User < ApplicationRecord
  # Include default devise modules. Others available are:
  #  :lockable, :timeoutable and :omniauthable
  has_many :budgets, dependent: :delete_all
  has_many :needs, dependent: :delete_all
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable
end
