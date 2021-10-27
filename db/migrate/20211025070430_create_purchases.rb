class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.string :address_number,     null: false
      t.integer :delivery_area_id,  null: false
      t.string :address_middle,     null: false
      t.string :address_bottom,     null: false
      t.string :address_detail
      t.string :phone_number,       null: false
      t.references :order_history,   null: false, foreign_key: true
      t.timestamps
    end
  end
end
