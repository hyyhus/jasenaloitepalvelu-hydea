class AddVisibleToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :visible, :boolean
  end
end
