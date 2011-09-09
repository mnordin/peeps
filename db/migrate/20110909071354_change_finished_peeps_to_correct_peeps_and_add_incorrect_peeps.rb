class ChangeFinishedPeepsToCorrectPeepsAndAddIncorrectPeeps < ActiveRecord::Migration
  def self.up
    rename_column :scores, :finished_peeps, :correct_peeps
    add_column :scores, :incorrect_peeps, :integer
  end

  def self.down
    rename_column :scores, :correct_peeps,  :finished_peeps
    remove_column :scores, :incorrect_peeps
  end
end
