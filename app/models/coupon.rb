class Coupon < ApplicationRecord
  scope :ordered, -> { order(code: :asc) }
end
