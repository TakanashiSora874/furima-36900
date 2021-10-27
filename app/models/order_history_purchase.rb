class OrderHistoryPurchase
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :address_number, :delivery_area_id, :address_middle, :address_bottom, :address_detail, :phone_number, :order_history_id, :token

  validates :token, presence: { message: "を正しく入力してください" }
  validates :delivery_area_id, presence: { message: "を選択してください" }
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :address_number
    validates :address_middle
    validates :address_bottom
    validates :phone_number
  end
  validates :address_number, format: { with: /\A[0-9]{3}-[0-9]{4}\Z/, message: 'には-(ハイフン)を入れて、(3ケタ)-(4ケタ)の形で入力してください', allow_blank: true }
  validates :phone_number, numericality: { message: 'は半角数字で入力してください', allow_blank: true }
  validates :phone_number, length: { minimum: 10, maximum: 11, message: 'は-(ハイフン)なしで10ケタまたは11ケタで入力してください', allow_blank: true }
  def save
    order_history = OrderHistory.create(user_id: user_id, item_id: item_id)
    Purchase.create(address_number: address_number, delivery_area_id: delivery_area_id, address_middle: address_middle, address_bottom: address_bottom, address_detail: address_detail, phone_number: phone_number, order_history_id: order_history.id)
  end
end