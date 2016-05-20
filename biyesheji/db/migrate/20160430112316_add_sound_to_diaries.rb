class AddSoundToDiaries < ActiveRecord::Migration
  def up
    add_attachment :diaries, :sound
  end

  def down
    remove_attachment :diaries, :sound
  end
end
