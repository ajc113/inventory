class AddTypeInLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :locations, :type, :string
  end
end
