class ItemsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
  end

  def update
  end

  def destroy
  end

  private

  def message_params
    params.require(:item).permit(:title, :image, :description, :category_id, :description_id, :condition_id, :price,
                                 :prefecture_id).merge(user_id: current_user.id)
  end
end
