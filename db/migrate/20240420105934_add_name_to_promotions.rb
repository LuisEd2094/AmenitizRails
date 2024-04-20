class AddNameToPromotions < ActiveRecord::Migration[7.1]
  def change
    add_column :promotions, :name, :string
  end
end
