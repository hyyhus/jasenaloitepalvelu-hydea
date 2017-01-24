class CreateJoinTableIdeaTag < ActiveRecord::Migration
  def change
    create_join_table :Ideas, :Tags do |t|
      # t.index [:idea_id, :tag_id]
      # t.index [:tag_id, :idea_id]
    end
  end
end
