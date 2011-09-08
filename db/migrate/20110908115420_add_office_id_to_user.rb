class AddOfficeIdToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :office_id, :integer
    remove_column :users, :office
  end

  def self.down
    remove_column :users, :office_id
    add_column :users, :office, :string
  end
end
