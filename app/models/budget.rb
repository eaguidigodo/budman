class Budget < ApplicationRecord
    belongs_to :user
    has_many :needs
    has_many :expenses, dependent: :destroy

    validates :amount, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true

    accepts_nested_attributes_for :needs, allow_destroy: true, reject_if: :all_blank
end
