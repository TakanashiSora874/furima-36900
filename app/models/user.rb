class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :order_histories

  validates :nickname, presence: { message: 'を入力してください' }
  
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

  validates :last_name, presence: { message: 'を入力してください' }
  validates :first_name, presence: { message: 'を入力してください' }

  NAME_REGEX = /\A(?=.*?[あ-んァ-ヶ一-龥々ー])[あ-んァ-ヶ一-龥々ー]+\z/i.freeze
  validates_format_of :last_name, with: NAME_REGEX, message: 'には全角で入力してください'
  validates_format_of :first_name, with: NAME_REGEX, message: 'には全角で入力してください'

  validates :last_name_kana, presence: { message: 'を入力してください' }
  validates :first_name_kana, presence: { message: 'を入力してください' }

  NAMEKANA_REGEX = /\A(?=.*?[ァ-ヶ])[ァ-ヶ]+\z/i.freeze
  validates_format_of :last_name_kana, with: NAMEKANA_REGEX, message: 'にはカタカナで入力してください'
  validates_format_of :first_name_kana, with: NAMEKANA_REGEX, message: 'にはカタカナで入力してください'

  validates :birthday, presence: { message: 'を選択してください' }
end
