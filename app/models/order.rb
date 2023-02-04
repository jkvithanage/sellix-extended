class Order < ApplicationRecord
  self.primary_key = :uniqid

  scope :ordered, -> { order(created_at: :desc) }
end
