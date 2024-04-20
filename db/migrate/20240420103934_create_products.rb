class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :product_code
      t.string :product_name
      t.decimal :product_price, precision: 8, scale: 2

      t.timestamps
    end
    add_index :products, :product_code, unique: true
  end
end
