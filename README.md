# テーブル設計

## usersテーブル

| Column             | Type   | Options                  |
| ------------------ | ------ | ------------------------ |
| nickname           | string | null: false              |
| email              | string | null: false unique: true |
| encrypted_password | string | null: false              |
| first_name         | string | null: false              |
| last_name          | string | null: false              |
| first_name_kana    | string | null: false              |
| last_name_kana     | string | null: false              |
| birthday           | date   | null: false              |

### Association

- has_many :items
- has_many :comments
- has_many :order_histories
- has_many :favorites

## itemsテーブル

| Column           | Type       | Options                       |
| ---------------- | ---------- | ----------------------------- |
| title            | string     | null: false                   |
| explanation      | text       | null: false                   |
| category_id      | integer    | null: false                   |
| status_id        | integer    | null: false                   |
| delivery_fee_id  | integer    | null: false                   |
| delivery_area_id | integer    | null: false                   |
| delivery_day_id  | integer    | null: false                   |
| price            | integer    | null: false                   |
| user             | references | null: false foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_one :order_history
- has_many :favorites

## commentsテーブル

| Column  | Type       | Options                       |
| ------- | ---------- | ----------------------------- |
| comment | Text       | null: false                   |
| user    | references | null: false foreign_key: true |
| item    | references | null: false foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## purchasesテーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| address_number | string     | null: false                    |
| delivery_area  | integer    | null: false                    |
| address_middle | string     | null: false                    |
| address_bottom | string     | null: false                    |
| address_detail | string     |                                |
| phone_number   | string     | null: false                    |
| order_history  | references | null: false                    |

### Association

- belongs_to :order_history

## order_historiesテーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: falser foreign_key: true |
| item     | references | null: falser foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :purchase

## favorites (user_item) テーブル

| Column | Type       | Options                       |
| ------ | ---------- | ----------------------------- |
| user   | references | null: false foreign_key: true |
| item   | references | null: false foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item