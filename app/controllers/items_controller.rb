class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :item_set, only: [:edit, :show, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def item_set
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image, :title, :description, :category_id, :condition_id, :shipping_fee_id, :prefecture_id,
                                 :delivery_day_id, :price).merge(user_id: current_user.id)
  end

  def correct_user
    return if @item.user_id == current_user.id

    redirect_to root_path
  end
end
