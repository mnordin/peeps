class DestroyDuplicateScores < ActiveRecord::Migration

  class Array
    def uniq_by(&blk)
      transforms = {}
      select do |el|
        t = blk[el]
        should_keep = !transforms[t]
        transforms[t] = true
        should_keep
      end
    end
  end

  def self.up
    uniq_scores = Score.all.uniq_by { |s| s.user_id and s.total_score }
    Score.destroy_all
    uniq_scores.each do |unique_score|
      Score.create({
        :id => unique_score.id,
        :correct_peeps => unique_score.correct_peeps,
        :duration => unique_score.duration,
        :user_id => unique_score.user_id,
        :office_id => unique_score.office_id,
        :created_at => unique_score.created_at,
        :updated_at => unique_score.updated_at,
        :incorrect_peeps => unique_score.incorrect_peeps,
        :total_score => unique_score.total_score
      })
#<Score id: 1964, correct_peeps: 48, duration: 0, user_id: 67, office_id: 0, created_at: "2011-09-13 13:05:28", updated_at: "2011-09-13 13:05:28", incorrect_peeps: 0, total_score: 48>
    end
  end

  def self.down
  end
end
