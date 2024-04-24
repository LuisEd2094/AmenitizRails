class CreatePromotions < ActiveRecord::Migration[7.1]
  def change
    create_table :promotions do |t|
      t.decimal :divisor, precision: 5, scale: 2
      t.integer :condition
      t.string :discount_type

      t.timestamps
    end
  end
end
