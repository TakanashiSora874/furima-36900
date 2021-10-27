require 'rails_helper'

RSpec.describe OrderHistoryPurchase, type: :model do
  before do
    item = FactoryBot.create(:item)
    @order = FactoryBot.build(:order_history_purchase, user_id: item.user_id, item_id: item.id)
    sleep 0.1
  end

  context '購入できるとき' do
    it '情報に不足がなければ購入できる' do
      expect(@order).to be_valid
    end

    it '建物名はなくても購入できる' do
      @order.address_detail = ''
      expect(@order).to be_valid
    end
  end

  context '購入できないとき' do
    it 'tokenが生成できていないと購入できない' do
      @order.token = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("カード情報を正しく入力してください")
    end

    it '郵便番号がないと購入できない' do
      @order.address_number = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("郵便番号を入力してください")
    end

    it '郵便番号は(3ケタ)-(4ケタ)の形でないと購入できない' do
      @order.address_number = '1234567'
      @order.valid?
      expect(@order.errors.full_messages).to include("郵便番号には-(ハイフン)を入れて、(3ケタ)-(4ケタ)の形で入力してください")
    end

    it '都道府県は選択しないと購入できない' do
      @order.delivery_area_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("都道府県を選択してください")
    end
    
    it '市区町村が空では購入できない' do
      @order.address_middle = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("市区町村を入力してください")
    end

    it '番地が空では購入できない' do
      @order.address_bottom = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("番地を入力してください")
    end

    it '電話番号が空では購入できない' do
      @order.phone_number = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("電話番号を入力してください")
    end

    it '電話番号は半角数字でないと購入できない' do
      @order.phone_number = '０９０１２３４５６７８'
      @order.valid?
      expect(@order.errors.full_messages).to include("電話番号は半角数字で入力してください")
    end

    it '電話番号は9ケタ以下では購入できない' do
      @order.phone_number = '123456789'
      @order.valid?
      expect(@order.errors.full_messages).to include("電話番号は-(ハイフン)なしで10ケタまたは11ケタで入力してください")
    end

    it '電話番号は12ケタ以上では購入できない' do
      @order.phone_number = '012345678901'
      @order.valid?
      expect(@order.errors.full_messages).to include("電話番号は-(ハイフン)なしで10ケタまたは11ケタで入力してください")
    end

    it '電話番号は-(ハイフン)が含まれていると購入できない' do
      @order.phone_number = '090-1234-5678'
      @order.valid?
      expect(@order.errors.full_messages).to include("電話番号は-(ハイフン)なしで10ケタまたは11ケタで入力してください")
    end

    it 'ユーザーが紐づいていないと購入できない' do
      @order.user_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Userを入力してください")
    end

    it '商品が紐づいていないと購入できない' do
      @order.item_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Itemを入力してください")
    end
  end
end
