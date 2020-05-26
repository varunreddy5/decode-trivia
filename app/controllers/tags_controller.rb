class TagsController < ApplicationController
  before_action :authenticate_user!
  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag
    else
      render json: { errors: @tag.errors.full_messages }
    end
  end
  def index
    @tags = Tag.all
  end
  private
  def tag_params
    params.require(:tag).permit(:name, :description)
  end
end