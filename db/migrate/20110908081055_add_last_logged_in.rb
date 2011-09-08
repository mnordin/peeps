class AddLastLoggedIn < ActiveRecord::Migration
  def self.up
    add_column :users, :last_logged_in, :datetime
  end

  def self.down
    remove_column :users, :last_logged_in
  end
end
