class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  belongs_to :category
  belongs_to :description
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :delivery_day

  validates :category_id, numericality:      { other_than: 1, message: "can't be blank" }
  validates :status_id, numericality:        { other_than: 1, message: "can't be blank" }
  validates :shipping_fee_id, numericality:  { other_than: 1, message: "can't be blank" }
  validates :prefecture_id, numericality:    { other_than: 1, message: "can't be blank" }
  validates :delivery_time_id, numericality: { other_than: 1, message: "can't be blank" }
end
