require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '9項目の記入があれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザー登録できないとき' do
      it 'ニックネームが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'メールアドレスが空だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
      end

      it 'メールアドレスに@が含まれないと登録できない' do
        @user.email = 'samplegmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスは不正な値です")
      end

      it 'パスワードが空だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'パスワードは6文字以上でないと登録できない' do
        @user.password = 'admin'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it 'パスワードには英字と数字が含まれてないと登録できない' do
        @user.password = 'rinpana'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードには英字と数字の両方を含めて設定してください")
      end

      it 'パスワードとパスワード(確認)は一致していないと登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード(確認)とパスワードの入力が一致しません")
      end

      it 'お名前(名字)が空だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(名字)を入力してください")
      end

      it 'お名前(氏名)が空だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(氏名)を入力してください")
      end

      it 'お名前カナ(名字)が空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(名字)にはカタカナで入力してください")
      end

      it 'お名前カナ(氏名)が空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(氏名)にはカタカナで入力してください")
      end

      it 'お名前カナ(名字)がカタカナでないと登録できない' do
        @user.last_name_kana = 'かめだ'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(名字)にはカタカナで入力してください")
      end

      it 'お名前カナ(氏名)がカタカナでないと登録できない' do
        @user.first_name_kana = 'こうき'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(氏名)にはカタカナで入力してください")
      end

      it '生年月日が空だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を選択してください")
      end
    end
  end
end
