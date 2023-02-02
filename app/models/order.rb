class Order < ApplicationRecord
  scope :ordered, -> { order(updated_at: :desc) }
end
