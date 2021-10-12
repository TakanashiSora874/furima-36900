class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :image, presence: { message: 'をアップロードしてください' }
  validates :title, presence: { message: 'を入力してください' }
  validates :title, length: { maximum: 40, too_long: "は40文字以内で入力してください" }
  validates :explanation, presence: { messages: 'を入力してください' }
  validates :explanation, length: { maximum: 1000, too_long: "は1000文字以内で入力してください" }
  validates :category_id, presence: { message: 'を選択してください' }
  validates :status_id, presence: { message: 'を選択してください' }
  validates :delivery_fee_id, presence: { message: 'を選択してください' }
  validates :delivery_area_id, presence: { message: 'を選択してください' }
  validates :delivery_day_id, presence: { message: 'を選択してください' }
  validates :price, presence: { message: 'を入力してください' }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "は300円〜9,999,999円の間で設定してください" }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :delivery_fee
  belongs_to :delivery_area
  belongs_to :delivery_day
end