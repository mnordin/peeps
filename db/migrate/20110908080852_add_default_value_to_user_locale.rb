class AddDefaultValueToUserLocale < ActiveRecord::Migration
  def self.up
    change_column_default(:users, :locale, "stockholm")
  end

  def self.down
    change_column_default(:users, :locale, nil)
  end
end
