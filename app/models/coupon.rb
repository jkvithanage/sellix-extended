class Coupon < ApplicationRecord
  self.primary_key = :uniqid
  scope :ordered, -> { order(code: :asc) }
end
