class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :text

      t.timestamps null: false
    end
  end
end
