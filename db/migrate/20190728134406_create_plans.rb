class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :remote_id
      t.string :name
      t.string :price
      t.integer :interval
      t.integer :interval_count
      t.integer :tickets_allowed
      t.string :ticket_category
      t.integer :status
      t.text :description

      t.timestamps
    end
  end
end
