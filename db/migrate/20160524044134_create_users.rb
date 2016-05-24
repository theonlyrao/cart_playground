class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :url
      t.string :token

      t.timestamps null: false
    end
  end
end
