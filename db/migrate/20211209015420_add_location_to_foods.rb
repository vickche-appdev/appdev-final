class AddLocationToFoods < ActiveRecord::Migration[6.0]
  def change
    add_column :foods, :location, :string
  
  end
end
