class ScoreController < ApplicationController
  def index
    render :json => Score.all, :layout => false
  end

  def create
    @score = Score.new(params[:score])
    if @score.save
      render :json => @score.to_yaml.to_json, :layout => false
    else
      render :json => @score.errors.full_messages, :layout => false
    end
  end

  def highscore
    if params[:office] == "all"
      scores = Score.order("total_score desc, created_at desc").limit(5)
    else
      scores = Score.where(:office_id => Office.find_by_code(params[:office]).id).order("total_score desc,  created_at desc").limit(5)
    end
    highscores_with_users = []
    scores.each do |score|
      highscores_with_users << [score, score.user]
    end
    render :json => highscores_with_users, :layout => false
  end

end