class Order < ApplicationRecord
  scope :ordered, -> { order(created_at: :desc) }
  paginates_per 10
end
