class Order < ApplicationRecord
  scope :ordered, -> { order(created_at: :desc) }
end
