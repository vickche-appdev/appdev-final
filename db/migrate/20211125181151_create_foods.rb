class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.text :title
      t.text :caption
      t.integer :meals_avaliable
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end
