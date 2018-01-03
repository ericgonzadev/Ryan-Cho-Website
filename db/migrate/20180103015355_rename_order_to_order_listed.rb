class RenameOrderToOrderListed < ActiveRecord::Migration[5.0]
  def change
    rename_column :projects, :order, :order_listed
  end
end
