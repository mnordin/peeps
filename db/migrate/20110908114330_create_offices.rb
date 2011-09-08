class CreateOffices < ActiveRecord::Migration
  def self.up
    create_table :offices do |t|
      t.string :name
      t.references :locale

      t.timestamps
    end
  end

  def self.down
    drop_table :offices
  end
end
