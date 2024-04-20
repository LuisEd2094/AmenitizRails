class RenameProductColumns < ActiveRecord::Migration[7.1]
  def change
    rename_column :products, :product_code, :code
    rename_column :products, :product_name, :name
    rename_column :products, :product_price, :price
  end
end
