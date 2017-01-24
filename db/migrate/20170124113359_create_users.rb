class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.boolean :admin
      t.boolean :moderator
      t.string :persistent_id
      t.string :name
      t.string :email
      t.string :title

      t.timestamps null: false
    end
  end
end
