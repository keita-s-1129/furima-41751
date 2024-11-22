class OrdersController < ApplicationController
  before_action :item_set, only: [:index, :create]
  def index
    @order_form = OrderForm.new
  end

  def new
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      @order_form.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def item_set
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_form).permit(:post_code, :prefecture_id, :city, :address, :building_name,
                                       :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
