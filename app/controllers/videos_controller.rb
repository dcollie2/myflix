class VideosController < ApplicationController
  def index
    @categories = Category.all.order(:label)
  end

  def show
    @video = Video.find(params[:id])
  end
end
