# テーブル設計

## usersテーブル

| Column             | Type   | Options                  |
| ------------------ | ------ | ------------------------ |
| nickname           | string | null: false              |
| email              | string | null: false unique: true |
| encrypted_password | string | null: false              |
| first_name         | string | null: false              |
| last_name          | string | null: false              |
| birthday           | date   | null: false              |

### Association

- has_many :items
- has_many :comments
- has_many :purchases
- has_many :favorites

## itemsテーブル

| Column        | Type       | Options                       |
| ------------- | ---------- | ----------------------------- |
| title         | string     | null: false                   |
| explanation   | text       | null: false                   |
| category      | string     | null: false                   |
| status        | string     | null: false                   |
| delivery_fee  | string     | null: false                   |
| delivery_area | string     | null: false                   |
| delivery_day  | string     | null: false                   |
| price         | integer    | null: false                   |
| user          | references | null: false foreign_key: true |

### Association

- belongs_to :user
- has_many :comments
- has_one :purchase
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
| card_number    | integer    | null: false                    |
| card_expiry    | date       | null: false                    |
| card_code      | integer    | null: false                    |
| address_number | string     | null: false                    |
| address_top    | string     | null: false                    |
| address_middle | string     | null: false                    |
| address_bottom | string     | null: false                    |
| address_detail | string     |                                |
| phone_number   | integer    | null: false                    |
| user           | references | null: falser foreign_key: true |
| item           | references | null: falser foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## favorites (user_item) テーブル

| Column | Type       | Options                       |
| ------ | ---------- | ----------------------------- |
| user   | references | null: false foreign_key: true |
| item   | references | null: false foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item