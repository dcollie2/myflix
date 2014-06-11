class VideosController < ApplicationController
  def index
    @categories = Category.all.order(:label)
  end
  
  def search
    @results = Video.search_by_title(params[:search_term])
  end

  def show
    @video = Video.find(params[:id])
  end
end
