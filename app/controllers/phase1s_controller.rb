class Phase1sController < ApplicationController
  
  def index
    if params[:page].nil? || params[:page].empty?
      @current_page = 1
    else
      @current_page = params[:page].to_i
    end
    offset = (@current_page-1)*10
    @pages = Phase1.all.count.div 10 + 1
    @phase1s= Phase1.all.order(updated_at: :desc).limit(10).offset(offset)
  end
end