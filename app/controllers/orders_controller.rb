class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_set, only: [:index, :create]
  before_action :sold_out_item, only: [:index, :create, :show]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_form = OrderForm.new
  end

  def new
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new(order_form_params)
    if @order_form.valid?
      pay_item
      @order_form.save(params[:item_id], current_user.id)
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def item_set
    @item = Item.find(params[:item_id])
  end

  def order_form_params
    params.require(:order_form).permit(:post_code, :prefecture_id, :city, :address, :building_name,
                                       :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵（環境変数化）
    Payjp::Charge.create(
      amount: @item.price,             # 商品の値段
      card: order_form_params[:token], # カードトークン
      currency: 'jpy'                  # 通貨の種類（日本円）
    )
  end

  def sold_out_item
    return unless @item.user_id == current_user.id || !@item.order.nil?

    redirect_to root_path
  end
end
