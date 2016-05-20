class CreateDiaries < ActiveRecord::Migration
  def change
    create_table :diaries do |t|
      t.string :title,:null => false,default:''
      t.string :content,:null => false,default:''
      t.integer :uid, :null => false, default:0
      t.integer :diary_id, :null => false, default:0
      
      t.timestamps null: false
    end
  end
end
