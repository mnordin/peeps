class CreateScores < ActiveRecord::Migration
  def self.up
    create_table :scores do |t|
      t.integer :finished_peeps
      t.integer :duration
      t.references :user
      t.references :office

      t.timestamps
    end
  end

  def self.down
    drop_table :scores
  end
end
