class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_set, only: [:index, :create]

  def index
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
    Payjp.api_key = 'sk_test_7872f0364472cc0d4b586d15' # 自身のPAY.JPテスト秘密鍵
    Payjp::Charge.create(
      amount: @item.price,             # 商品の値段
      card: order_form_params[:token], # カードトークン
      currency: 'jpy'                  # 通貨の種類（日本円）
    )
  end
end
