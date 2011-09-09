class AddDefaultValueToScoreOfficeField < ActiveRecord::Migration
  def self.up
    change_column_default(:scores, :office_id, 0)
  end

  def self.down
    change_column_default(:scores, :office_id, nil)
  end
end
