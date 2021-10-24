class Budget < ApplicationRecord
    belongs_to :user
    has_many :needs

    accepts_nested_attributes_for :needs, allow_destroy: true, reject_if: :all_blank
end
