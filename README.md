# README

# テーブル設計 - FurimaのER図 -

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_kana         | string | null: false               |
| last_kana          | string | null: false               |
| birthday           | date   | null: false               |

### Association
- has_many :items
- has_many :orders


## items テーブル

| Column          | Type       | Options                         |
| --------------- | ---------- | ------------------------------- |
| user            | references | null: false, foreign_key: true  |
| title           | string     | null: false                     |
| description     | text       | null: false                     |
| category        | integer    | null: false                     |
| description     | integer    | null: false                     |
| condition       | integer    | null: false                     |
| delivery_price  | integer    | null: false                     |
| delivery_area   | integer    | null: false                     |
| delivery_day    | integer    | null: false                     |

### Association
- belongs_to :user
- has_one :orders


## orders テーブル

| Column          | Type       | Options                         |
| --------------- | ---------- | ------------------------------- |
| user            | references | null: false, foreign_key: true  |
| card_number     | string     | null: false                     |
| card_expiry     | string     | null: false                     |
| card_cvv        | string     | null: false                     |
| post_code       | string     | null: false                     |
| prefecture      | string     | null: false                     |
| municipalities  | string     | null: false                     |
| address         | string     | null: false                     |
| building_name   | string     | null: false                     |
| phone_number    | string     | null: false                     |

### Association
- belongs_to :user
- has_one :items