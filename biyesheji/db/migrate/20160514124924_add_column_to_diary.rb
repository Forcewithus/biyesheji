class AddColumnToDiary < ActiveRecord::Migration
  def change
    add_column :diaries,:picture_url,:string
    add_column :diaries,:voice_url,:string
  end
end
