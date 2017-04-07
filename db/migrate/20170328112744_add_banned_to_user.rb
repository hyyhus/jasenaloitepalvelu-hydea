class AddBannedToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :banned, :boolean
  end
end
