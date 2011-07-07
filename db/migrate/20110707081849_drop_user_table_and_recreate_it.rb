class DropUserTableAndRecreateIt < ActiveRecord::Migration
  def self.up
    drop_table :users
    
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :photo_url
      t.string :locale

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end