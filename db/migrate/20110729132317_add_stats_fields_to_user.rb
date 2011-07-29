class AddStatsFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :number_of_logins, :integer, :default => 0
    add_column :users, :number_of_completed_games, :integer, :default => 0
  end

  def self.down
    remove_column :users, :number_of_logins
    remove_column :users, :number_of_completed_games
  end
end
