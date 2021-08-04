class RenameTypeToVarietyInCocktails < ActiveRecord::Migration[6.1]
  def up
    rename_column :cocktails, :type, :variety
  end

  def down
    rename_column :cocktails, :variety, :type
  end
end
