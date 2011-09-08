class AddCodesToLocalesAndOffices < ActiveRecord::Migration
  def self.up
    add_column :offices, :code, :string
    add_column :locales, :code, :string
  end

  def self.down
    remove_column :offices, :code
    remove_column :locales, :code
  end
end
