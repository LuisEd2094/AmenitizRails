class RenamePercentageToDivisor < ActiveRecord::Migration[7.1]
  def change
    rename_column :promotions, :discount_percent, :divisor
  end
end
