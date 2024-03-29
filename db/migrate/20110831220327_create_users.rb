class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username, :null => false
      t.string :email, :null => false
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.boolean :active, :default => false, :null => false
      t.string :perishable_token, :default => "", :null => false


      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end