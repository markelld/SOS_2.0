class AddUserIdToCocktails < ActiveRecord::Migration[6.1]
  def change
    add_column :cocktails, :user_id, :integer
    add_index :cocktails, :user_id
  end
end
