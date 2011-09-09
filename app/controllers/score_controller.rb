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

end
