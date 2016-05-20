class AddImagesToDiaries < ActiveRecord::Migration
  def up
    add_attachment :diaries, :photo
  end

  def down
    remove_attachment :diaries, :photo
  end
end
