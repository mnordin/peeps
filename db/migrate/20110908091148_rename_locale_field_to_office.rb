class RenameLocaleFieldToOffice < ActiveRecord::Migration
  def self.up
    rename_column :users, :locale, :office
  end

  def self.down
    rename_column :users, :office, :locale
  end
end
