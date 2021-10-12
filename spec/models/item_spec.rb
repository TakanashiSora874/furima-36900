require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/マホイップ.png')
  end

  context '出品できるとき' do
    it '情報に不足がなければ出品できる' do
      expect(@item).to be_valid
    end
  end

  context '出品できないとき' do
    it '画像が空では出品できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("商品画像をアップロードしてください")
    end

    it '商品名が空では出品できない' do
      @item.title = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("商品名を入力してください")
    end

    it '商品名が41文字以上だと出品できない' do
      @item.title = '12345678901234567890123456789012345678901'
      @item.valid?
      expect(@item.errors.full_messages).to include("商品名は40文字以内で入力してください")
    end

    it '商品の説明が空では出品できない' do
      @item.explanation = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("商品の説明を入力してください")
    end

    it '商品の説明が1001文字以上では出品できない' do
      @item.explanation = '12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901'
      @item.valid?
      expect(@item.errors.full_messages).to include("商品の説明は1000文字以内で入力してください")
    end

    it 'カテゴリーが空では出品できない' do
      @item.category_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("カテゴリーを選択してください")
    end

    it '商品の状態が空では出品できない' do
      @item.status_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("商品の状態を選択してください")
    end

    it '配送料の負担が空では出品できない' do
      @item.delivery_fee_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("配送料の負担を選択してください")
    end

    it '配送元の地域が空では出品できない' do
      @item.delivery_area_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("発送元の地域を選択してください")
    end

    it '配送までの日数が空では出品できない' do
      @item.delivery_day_id = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("発送までの日数を選択してください")
    end

    it '価格が空では出品できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("価格を入力してください")
    end

    it '価格が299円以下では出品できない' do
      @item.price = '200'
      @item.valid?
      expect(@item.errors.full_messages).to include("価格は300円〜9,999,999円の間で設定してください")
    end

    it '価格が10,000,000円以上では出品できない' do
      @item.price = '10000000'
      @item.valid?
      expect(@item.errors.full_messages).to include("価格は300円〜9,999,999円の間で設定してください")
    end

    it 'ユーザーが紐づいていないと出品できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Userを入力してください")
    end
  end
end
