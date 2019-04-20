class AddDeletedAtColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at

    add_column :events, :deleted_at, :datetime
    add_index :events, :deleted_at

    add_column :performances, :deleted_at, :datetime
    add_index :performances, :deleted_at

    add_column :tickets, :deleted_at, :datetime
    add_index :tickets, :deleted_at
  end
end
