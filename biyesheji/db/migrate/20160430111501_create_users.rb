class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_token, :null => false, default:'',:unique => true
      t.string :name, :null => false, default:''
      t.string :passwd, :null =>false, default:''

      t.timestamps null: false
    end
  end
end
