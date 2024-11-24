class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token

  validates :user_id,  presence: true
  validates :item_id,  presence: true
  validates :city,     presence: true
  validates :address,  presence: true
  validates :token,    presence: true

  validates :post_code,     format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
  validates :phone_number,  format: { with: /\A[0-9]{10,11}\z/, message: 'must be 10 or 11 digits long' }
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save(item_id, user_id)
    order = Order.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(order_id: order.id, post_code: post_code, prefecture_id: prefecture_id, city: city, address: address,
                           building_name: building_name, phone_number: phone_number)
  end
end
