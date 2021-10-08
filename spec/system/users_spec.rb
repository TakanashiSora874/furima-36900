require 'rails_helper'

RSpec.describe "ユーザー新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー登録できるとき' do
    it '正しい情報を入力すればユーザー登録できる' do
      # トップページに移動
      visit root_path
      # トップページに新規登録ページへのボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動
      visit new_user_registration_path
      # ユーザー情報を入力
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      fill_in 'last-name', with: @user.last_name
      fill_in 'first-name', with: @user.first_name
      fill_in 'last-name-kana', with: @user.last_name_kana
      fill_in 'first-name-kana', with: @user.first_name_kana
      select 'birth-date', with: @user.birthday
      # 会員登録を押すとユーザーモデルのカウントが1上がる
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq(root_path)
      # ユーザー名とログアウトボタンが表示されている
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('ログアウト')
      # 新規登録ページへのボタンやログインボタンがない
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ユーザー登録ができないとき' do
    it '間違った情報ではユーザー登録できない' do
      # トップページに移動する
      visit root_path
      # トップページに新規登録ページへのボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動
      visit new_user_registration_path
      # ユーザー情報を入力
      fill_in 'nickname', with: ''
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      fill_in 'password-confirmation', with: ''
      fill_in 'last-name', with: ''
      fill_in 'first-name', with: ''
      fill_in 'last-name-kana', with: ''
      fill_in 'first-name-kana', with: ''
      # 会員登録ボタンを押してもユーザーモデルのカウントは上がらない
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻される
      expect(current_path).to eq(user_registration_path)
    end
  end

end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # トップページに移動
      visit root_path
      # ログインページへのボタンがある
      expect(page).to have_content('ログイン')
      # ログインページへ移動
      visit new_user_session_path
      # ユーザー情報の入力
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ戻される
      expect(current_path).to eq(root_path)
      # ユーザー名とログアウトボタンが表示されている
      expect(page).to have_content(@user.nickname)
      expect(page).to have_content('ログアウト')
      # ログインと新規登録のボタンは表示されていない
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end

  context 'ログインできないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # トップページに移動
      visit root_path
      # ログインページへのボタンがある
      expect(page).to have_content('ログイン')
      # ログインページへ移動
      visit new_user_session_path
      # ユーザー情報の入力
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      # ログインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻される
      expect(current_path).to eq(new_user_session_path)
    end
  end
end