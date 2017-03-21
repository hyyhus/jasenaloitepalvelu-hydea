class AddModifyToIdea < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :moderate, :boolean
  end
end
