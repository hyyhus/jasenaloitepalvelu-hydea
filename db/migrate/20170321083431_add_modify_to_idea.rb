class AddModerateToIdea < ActiveRecord::Migration[5.0]
  def change
    add_column :ideas, :moderate, :boolean
  end
end
