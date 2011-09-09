class AddTotalScoreToScore < ActiveRecord::Migration
  def self.up
    add_column :scores, :total_score, :integer, :default => 0
  end

  def self.down
    remove_column :scores, :total_score
  end
end
