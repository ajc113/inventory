class CreateTransferRequest < ActiveRecord::Migration[7.1]
  def change
    create_table :transfer_requests do |t|
      t.integer :quantity, null: false
      t.belongs_to :flavor, null: false
      t.belongs_to :to_location, null: false, foreign_key: { to_table: :locations }
      t.belongs_to :from_location, null: false, foreign_key: { to_table: :locations }

      t.timestamps
    end
  end
end
